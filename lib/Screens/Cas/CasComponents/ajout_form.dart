import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:popi/Components/large_button.dart';
import 'package:popi/api/DataProvider.dart';
import 'package:popi/constraints.dart';
import 'package:popi/models/Cas.dart';
import 'package:popi/models/CasPathologie.dart';
import 'package:popi/models/CasPrescription.dart';
import 'package:popi/models/Compte.dart';
import 'package:popi/models/Pathologie.dart';
import 'package:popi/shared_preferences/UserPreferences.dart';
import 'package:provider/provider.dart';

import 'ajout_form_deux.dart';
import 'ajout_form_trois.dart';
import 'ajout_form_un.dart';

class AjoutForm extends StatefulWidget {
  @override
  _AjoutFormState createState() => _AjoutFormState();
}

class _AjoutFormState extends State<AjoutForm> {
  // Stepper variables
  int currentStep = 0;
  bool complete = false;
  bool newForm;

  // Stepper functions
  next() {
    currentStep + 1 != 3
        ? goTo(currentStep + 1)
        : setState(() => complete = true);
  }

  cancel() {
    if (currentStep > 0) {
      goTo(currentStep - 1);
    }
  }

  goTo(int step) {
    setState(() => currentStep = step);
  }

  // Variable if no pathologies selected
  bool showPathologiesAlert = false;

  // Variable if adding new cas failed
  bool showErrorMessage = false;

  // Create new cas
  createCas(infoCas, pathologiesPatient, reponsesPrescriptions) {
    String dateCas = infoCas['CasAnnee'] +
        "-" +
        infoCas['CasMois'] +
        "-" +
        infoCas['CasJour'] +
        " " +
        infoCas['CasHeure'] +
        ":" +
        infoCas['CasMinute'] +
        ":00";

    String dateNaissance = infoCas['naissanceAnnee'] +
        "-" +
        infoCas['naissanceMois'] +
        "-" +
        infoCas['naissanceJour'];

    String reference = infoCas['reference'];
    int duree = 320;
    String commentaire = "";

    List<CasPathologie> casPathologies = new List<CasPathologie>();
    List<CasPrescription> casPrescriptions = new List<CasPrescription>();

    for (var pathologieString in pathologiesPatient.keys) {
      Pathologie pathologie = pathologiesPatient[pathologieString];
      CasPathologie casPathologie = new CasPathologie(pathologie.id);
      casPathologies.add(casPathologie);
    }

    for (var reponse in reponsesPrescriptions.keys) {
      CasPrescription casPrescription =
          new CasPrescription(reponse, reponsesPrescriptions[reponse]);
      casPrescriptions.add(casPrescription);
    }

    Cas cas;

    // Logged in user info
    Future<Compte> compte = UserPreferences().getUser();

    int compteId;

    compte.then((compte) => {
          compteId = int.parse(compte.id),
          cas = new Cas(compteId, dateCas, dateNaissance, reference, duree,
              commentaire, casPathologies, casPrescriptions),
          addCas(cas)
        });
  }

