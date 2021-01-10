import 'package:concentration/controller/game_theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrimaryAlertDialog extends StatelessWidget {
  final GameThemeController _gameThemeController = Get.find();
  final String title;
  final Function onPressed1;
  final Function onPressed2;
  final String content;
  final String buttonTitle1;
  final String buttonTitle2;

  PrimaryAlertDialog(
      {Key key,
      @required this.title,
      @required this.onPressed1,
      @required this.onPressed2,
      @required this.content,
      @required this.buttonTitle1,
      @required this.buttonTitle2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: _gameThemeController.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      title: Text(
        title,
        style: TextStyle(color: _gameThemeController.cardColor),
      ),
      content: Text(
        content,
        style: TextStyle(
          color: _gameThemeController.cardColor,
        ),
      ),
      actions: [
        FlatButton(
          onPressed: onPressed1,
          child: Text(
            buttonTitle1,
            style: TextStyle(
              color: _gameThemeController.cardColor,
            ),
          ),
        ),
        if (buttonTitle2 != null)
          FlatButton(
            onPressed: onPressed2,
            child: Text(
              buttonTitle2,
              style: TextStyle(
                color: _gameThemeController.cardColor,
              ),
            ),
          )
      ],
    );
  }
}
