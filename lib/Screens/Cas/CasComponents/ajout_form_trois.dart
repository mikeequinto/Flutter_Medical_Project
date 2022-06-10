import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:popi/Components/Pathologies/menu_pathologies_item.dart';
import 'package:popi/Components/banner_prescription.dart';
import 'package:popi/Components/circle_green.dart';
import 'package:popi/Components/circle_white.dart';
import 'package:popi/Utilities/fetch_methods.dart';
import 'package:popi/api/DataProvider.dart';
import 'package:popi/Styles/styles.dart';
import 'package:popi/constraints.dart';
import 'package:popi/data/form_data.dart';
import 'package:popi/models/Pathologie.dart';
import 'package:popi/models/Prescription.dart';
import 'package:popi/providers/UserProvider.dart';
import 'package:provider/provider.dart';

class AjoutFormTrois extends StatelessWidget {
  AjoutFormTrois({this.pathologies});

  // Patient pathologies
  final HashMap<String, Pathologie> pathologies;

  Widget build(BuildContext context) {
    // List of all prescriptions
    final List<Prescription> allPrescriptions =
        FetchMethods().getPrescriptions(context);

    // List of pathologies with its prescriptions
    HashMap<String, List<Prescription>> pathologiesPrescriptionsOmises =
        new HashMap<String, List<Prescription>>();
    HashMap<String, List<Prescription>> pathologiesPrescriptionsInappropriees =
        new HashMap<String, List<Prescription>>();

    // Possible reponses based on if "Médecin"
    Map<int, String> reponsesOmises = new Map<int, String>();
    Map<int, String> reponsesInappropriees = new Map<int, String>();

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Step instructions
          Container(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Text(
              etapeTroisMessage,
              style: cardSubtitleStyle,
            ),
          ),

          //Step content
          Consumer<UserProvider>(builder: (context, userProvider, child) {
            // Verify compte fonction if Médecin
            if (userProvider.user.fonction == "Médecin") {
              reponsesOmises = prescriptionsOmisesOption;
              reponsesInappropriees = prescriptionsInapproprieesOption;
            } else {
              reponsesOmises = prescriptionsOmisesAutreOption;
              reponsesInappropriees = prescriptionsInapproprieesAutreOption;
            }
            return
                // Wait for data provider
                Consumer<DataProvider>(builder: (context, dataProvider, child) {
              // When fetched
              if (dataProvider.fetchingStatus == Status.fetched) {
                for (var pathologie in pathologies.keys) {
                  // Get prescriptions for current pathologie
                  List<Prescription> currentPathologiePrescriptions =
                      FetchMethods().getPrescriptionsByPathologie(
                          allPrescriptions, pathologie);

                  // Add pathologie and prescriptions to list omises
                  pathologiesPrescriptionsOmises[pathologie] = FetchMethods()
                      .getPrescriptionsByType(
                          currentPathologiePrescriptions, 'omise');

                  // Add pathologie and prescriptions to list inappropriées
                  pathologiesPrescriptionsInappropriees[pathologie] =
                      FetchMethods().getPrescriptionsByType(
                          currentPathologiePrescriptions, 'inappropriee');
                }

                return AjoutFormTroisAvecState(
                  pathologies: pathologies,
                  prescriptionsOmises: pathologiesPrescriptionsOmises,
                  prescriptionsInappropriees:
                      pathologiesPrescriptionsInappropriees,
                  reponsesOmises: reponsesOmises,
                  reponsesInappropriees: reponsesInappropriees,
                );
              } else {
                // While prescriptions are being fetched
                return CircularProgressIndicator();
              }
            });
          }),
        ]);
  }
}

class AjoutFormTroisAvecState extends StatefulWidget {
  AjoutFormTroisAvecState(
      {this.pathologies,
      this.prescriptionsOmises,
      this.prescriptionsInappropriees,
      this.reponsesOmises,
      this.reponsesInappropriees});

  final HashMap<String, Pathologie> pathologies;
  final HashMap<String, List<Prescription>> prescriptionsOmises;
  final HashMap<String, List<Prescription>> prescriptionsInappropriees;
  final Map<int, String> reponsesOmises;
  final Map<int, String> reponsesInappropriees;

  @override
  State<StatefulWidget> createState() {
    return AjoutFormTroisState();
  }
}

class AjoutFormTroisState extends State<AjoutFormTroisAvecState> {
// List of reponses
  static final HashMap<int, int> reponses = new HashMap<int, int>();

  // Show or hide reponses for prescription
  static final HashMap<String, bool> showOptions = new HashMap<String, bool>();

