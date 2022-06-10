import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constraints.dart';

class CircleGreen extends StatelessWidget {
  Widget build(BuildContext context) {
    return Container(
        width: 15,
        decoration:
            BoxDecoration(color: kPrimaryColor, shape: BoxShape.circle));
  }
}
