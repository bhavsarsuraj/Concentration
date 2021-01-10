import 'package:concentration/constants/number_of_cards.dart';
import 'package:concentration/controller/cards_controller.dart';
import 'package:concentration/controller/game_theme_controller.dart';
import 'package:concentration/pages/home_page.dart';
import 'package:concentration/widgets/base_scaffold.dart';
import 'package:concentration/widgets/primary_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final CardsController cardsController = Get.find();

  final GameThemeController _gameThemeController = Get.find();

  final horizontalPadding = 8.0.obs;

  final outerPadding = 8.0.obs;

  final cardAspectRatio = 0.8.obs;

  final verticalPadding = 4.0.obs;
  final screenOrientation = Orientation.portrait.obs;

  @override
  void initState() {
    super.initState();
  }

  void configure() {
    configureGameScreen(context);
  }

  @override
  Widget build(BuildContext context) {
    configure();
    return Obx(() {
      return BaseScaffold(appBar: _buildAppBar(context), body: _body(context));
    });
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
        iconTheme: IconThemeData(
          color: _gameThemeController.selectedTheme.value.cardColor,
        ),
        backgroundColor:
            _gameThemeController.selectedTheme.value.backgroundColor,
        title: Obx(() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Score: ${cardsController.score.value}',
                style: TextStyle(
                    fontSize: 20,
                    color: _gameThemeController.selectedTheme.value.textColor),
              ),
              Text(
                'Flips Count: ${cardsController.flipsCount.value}',
                style: TextStyle(
                    fontSize: 20,
                    color: _gameThemeController.selectedTheme.value.textColor),
              )
            ],
          );
        }));
  }

  Widget _body(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          final shouldPop = await Get.dialog(
            PrimaryAlertDialog(
                title: 'Quit',
                onPressed1: didTapNotQuit,
                onPressed2: didTapQuit,
                content:
                    'Do you really want to quit this game as you will lose your current score?',
                buttonTitle1: 'No',
                buttonTitle2: 'Yes'),
            barrierDismissible: false,
          );
          return shouldPop;
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: outerPadding.value),
          child: Center(
            child: Wrap(
              direction: Axis.horizontal,
              spacing: horizontalPadding.value,
              runSpacing: verticalPadding.value,
              children: List.generate(cardsController.cards.length,
                  (index) => _buildCard(context, index)),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await Get.dialog(
          PrimaryAlertDialog(
              title: 'Quit',
              onPressed1: didTapNotQuit,
              onPressed2: didTapQuit,
              content:
                  'Do you really want to quit this game as you will lose your current score?',
              buttonTitle1: 'No',
              buttonTitle2: 'Yes'),
          barrierDismissible: false,
        );
        return shouldPop;
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: outerPadding.value),
        child: GridView.count(
          childAspectRatio: cardAspectRatio.value,
          crossAxisCount: getCols(),
          children: List.generate(
            cardsController.cards.length,
            (index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding.value,
                    vertical: verticalPadding.value),
                child: _buildCard(context, index),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, int index) {
    final card = cardsController.cards[index];
    return card.isMatched.value
        ? Container(
            height: getCardHeight(context),
            width: getCardWidth(context),
            color: Colors.transparent,
          )
        : GestureDetector(
            onTap: () => didTapCard(context, index),
            child: card.isFaceUp.value
                ? Container(
                    height: getCardHeight(context),
                    width: getCardWidth(context),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        card.image.value,
                        style: TextStyle(fontSize: getFontSize()),
                      ),
                    ),
                  )
                : Container(
                    height: getCardHeight(context),
                    width: getCardWidth(context),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: _gameThemeController.selectedTheme.value.cardColor,
                    ),
                  ),
          );
  }

  void didTapQuitGame() async {
    await Get.dialog(
      AlertDialog(
        title: Text('Quit'),
        content: Text('Do you really want to quit this game'),
        actions: [
          FlatButton(
              onPressed: () {
                Get.back();
              },
              child: Text('No')),
          FlatButton(
              onPressed: () {
                cardsController.configure();
                Get.offAll(HomePage());
              },
              child: Text('Yes')),
        ],
      ),
      barrierDismissible: false,
    );
  }

  int getCols() {
    switch (cardsController.level.value) {
      case Difficulty.Easy:
        return NoOfCards.easyCols;
        break;
      case Difficulty.Moderate:
        return NoOfCards.moderateCols;
        break;
      case Difficulty.Hard:
        return NoOfCards.hardCols;
        break;
      default:
        return NoOfCards.easyCols;
    }
  }

  int getRows() {
    switch (cardsController.level.value) {
      case Difficulty.Easy:
        return NoOfCards.easyRows;
        break;
      case Difficulty.Moderate:
        return NoOfCards.moderateRows;
        break;
      case Difficulty.Hard:
        return NoOfCards.hardRows;
        break;
      default:
        return NoOfCards.easyRows;
    }
  }

  double getFontSize() {
    switch (cardsController.level.value) {
      case Difficulty.Easy:
        return 36.0;
        break;
      case Difficulty.Moderate:
        return 32.0;
        break;
      case Difficulty.Hard:
        return 28.0;
        break;
      default:
        return 16.0;
    }
  }

  void didTapNotQuit() {
    Get.back(result: false);
  }

  void didTapQuit() {
    cardsController.configure();
    Get.back(result: true);
  }

  void didTapCard(BuildContext context, int index) {
    if (cardsController.faceUpCards.length >= 2 ||
        cardsController.cards[index].isFaceUp.value) return;
    cardsController.didTapCard(index);
  }

  double getCardWidth(BuildContext context) {
    final screenWidth = getScreenWidth(context);
    final cardWidth =
        ((screenWidth - ((getCols() - 1) * 2 * horizontalPadding.value)) -
                (2 * outerPadding.value)) /
            getCols();
    return cardWidth;
  }

  double getCardHeight(BuildContext context) {
    final height = getCardWidth(context) / cardAspectRatio.value;
    return height;
  }

  void configureGameScreen(BuildContext context) {
    final screenHeight = getScreenHeight(context);
    final cardHeight = getCardHeight(context);
    final rows = getRows();

    final totalCardsHeight = rows * cardHeight;
    final remainedHeight = screenHeight - totalCardsHeight;
    final newVerticalPadding = (remainedHeight / (2 * rows));

    if (remainedHeight > 0)
      verticalPadding(newVerticalPadding);
    else
      horizontalPadding(4.0);
  }

  double getGridHeight(BuildContext context) {
    final totalCardsHeight = getCardHeight(context) * getRows();
    final totalVerticalPadding = verticalPadding * 2 * getRows();
    return totalCardsHeight + totalVerticalPadding;
  }

  double getScreenWidth(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth;
  }

  double getScreenHeight(BuildContext context) {
    final appBar = AppBar();
    final appBarHeight = appBar.preferredSize.height;
    final screenHeight = MediaQuery.of(context).size.height - appBarHeight;
    return screenHeight;
  }
}
