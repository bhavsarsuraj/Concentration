import 'package:concentration/controller/cards_controller.dart';
import 'package:concentration/controller/game_theme_controller.dart';
import 'package:concentration/pages/game_screen.dart';
import 'package:concentration/pages/select_game_theme.dart';
import 'package:concentration/pages/select_level_page.dart';
import 'package:concentration/widgets/base_scaffold.dart';
import 'package:concentration/widgets/primary_alert_dialog.dart';
import 'package:concentration/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final _cardsController = Get.put(CardsController());
  final GameThemeController _gameThemeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return BaseScaffold(appBar: null, body: _buildBody(context));
    });
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: _gameThemeController.selectedTheme.value.backgroundColor,
      // title: Text(
      //   'Concentration',
      //   style: TextStyle(
      //       color: _gameThemeController.selectedTheme.value.textColor),
      // ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          final shouldPop = await Get.dialog(
            PrimaryAlertDialog(
                title: 'Quit',
                onPressed1: didTapNotQuit,
                onPressed2: didTapQuit,
                content: 'Are you sure you want to quit this game?',
                buttonTitle1: 'No',
                buttonTitle2: 'Yes'),
            barrierDismissible: false,
          );
          return shouldPop;
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Concentration',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 36,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w700,
                      color: _gameThemeController.cardColor)),
              SizedBox(height: 32),
              PrimaryButton(
                color: _gameThemeController.selectedTheme.value.cardColor,
                onPressed: didTapPlay,
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Play Now',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: _gameThemeController
                            .selectedTheme.value.backgroundColor),
                  ),
                ),
              ),
              SizedBox(height: 16),
              PrimaryButton(
                color: _gameThemeController.selectedTheme.value.cardColor,
                onPressed: didTapDifficulty,
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Difficulty',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: _gameThemeController
                            .selectedTheme.value.backgroundColor),
                  ),
                ),
              ),
              SizedBox(height: 16),
              PrimaryButton(
                color: _gameThemeController.selectedTheme.value.cardColor,
                onPressed: didTapChangeTheme,
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Change Theme',
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: _gameThemeController
                            .selectedTheme.value.backgroundColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void didTapNotQuit() {
    Get.back(result: false);
  }

  void didTapQuit() {
    _cardsController.configure();
    Get.back(result: true);
  }

  void didTapPlay() {
    Get.to(GameScreen());
  }

  void didTapDifficulty() {
    Get.to(SelectLevelPage());
  }

  void didTapChangeTheme() {
    Get.to(SelectGameTheme());
  }
}