  // Send new cas to server
  void addCas(cas) {
    DataProvider dataProvider =
        Provider.of<DataProvider>(context, listen: false);

    // Create account api call
    dataProvider.addCas(cas).then((casResult) {
      if (casResult['status']) {
        //Clear step forms
        AjoutFormUnState().clearForm();
        AjoutFormDeuxState().clearForm();

        // On successful add, return home
        //Navigator.pushReplacementNamed(context, '/home');
        Navigator.pop(context);
      } else {
        setState(() {
          showErrorMessage = true;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    newForm = true;
  }

  @override
  Widget build(BuildContext context) {
    var mapData = HashMap<String, String>();
    mapData["reference"] = AjoutFormUnState.etReference.text.trim();
    mapData["naissanceJour"] = AjoutFormUnState.etNaissanceJour.text.trim();
    mapData["naissanceMois"] = AjoutFormUnState.etNaissanceMois.text.trim();
    mapData["naissanceAnnee"] = AjoutFormUnState.etNaissanceAnnee.text.trim();
    mapData["CasJour"] = AjoutFormUnState.etCasJour.text.trim();
    mapData["CasMois"] = AjoutFormUnState.etCasMois.text.trim();
    mapData["CasAnnee"] = AjoutFormUnState.etCasAnnee.text.trim();
    mapData["CasHeure"] = AjoutFormUnState.etCasHeure.text.trim();
    mapData["CasMinute"] = AjoutFormUnState.etCasMinute.text.trim();

    var pathologiesPatient = HashMap<String, Pathologie>();
    pathologiesPatient = AjoutFormDeuxState.pathologiesPatient;

    var reponsesPrescriptions = HashMap<int, int>();
    reponsesPrescriptions = AjoutFormTroisState.reponses;

    return Container(
      color: currentStep != 0 ? Colors.grey[100] : Colors.white,
      child: complete
          ? AlertDialog(
              title: new Text("Nouveau cas ajouté"),
              content: new Text(
                "Tada!",
              ),
              actions: <Widget>[
                new FlatButton(
                  child: new Text("Close"),
                  onPressed: () {
                    setState(() => complete = false);
                  },
                ),
              ],
            )
          : Stepper(
              type: StepperType.horizontal,
              steps: [
                Step(
                    title: Text(""),
                    isActive: currentStep >= 0,
                    state: currentStep >= 1
                        ? StepState.complete
                        : StepState.disabled,
                    content: AjoutFormUn(
                      newForm: newForm,
                    )),
                Step(
                  title: Text(""),
                  isActive: currentStep >= 1,
                  state: currentStep >= 2
                      ? StepState.complete
                      : StepState.disabled,
                  content: Container(
                    child: showPathologiesAlert
                        ? AlertDialog(
                            title: Text('Aucune pathologie'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text(
                                      'Veuillez sélectionner au moins une pathologie'),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text('Ok'),
                                onPressed: () {
                                  setState(() {
                                    showPathologiesAlert = false;
                                  });
                                },
                              ),
                            ],
                          )
                        : AjoutFormDeux(),
                  ),
                ),
                Step(
                  title: Text(""),
                  isActive: currentStep == 2,
                  state: currentStep >= 3
                      ? StepState.complete
                      : StepState.disabled,
                  content: Container(
                      child: showErrorMessage
                          ? showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text("Erreur"),
                                  content: Text(alertFailMessage),
                                  actions: [
                                    FlatButton(
                                      child: Text("Fermer"),
                                      onPressed: () {
                                        setState(() {
                                          showErrorMessage = false;
                                        });
                                      },
                                    )
                                  ],
                                );
                              })
                          : AjoutFormTrois(pathologies: pathologiesPatient)),
                )
              ],
              currentStep: currentStep,
              onStepContinue: () {
                //Validation of step 1
                if (currentStep == 0) {
                  if (AjoutFormUnState.formKeyOne.currentState.validate()) {
                    setState(() {
                      newForm = false;
                    });
                    next();
                  }
                }
                // Validation of step 2
                else if (currentStep == 1) {
                  if (pathologiesPatient.length == 0) {
                    setState(() {
                      showPathologiesAlert = true;
                    });
                  } else {
                    AjoutFormTroisState();
                    next();
                  }
                }
                // Validation of step 3
                else {
                  // Create new cas
                  createCas(mapData, pathologiesPatient, reponsesPrescriptions);
                }
              },
              onStepTapped: (step) => goTo(step),
              onStepCancel: cancel,
              // Modified step buttons
              controlsBuilder: (BuildContext context,
                  {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
                return Container(
                    margin: EdgeInsets.only(top: 20.0),
                    child: LargeButton(
                        text: currentStep == 2 ? "VALIDER" : "SUIVANT",
                        color: kPrimaryColor,
                        size: 80,
                        onPressed: onStepContinue));
              }),
    );
  }
}
