import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:popi/Screens/Pathologies/pathologie_prescriptions_screen.dart';
import 'package:popi/Styles/styles.dart';
import 'package:popi/models/Pathologie.dart';

class ListPathologiesFamille extends StatelessWidget {
  const ListPathologiesFamille({
    this.pathologies,
    Key key,
  }) : super(key: key);

  final List<Pathologie> pathologies;

  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 10.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: 0.1),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0))),
        child: Column(
          children: [
            for (var pathologie in pathologies)
              FractionallySizedBox(
                  widthFactor: 0.95,
                  child: GestureDetector(
                      child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                                      color: Colors.grey[500], width: 0.3))),
                          padding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 20.0),
                          child: Text(
                            pathologie.pathologie,
                            style: cardBoldStyle,
                          )),
                      onTap: (() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PathologiePrescriptionsScreen(
                                      pathologie: pathologie,
                                    )));
                      })))
          ],
        ));
  }
}
