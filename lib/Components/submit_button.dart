import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

import '../constraints.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({
    Key key,
    this.text,
    this.lightBackground,
    this.onPressed,
  }) : super(key: key);

  final String text;
  final bool lightBackground;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FlatButton(
        // Button style
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: BorderSide(color: Colors.white)),
        minWidth: size.width * 0.8,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 70.0),
          child: Text(text,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
        ),
        textColor: Colors.white,
        color: lightBackground ? kPrimaryColor : kPrimaryVeryLightColor,

        // Button event
        onPressed: onPressed);
  }
}
