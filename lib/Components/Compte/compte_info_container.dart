import 'package:flutter/material.dart';

import '../../constraints.dart';

class CompteInfoContainer extends StatelessWidget {
  CompteInfoContainer({
    this.label,
    this.value,
  });

  final String label;
  final String value;

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      alignment: Alignment.topLeft,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          label,
          textAlign: TextAlign.start,
          style: TextStyle(color: kGreyLabel, fontSize: 12),
        ),
        Text(
          value,
          style: TextStyle(color: Colors.black),
        ),
      ]),
    );
  }
}
