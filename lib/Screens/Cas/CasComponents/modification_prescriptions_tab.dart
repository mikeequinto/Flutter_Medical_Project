import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popi/Components/Cas/prescription_options.dart';
import 'package:popi/Components/Pathologies/menu_pathologies_item.dart';
import 'package:popi/Components/banner_prescription.dart';
import 'package:popi/Utilities/fetch_methods.dart';
import 'package:popi/models/CasPrescription.dart';
import 'package:popi/models/Pathologie.dart';
import 'package:popi/models/Prescription.dart';
import 'package:popi/providers/UserProvider.dart';
import 'package:provider/provider.dart';

class ModificationPrescriptionsTab extends StatefulWidget {
  ModificationPrescriptionsTab({
    this.fonction,
    //this.prescriptions,
    this.pathologiesPrescriptions,
    this.prescriptionsReponses,
  });

  final String fonction;
  //final List<Prescription> prescriptions;
  final HashMap<Pathologie, List<Prescription>> pathologiesPrescriptions;
  final List<CasPrescription> prescriptionsReponses;

  @override
  ModificationPrescriptionsTabState createState() =>
      ModificationPrescriptionsTabState();
}

class ModificationPrescriptionsTabState
    extends State<ModificationPrescriptionsTab> {
  // List of prescriptions by type
  HashMap<Pathologie, List<Prescription>> pathologiePrescriptionsOmises =
      new HashMap<Pathologie, List<Prescription>>();
  HashMap<Pathologie, List<Prescription>> pathologiePrescriptionsInappropriees =
      new HashMap<Pathologie, List<Prescription>>();

  // List to show or hide prescription options
  static final HashMap<int, bool> showOptions = new HashMap();

  // Possible reponses based on if "Médecin"
  static Map<int, String> reponsesOmises = new Map<int, String>();
  static Map<int, String> reponsesInappropriees = new Map<int, String>();

  // List of reponses
  static final HashMap<int, int> reponses = new HashMap<int, int>();

  @override
  void initState() {
    super.initState();

    for (var pathologie in widget.pathologiesPrescriptions.keys) {
      for (var prescription in widget.pathologiesPrescriptions[pathologie]) {
        if (showOptions[prescription.id] == null) {
          showOptions[prescription.id] = false;
        }
      }

      // Initialize prescription lists
      pathologiePrescriptionsOmises[pathologie] = FetchMethods()
          .getPrescriptionsByType(
              widget.pathologiesPrescriptions[pathologie], "omise");
      pathologiePrescriptionsInappropriees[pathologie] = FetchMethods()
          .getPrescriptionsByType(
              widget.pathologiesPrescriptions[pathologie], "inappropriee");
    }
  }

  void initialize(prescriptionsReponses) {
    showOptions.clear();
    reponses.clear();

    for (var reponse in prescriptionsReponses) {
      if (reponses[reponse.id] == null) {
        reponses[reponse.id] = reponse.reponse;
      }
    }
  }

  void setReponse(int prescriptionId, int reponseId) {
    setState(() {
      reponses[prescriptionId] = reponseId;
    });
  }

  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, child) {
      return ListView(
        padding: EdgeInsets.only(bottom: 120.0),
        children: [
          for (var pathologie in widget.pathologiesPrescriptions.keys)
            Column(
              children: [
                BannerPrescription(
                  pathologie: pathologie.pathologie,
                  type: "Prescriptions omises",
                ),
                Column(children: [
                  for (var prescription
                      in pathologiePrescriptionsOmises[pathologie])
                    Container(
                      padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 5.0),
                      child: Column(
                        children: [
                          MenuPathologiesItem(
                            label: prescription.prescription,
                            shadow: showOptions[prescription.id],
                            onPressed: (() {
                              setState(() {
                                showOptions[prescription.id] =
                                    !showOptions[prescription.id];
                              });
                            }),
                          ),
                          Visibility(
                            visible: showOptions[prescription.id],
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.0),
                                  bottomRight: Radius.circular(15.0),
                                ),
                              ),
                              child: PrescriptionOptions(
                                  prescriptionId: prescription.id,
                                  options: reponsesOmises,
                                  reponses: reponses,
                                  onTap: setReponse),
                            ),
                          )
                        ],
                      ),
                    ),
                ]),
                BannerPrescription(
                  pathologie: pathologie.pathologie,
                  type: "Prescriptions omises",
                ),
                Column(
                  children: [
                    for (var prescription
                        in pathologiePrescriptionsInappropriees[pathologie])
                      Container(
                        padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 5.0),
                        child: Column(
                          children: [
                            MenuPathologiesItem(
                              label: prescription.prescription,
                              shadow: showOptions[prescription.id],
                              onPressed: (() {
                                setState(() {
                                  showOptions[prescription.id] =
                                      !showOptions[prescription.id];
                                });
                              }),
                            ),
                            Visibility(
                              visible: showOptions[prescription.id],
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15.0),
                                    bottomRight: Radius.circular(15.0),
                                  ),
                                ),
                                child: PrescriptionOptions(
                                    prescriptionId: prescription.id,
                                    options: reponsesInappropriees,
                                    reponses: reponses,
                                    onTap: setReponse),
                              ),
                            )
                          ],
                        ),
                      ),
                  ],
                ),
              ],
            )
        ],
      );
    });
  }
}
