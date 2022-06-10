import 'package:flutter/material.dart';

class PopiLogo extends StatelessWidget {
  const PopiLogo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: const EdgeInsets.fromLTRB(25.0,10.0,25.0,10.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          width: 3,
          ),
        borderRadius: BorderRadius.all(
          Radius.circular(5.0)
        )
      ),
      child: Text(
          "POPI",
          style: new TextStyle(
            fontSize: 30.0,
            fontFamily: 'OpenSans'
          )
      )
    );
  }
}