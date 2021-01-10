import 'package:concentration/constants/images.dart';
import 'package:concentration/constants/number_of_cards.dart';
import 'package:concentration/pages/game_screen.dart';
import 'package:concentration/pages/home_page.dart';
import 'package:concentration/widgets/primary_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/play_card.dart';

enum Difficulty { Easy, Moderate, Hard }

class CardsController extends GetxController {
  var cardColor = Rx<Color>();
  var backgroundColor = Rx<Color>();
  var cards = List<PlayCard>().obs;
  var allfaceupCards = List<PlayCard>().obs;
  var faceUpCards = List<PlayCard>().obs;
  var matchedCards = 0.obs;
  var level = Difficulty.Easy.obs;
  var totalImages = Images.totalImages;
  var score = 0.obs;
  var flipsCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    configure();
  }

  void configure() {
    faceUpCards.assignAll([]);
    fillCards();
    configureImage();
    matchedCards = 0.obs;
    score = 0.obs;
    flipsCount = 0.obs;
  }

  void configureImage() {
    totalImages.shuffle();
  }

  void fillCards() {
    cards.assignAll([]);
    allfaceupCards.assignAll([]);
    switch (level.value) {
      case Difficulty.Easy:
        totalImages.shuffle();
        var images = List<String>();
        for (int i = 0; i < NoOfCards.easyHalf; i++) {
          images.add(totalImages[i]);
        }
        // images.shuffle();
        final pair1 = List.generate(
          NoOfCards.easyHalf,
          (index) => PlayCard(false, images[index], false),
        );
        pair1.shuffle();
        // images.shuffle();
        final pair2 = List.generate(
          NoOfCards.easyHalf,
          (index) => PlayCard(false, images[index], false),
        );
        pair2.shuffle();
        cards.assignAll(pair1 + pair2);
        cards.shuffle();
        generateAllFaceUpCards();
        break;
      case Difficulty.Moderate:
        totalImages.shuffle();
        var images = List<String>();
        for (int i = 0; i < NoOfCards.moderateHalf; i++) {
          images.add(totalImages[i]);
        }
        images.shuffle();
        final pair1 = List.generate(
          NoOfCards.moderateHalf,
          (index) => PlayCard(false, images[index], false),
        );
        pair1.shuffle();
        images.shuffle();
        final pair2 = List.generate(
          NoOfCards.moderateHalf,
          (index) => PlayCard(false, images[index], false),
        );
        pair2.shuffle();
        cards.assignAll(pair1 + pair2);
        cards.shuffle();
        generateAllFaceUpCards();
        break;
      case Difficulty.Hard:
        totalImages.shuffle();
        var images = List<String>();
        for (int i = 0; i < NoOfCards.hardHalf; i++) {
          images.add(totalImages[i]);
        }
        images.shuffle();
        final pair1 = List.generate(
          NoOfCards.hardHalf,
          (index) => PlayCard(false, images[index], false),
        );
        pair1.shuffle();
        images.shuffle();
        final pair2 = List.generate(
          NoOfCards.hardHalf,
          (index) => PlayCard(false, images[index], false),
        );
        pair2.shuffle();
        cards.assignAll(pair1 + pair2);
        cards.shuffle();
        generateAllFaceUpCards();
        break;
      default:
        break;
    }
  }

  void didTapCard(int index) async {
    faceUpCards.add(cards[index]);
    cards[index].isFaceUp.value = true;
    if (faceUpCards.length < 2) return;
    final card1 = faceUpCards[0];
    final card2 = faceUpCards[1];
    Future.delayed(Duration(milliseconds: 600), () async {
      if (matchCards(card1, card2)) {
        matchedCards.value += 2;
        score += 1000;
        print('Score is $score');
        for (int i = 0; i < cards.length; i++) {
          if (cards[i].image == card1.image) {
            cards[i].isMatched.value = true;
          } else if (cards[i].image == card2.image) {
            cards[i].isMatched.value = true;
          }
        }
        if (matchedCards.value == cards.length) {
          final gameScore = score;
          final flips = flipsCount;
          score = 0.obs;
          flipsCount = 0.obs;
          await Get.dialog(
            PrimaryAlertDialog(
                title: 'Play Again',
                onPressed1: didTapExit,
                onPressed2: didTapPlayAgain,
                content:
                    'Score : $gameScore\nFlips: $flips\nDo you want to play again?',
                buttonTitle1: 'No',
                buttonTitle2: 'Yes'),
            barrierDismissible: false,
          );
        }
      } else {
        score -= 100;
        print('Score is $score');
        flipsCount++;
        for (int i = 0; i < cards.length; i++) {
          cards[i].isFaceUp.value = false;
        }
      }
      faceUpCards.assignAll([]);
    });
  }

  void didTapExit() {
    configure();
    Get.offAll(HomePage());
  }

  void didTapPlayAgain() {
    configure();
    Get.offAll(HomePage());
    Get.to(GameScreen());
  }

  bool matchCards(PlayCard card1, PlayCard card2) {
    return card1.image == card2.image;
  }

  void generateAllFaceUpCards() {
    final totalCards = cards
        .map((card) => PlayCard(true, card.image.value, card.isMatched.value))
        .toList();
    allfaceupCards(totalCards);
  }
}
