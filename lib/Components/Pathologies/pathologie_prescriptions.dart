import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:popi/Components/Pathologies/pathologie_prescriptions_type.dart';
import 'package:popi/Components/banner_prescription.dart';
import 'package:popi/Utilities/fetch_methods.dart';
import 'package:popi/models/Prescription.dart';

import '../separationBanner.dart';

class PathologiePrescriptions extends StatelessWidget {
  const PathologiePrescriptions({
    this.prescriptions,
    Key key,
  }) : super(key: key);

  final List<Prescription> prescriptions;

  Widget build(BuildContext context) {
    List<Prescription> prescriptionsInappropriees =
        FetchMethods().getPrescriptionsByType(prescriptions, "inappropriee");

    List<Prescription> prescriptionsOmises =
        FetchMethods().getPrescriptionsByType(prescriptions, "omise");

    return Container(
      child: Column(children: [
        //Display prescriptions omises
        SeparationBanner(label: "Prescriptions omises"),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: PathologiePrescriptionsType(
            prescriptions: prescriptionsOmises,
          ),
        ),

        //Display prescriptions inappropriées
        SeparationBanner(
          label: 'Prescriptions inappropriées',
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: PathologiePrescriptionsType(
            prescriptions: prescriptionsInappropriees,
          ),
        ),
      ]),
    );
  }
}
