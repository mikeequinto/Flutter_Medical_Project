import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertUpdate extends StatelessWidget {
  AlertUpdate({
    this.title,
    this.message,
    this.dismiss,
  });

  final String title;
  final String message;
  final String dismiss;

  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text(message),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text(dismiss),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
