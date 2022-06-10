import 'dart:collection';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:popi/Styles/styles.dart';
import 'package:popi/models/Prescription.dart';

class PathologiePrescriptionsType extends StatelessWidget {
  const PathologiePrescriptionsType({
    this.prescriptions,
    Key key,
  }) : super(key: key);

  final List<Prescription> prescriptions;

  Widget build(BuildContext context) {
    // Hashmap containing the prescriptions with age info
    HashMap<Prescription, String> prescriptionsAvecAge =
        separateAgeInfo(prescriptions);

    return Column(children: [
      for (var prescription in prescriptions)
        Container(
          child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  child: ListTile(
                      title: Text(prescription.prescription,
                          style: cardBoldStyle)))),
          margin: EdgeInsets.only(bottom: 8.0),
        )
    ]);
  }
}

HashMap<Prescription, String> separateAgeInfo(prescriptions) {
  HashMap<Prescription, String> prescriptionsAvecAge =
      new HashMap<Prescription, String>();

  for (var i = 0; i < prescriptions.length; i++) {
    String prescription = prescriptions[i].prescription;

    List<String> motsCles = [
      'avant',
      'plus de',
    ];
  }

  return prescriptionsAvecAge;
}
