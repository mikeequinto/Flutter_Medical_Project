import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:popi/Styles/styles.dart';

class LargeButton extends StatelessWidget {
  const LargeButton({
    Key key,
    this.text,
    this.color,
    this.size,
    this.onPressed,
  }) : super(key: key);

  final String text;
  final Color color;
  final double size;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width * size / 100,
        child: RaisedButton(
          child: Text(
            text,
            style: buttonTextStyle,
          ),
          color: color,
          textColor: Colors.white,
          padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
          onPressed: onPressed,
        ));
  }
}
