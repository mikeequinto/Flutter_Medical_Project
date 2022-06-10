import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:popi/api/DataProvider.dart';
import 'package:popi/models/Cas.dart';
import 'package:popi/models/Compte.dart';
import 'package:popi/models/Pathologie.dart';
import 'package:popi/models/Prescription.dart';
import 'package:popi/shared_preferences/UserPreferences.dart';
import 'package:provider/provider.dart';

class FetchMethods {
  List<Cas> getCas(context) {
    // Provider which contains API call method
    DataProvider dataProvider =
        Provider.of<DataProvider>(context, listen: false);

    // List of famillies of pathologies
    List<Cas> listCas = new List<Cas>();

    // Logged in user info
    Future<Compte> compte = UserPreferences().getUser();

    compte.then((compte) => {
          // Fetch pathologies
          dataProvider.getCas(compte.id).then((result) => {
                // If pathologies fetched
                if (result['status'])
                  {
                    for (int i = 0; i < result['cas'].length; i++)
                      {listCas.add(result['cas'][i])},
                  }
                else
                  {
                    //Show error
                    debugPrint("an error occured")
                  }
              })
        });

    return listCas;
  }

  Pathologie getPathologie(context, id) {
    // Provider which contains API call method
    DataProvider pathProvider =
        Provider.of<DataProvider>(context, listen: false);

    Pathologie pathologie;

    // Fetch pathologies
    pathProvider.getPathologies().then((result) => {
          // If pathologies fetched
          if (result['status'])
            {
              for (int i = 0; i < result['pathologies'].length; i++)
                {
                  if (result['pathologies'][i].id == id)
                    {pathologie = result['pathologies'][i]}
                }
            }
          else
            {
              //Show error
              debugPrint("an error occured")
            }
        });
    return pathologie;
  }

  List<Pathologie> getPathologiesSansFamille(context) {
    // Provider which contains API call method
    DataProvider pathProvider =
        Provider.of<DataProvider>(context, listen: false);

    List<Pathologie> listPathologies = new List<Pathologie>();

    // Fetch pathologies
    pathProvider.getPathologies().then((result) => {
          // If pathologies fetched
          if (result['status'])
            {
              for (int i = 0; i < result['pathologies'].length; i++)
                {listPathologies.add(result['pathologies'][i])}
            }
          else
            {
              //Show error
              debugPrint("an error occured")
            }
        });
    return listPathologies;
  }

  HashMap<String, List<Pathologie>> getPathologies(context) {
    // Provider which contains API call method
    DataProvider pathProvider =
        Provider.of<DataProvider>(context, listen: false);

    // List of all pathologies
    List<Pathologie> pathologies;

    // Pathologie familly declaration
    String famille;

    // List of famillies of pathologies
    HashMap<String, List<Pathologie>> famillesPathologies =
        new HashMap<String, List<Pathologie>>();

    // Fetch pathologies
    pathProvider.getPathologies().then((result) => {
          // If pathologies fetched
          if (result['status'])
            {
              pathologies = result['pathologies'],
              for (int i = 0; i < pathologies.length; i++)
                {
                  // Get the famille of pathologie
                  famille = pathologies[i].famille,

                  // Check if familles_pathologies already contains it
                  if (famillesPathologies.containsKey(famille))
                    {
                      // Add pathologie to famille
                      famillesPathologies[famille].add(pathologies[i]),
                    }
                  else
                    {
                      // Add new famille to familles_pathologies
                      famillesPathologies[famille] = new List<Pathologie>(),
                      // Add pathologie to newly added famille
                      famillesPathologies[famille].add(pathologies[i]),
                    }
                },
            }
          else
            {
              //Show error
              debugPrint("an error occured")
            }
        });

    return famillesPathologies;
  }

  List<Prescription> getPrescriptions(context) {
    // Provider which contains API call method
    DataProvider dataProvider =
        Provider.of<DataProvider>(context, listen: false);

    // All prescriptions
    List<Prescription> allPrescriptions = new List<Prescription>();

    // Fetch pathologies
    dataProvider.getPrescriptions().then((result) => {
          // If prescriptions fetched
          if (result['status'])
            {
              for (int i = 0; i < result['prescriptions'].length; i++)
                {
                  // Add prescription to list
                  allPrescriptions.add(result['prescriptions'][i])
                },
            }
          else
            {
              //Show error
              debugPrint("an error occured")
            }
        });

    return allPrescriptions;
  }

  List<Prescription> getPrescriptionsByPathologie(prescriptions, pathologie) {
    // List of prescriptions that have the same pathologie
    List<Prescription> pathologiePrescriptions = new List<Prescription>();

    for (int i = 0; i < prescriptions.length; i++) {
      // Get only prescriptions with same pahtologie
      if (prescriptions[i].pathologie == pathologie) {
        // Add prescription to list
        pathologiePrescriptions.add(prescriptions[i]);
      }
    }

    return pathologiePrescriptions;
  }

  List<Prescription> getPrescriptionsByType(prescriptions, type) {
    List<Prescription> prescriptionsByType = new List<Prescription>();

    for (int i = 0; i < prescriptions.length; i++) {
      Prescription prescription = prescriptions[i];

      String numero = prescription.numero;

      if (type == "omise") {
        if (numero[1] == "O" || numero[1] == "0") {
          prescriptionsByType.add(prescription);
        }
      } else {
        if (numero[1] == "I") {
          prescriptionsByType.add(prescription);
        }
      }
    }

    return prescriptionsByType;
  }
}
