import 'package:flutter/material.dart';

class SeparationBanner extends StatelessWidget {
  SeparationBanner({this.label, Key key}) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
      margin: EdgeInsets.only(bottom: 10.0),
      color: Colors.white,
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
