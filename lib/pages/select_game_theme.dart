import 'package:concentration/controller/game_theme_controller.dart';
import 'package:concentration/model/game_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectGameTheme extends StatelessWidget {
  final GameThemeController _gameThemeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.blueGrey,
          title: Text('Select Theme', style: TextStyle(color: Colors.black)),
        ),
        body: Obx(() {
          return _buildBody(context);
        }));
  }

  Widget _buildBody(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: _gameThemeController.themes
          .map((theme) => _buildThemeCard(context, theme))
          .toList(),
    );
  }

  Widget _buildThemeCard(BuildContext context, GameTheme gameTheme) {
    return GestureDetector(
      onTap: () {
        _gameThemeController.selectedTheme.value = gameTheme;
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                color: gameTheme.backgroundColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: gameTheme.cardColor,
                  ),
                  height: 60,
                  width: 40,
                ),
              ),
            ),
            _gameThemeController.selectedTheme.value == gameTheme
                ? Container(
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.check,
                        color: Colors.white60,
                        size: 100,
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
