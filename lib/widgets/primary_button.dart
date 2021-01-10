import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final Function onPressed;
  final Widget title;
  final Color color;

  const PrimaryButton(
      {Key key, @required this.onPressed, @required this.title, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: title,
      ),
      color: color ?? Colors.deepOrange,
    );
  }
}
