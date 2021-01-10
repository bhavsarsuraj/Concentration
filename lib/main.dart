import 'package:concentration/controller/game_theme_controller.dart';
import 'package:concentration/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _gameThemeController = Get.put(GameThemeController());
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
          primaryColor:
              _gameThemeController.selectedTheme.value.backgroundColor,
          accentColor: _gameThemeController.selectedTheme.value.cardColor,
          scaffoldBackgroundColor:
              _gameThemeController.selectedTheme.value.backgroundColor,
          appBarTheme: AppBarTheme(
            elevation: 0,
            centerTitle: true,
            color: _gameThemeController.selectedTheme.value.backgroundColor,
          )),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