  @override
  void initState() {
    super.initState();

    reponses.clear();
    showOptions.clear();
  }

  Widget build(BuildContext context) {
    //Initialize reponses
    for (var pathologie in widget.pathologies.keys) {
      List<Prescription> prescriptionsOmises =
          widget.prescriptionsOmises[pathologie];

      List<Prescription> prescriptionsInappropriees =
          widget.prescriptionsInappropriees[pathologie];

      for (var prescription in prescriptionsOmises) {
        if (reponses[prescription.id] == null) {
          reponses[prescription.id] = widget.reponsesOmises.keys.elementAt(0);
        }
      }

      for (var prescription in prescriptionsInappropriees) {
        if (reponses[prescription.id] == null) {
          reponses[prescription.id] =
              widget.reponsesInappropriees.keys.elementAt(0);
        }
      }
    }

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (var pathologie in widget.pathologies.keys)
            Column(children: [
              // Prescriptions omises
              BannerPrescription(
                pathologie: pathologie,
                type: "Prescriptions omises",
              ),
              for (var prescription in widget.prescriptionsOmises[pathologie])
                Column(children: [
                  // Display prescription omise
                  MenuPathologiesItem(
                    label: prescription.prescription,
                    shadow: showOptions[prescription.prescription] == null
                        ? false
                        : showOptions[prescription.prescription],
                    onPressed: (() {
                      setState(() {
                        showOptions[prescription.prescription] == null
                            ? showOptions[prescription.prescription] = true
                            : showOptions[prescription.prescription] =
                                !showOptions[prescription.prescription];
                      });
                    }),
                  ),
                  // Show reponses
                  Visibility(
                    visible: showOptions[prescription.prescription] == null
                        ? false
                        : showOptions[prescription.prescription],
                    child: Container(
                      margin: EdgeInsets.only(bottom: 10.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 0.1),
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15.0),
                              bottomRight: Radius.circular(15.0))),
                      child: Column(
                        children: [
                          for (var reponse in widget.reponsesOmises.keys)
                            FractionallySizedBox(
                              widthFactor: 0.95,
                              child: GestureDetector(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                          color: Colors.grey[500], width: 0.3),
                                    ),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 10.0),
                                  child: ListTile(
                                    leading:
                                        reponses[prescription.id] == reponse
                                            ? CircleGreen()
                                            : CircleWhite(),
                                    title: Text(
                                      widget.reponsesOmises[reponse],
                                      style: cardBoldStyle,
                                    ),
                                  ),
                                ),
                                onTap: (() {
                                  setState(() {
                                    reponses[prescription.id] = reponse;
                                  });
                                }),
                              ),
                            ),
                        ],
                      ),
                    ),
                  )
                ]),

              // Prescriptions Inappropriées
              BannerPrescription(
                pathologie: pathologie,
                type: "Prescriptions Inappropriées",
              ),

              for (var prescription
                  in widget.prescriptionsInappropriees[pathologie])
                Column(
                  children: [
                    MenuPathologiesItem(
                      label: prescription.prescription,
                      shadow: showOptions[prescription.prescription] == null
                          ? false
                          : showOptions[prescription.prescription],
                      onPressed: (() {
                        setState(() {
                          showOptions[prescription.prescription] == null
                              ? showOptions[prescription.prescription] = true
                              : showOptions[prescription.prescription] =
                                  !showOptions[prescription.prescription];
                        });
                      }),
                    ),
                    // Show reponses
                    Visibility(
                      visible: showOptions[prescription.prescription] == null
                          ? false
                          : showOptions[prescription.prescription],
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(width: 0.1),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15.0),
                                bottomRight: Radius.circular(15.0))),
                        child: Column(
                          children: [
                            for (var reponse
                                in widget.reponsesInappropriees.keys)
                              FractionallySizedBox(
                                widthFactor: 0.95,
                                child: GestureDetector(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: BorderSide(
                                            color: Colors.grey[500],
                                            width: 0.3),
                                      ),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 20.0, horizontal: 10.0),
                                    child: ListTile(
                                      leading:
                                          reponses[prescription.id] == reponse
                                              ? CircleGreen()
                                              : CircleWhite(),
                                      title: Text(
                                        widget.reponsesInappropriees[reponse],
                                        style: cardBoldStyle,
                                      ),
                                    ),
                                  ),
                                  onTap: (() {
                                    setState(() {
                                      reponses[prescription.id] = reponse;
                                    });
                                  }),
                                ),
                              ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
            ])
        ]);
  }
}
