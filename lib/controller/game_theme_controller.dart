import 'package:concentration/constants/game_themes.dart';
import 'package:concentration/model/game_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/get.dart';

class GameThemeController extends GetxController {
  var themes = List<GameTheme>().obs;
  var selectedTheme = Rx<GameTheme>();
  @override
  void onInit() {
    super.onInit();
    themes.assignAll(GameThemes.themes);
    selectedTheme(themes[0]);
  }

  Color get cardColor => selectedTheme.value.cardColor;
  Color get backgroundColor => selectedTheme.value.backgroundColor;

  void changeTheme(GameTheme gameTheme) {
    selectedTheme(gameTheme);
  }
}
