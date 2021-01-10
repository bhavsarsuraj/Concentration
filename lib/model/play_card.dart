import 'package:get/get.dart';

class PlayCard {
  var isFaceUp = false.obs;
  var image = ''.obs;
  var isMatched = false.obs;

  PlayCard(bool isFaceUp, String image, bool isMatched) {
    this.isFaceUp(isFaceUp);
    this.image(image);
    this.isMatched(isMatched);
  }
}
