import 'package:concentration/controller/cards_controller.dart';
import 'package:concentration/controller/game_theme_controller.dart';
import 'package:concentration/widgets/base_scaffold.dart';
import 'package:concentration/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectLevelPage extends StatelessWidget {
  final CardsController _cardsController = Get.find();
  final GameThemeController _gameThemeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return BaseScaffold(
          appBar: _buildAppBar(context), body: _buildBody(context));
    });
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text('Choose Level'),
    //   ),
    //   body: _buildBody(context),
    // );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: _gameThemeController.selectedTheme.value.cardColor,
      ),
      backgroundColor: _gameThemeController.selectedTheme.value.backgroundColor,
      title: Text(
        'Choose Level',
        style: TextStyle(color: _gameThemeController.cardColor),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PrimaryButton(
              color: _gameThemeController.selectedTheme.value.cardColor,
              onPressed: didTapEasy,
              title: _buildEasyTitle(context)),
          SizedBox(height: 16),
          PrimaryButton(
              color: _gameThemeController.selectedTheme.value.cardColor,
              onPressed: didTapModerate,
              title: _buildModerateTitle(context)),
          SizedBox(height: 16),
          PrimaryButton(
              color: _gameThemeController.selectedTheme.value.cardColor,
              onPressed: didTapHard,
              title: _buildHardTitle(context)),
        ],
      ),
    );
  }

  Widget _buildEasyTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Easy',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: _gameThemeController.backgroundColor)),
        ),
        if (_cardsController.level.value == Difficulty.Easy)
          Icon(
            Icons.check,
            color: _gameThemeController.selectedTheme.value.backgroundColor,
          )
      ],
    );
  }

  Widget _buildModerateTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Moderate',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: _gameThemeController.backgroundColor)),
        ),
        if (_cardsController.level.value == Difficulty.Moderate)
          Icon(Icons.check,
              color: _gameThemeController.selectedTheme.value.backgroundColor)
      ],
    );
  }

  Widget _buildHardTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Hard',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: _gameThemeController.backgroundColor)),
        ),
        if (_cardsController.level.value == Difficulty.Hard)
          Icon(Icons.check,
              color: _gameThemeController.selectedTheme.value.backgroundColor)
      ],
    );
  }

  void didTapEasy() {
    _cardsController.level(Difficulty.Easy);
    _cardsController.configure();
    Get.back();
  }

  void didTapModerate() {
    _cardsController.level(Difficulty.Moderate);
    _cardsController.configure();
    Get.back();
  }

  void didTapHard() {
    _cardsController.level(Difficulty.Hard);
    _cardsController.configure();
    Get.back();
  }
}
