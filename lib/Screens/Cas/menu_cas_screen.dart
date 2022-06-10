import 'dart:async';

import 'package:flutter/material.dart';
import 'package:popi/Components/Cas/cas_card.dart';
import 'package:popi/Screens/Cas/CasComponents/modification_prescriptions_tab.dart';
import 'package:popi/Utilities/fetch_methods.dart';
import 'package:popi/api/DataProvider.dart';
import 'package:popi/data/form_data.dart';
import 'package:popi/models/Cas.dart';
import 'package:popi/models/Compte.dart';
import 'package:popi/models/Pathologie.dart';
import 'package:popi/models/Prescription.dart';
import 'package:popi/providers/UserProvider.dart';
import 'package:provider/provider.dart';

import 'informations_cas_screen.dart';

class MenuCas extends StatefulWidget {
  @override
  MenuCasState createState() => MenuCasState();
}

class MenuCasState extends State<MenuCas> {
  // This will refresh the page when back button is pressed
  FutureOr onGoBack(dynamic value) {
    setState(() {});
  }

  Pathologie getPathologie(listPathologies, id) {
    for (var pathologie in listPathologies) {
      if (pathologie.id == id) {
        return pathologie;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // List cas/patient of user
    List<Cas> listCas = FetchMethods().getCas(context);

    // List of all pathologies
    List<Pathologie> listPathologies =
        FetchMethods().getPathologiesSansFamille(context);

    // List of all prescriptions
    List<Prescription> listPrescriptions =
        FetchMethods().getPrescriptions(context);

    // User info
    Compte compte = Provider.of<UserProvider>(context, listen: false).user;

    // Verify compte fonction if Médecin
    //--> initialize prescriptions reponses
    if (compte.fonction == "Médecin") {
      ModificationPrescriptionsTabState.reponsesOmises =
          prescriptionsOmisesOption;
      ModificationPrescriptionsTabState.reponsesInappropriees =
          prescriptionsInapproprieesOption;
    } else {
      ModificationPrescriptionsTabState.reponsesOmises =
          prescriptionsOmisesAutreOption;
      ModificationPrescriptionsTabState.reponsesInappropriees =
          prescriptionsInapproprieesAutreOption;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Consumer<DataProvider>(builder: (context, dataProvider, child) {
          if (dataProvider.fetchingStatus == Status.fetched &&
              dataProvider.fetchingCasStatus == Status.fetched &&
              dataProvider.fetchingPrescriptionsStatus == Status.fetched) {
            // List of widgets to display
            List<Widget> listWidgets = new List<Widget>();

            // When pathologies are fetched
            for (var cas in listCas) {
              // Transform naissance date (reverse)
              String oldNaissance = cas.naissance;
              List<String> dateSplit = oldNaissance.split("-");
              String newNaissance = dateSplit.reversed.toString();

              // Get first pathologie of cas to show on card
              Pathologie firstPathologie =
                  getPathologie(listPathologies, cas.pathologies[0].id);

              // Initialize list of pathologies for this cas
              List<Pathologie> pathologies = new List<Pathologie>();
              for (var p in cas.pathologies) {
                Pathologie pathologie = getPathologie(listPathologies, p.id);
                pathologies.add(pathologie);
              }

              // Create widget for each cas
              listWidgets.add(
                CasCard(
                  title: newNaissance
                      .replaceAll(" ", "")
                      .replaceAll(',', '.')
                      .replaceAll("(", "")
                      .replaceAll(")", ""),
                  subtitle: firstPathologie.pathologie,
                  date: cas.date.replaceAll('-', '.').replaceAll(" ", " - "),
                  onTap: (() {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => InformationsCasScreen(
                              compte: compte,
                              cas: cas,
                              pathologies: pathologies,
                              prescriptions: listPrescriptions)),
                    ).then(onGoBack);
                  }),
                ),
              );
            }
            return Column(
              children: listWidgets,
            );
            /*ListCas(pathologies: listCas);*/
          } else {
            // While pathologies are being fetched
            return CircularProgressIndicator();
          }
        }),
      ],
    );
  }
}
