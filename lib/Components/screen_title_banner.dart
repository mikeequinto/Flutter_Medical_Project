import 'package:flutter/cupertino.dart';
import 'package:popi/Styles/styles.dart';

import '../constraints.dart';

class ScreenTitleBanner extends StatelessWidget {
  ScreenTitleBanner({
    this.title,
  });

  final String title;

  Widget build(BuildContext context) {
    return // Screen title
        Container(
      color: kPrimaryColor,
      child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(title, style: screenTitle),
          )),
    );
  }
}
