import 'package:flutter/material.dart';

import '../constraints.dart';

class DropdownFieldContainer extends StatelessWidget {
  const DropdownFieldContainer({Key key, this.lightBackground, this.child})
      : super(key: key);

  final bool lightBackground;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        decoration: BoxDecoration(
          color: lightBackground ? klightGreyBackground : kPrimaryLightColor,
          border: Border.all(
            width: lightBackground ? 1.0 : 0.0,
            color: lightBackground ? kGreyLabel : ktransparent,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: DropdownButtonHideUnderline(child: child));
  }
}

int getDropdownListItem(list, value) {
  for (var i = 0; i < list.length; i++) {
    int itemValue = list.elementAt(i).value;
    if (itemValue == value) {
      return i;
    }
  }
  return null;
}
