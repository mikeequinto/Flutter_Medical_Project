import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constraints.dart';

class CircleWhite extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
        width: 15,
        decoration: BoxDecoration(
            border: Border.all(width: 1.0, color: kPrimaryColor),
            color: Colors.white,
            shape: BoxShape.circle));
  }
}
