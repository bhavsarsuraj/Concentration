import 'package:concentration/controller/game_theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseScaffold extends StatelessWidget {
  final GameThemeController _gameThemeController = Get.find();
  final AppBar appBar;
  final Widget body;
  final FloatingActionButton floatingActionButton;
  BaseScaffold(
      {Key key, this.appBar, @required this.body, this.floatingActionButton})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _gameThemeController.selectedTheme.value.backgroundColor,
      appBar: appBar,
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
