import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popi/Components/text_field_container.dart';
import 'package:popi/Styles/styles.dart';
import 'package:popi/models/Cas.dart';

class AjoutFormUn extends StatefulWidget {
  AjoutFormUn({this.newForm});

  final bool newForm;

  @override
  State<StatefulWidget> createState() {
    return AjoutFormUnState();
  }
}

class AjoutFormUnState extends State<AjoutFormUn> {
  // Form state
  static final formKeyOne = GlobalKey<FormState>();

  // Text editing controllers will let us retrieve field values
  static TextEditingController etReference = new TextEditingController();
  static TextEditingController etNaissanceJour = new TextEditingController();
  static TextEditingController etNaissanceMois = new TextEditingController();
  static TextEditingController etNaissanceAnnee = new TextEditingController();
  static TextEditingController etCasJour = new TextEditingController();
  static TextEditingController etCasMois = new TextEditingController();
  static TextEditingController etCasAnnee = new TextEditingController();
  static TextEditingController etCasHeure = new TextEditingController();
  static TextEditingController etCasMinute = new TextEditingController();

  // Values if cas is not null
  String anneeNaissance;
  String moisNaissance;
  String jourNaissance;

  void clearForm() {
    etReference.text = "";
    etNaissanceJour.text = "";
    etNaissanceMois.text = "";
    etNaissanceAnnee.text = "";
    etCasJour.text = "";
    etCasMois.text = "";
    etCasAnnee.text = "";
    etCasHeure.text = "";
    etCasMinute.text = "";
  }

  @override
  void initState() {
    super.initState();
    if (widget.newForm != null && widget.newForm) {
      clearForm();
    }
  }

  void displayCasInfo(Cas cas) {
    // Get Annee,Mois,Jour of naissance
    String fullDateNaissance = cas.naissance;
    List<String> anneeMoisJourNaissance = fullDateNaissance.split("-");

    // Get Annee,Mois,Jour,Heure,Minute of date cas
    String fullDateCas = cas.date;
    List<String> dateHeureCas = fullDateCas.split(" ");
    String dateCas = dateHeureCas[0];
    String heure = dateHeureCas[1];
    List<String> anneeMoisJourCas = dateCas.split("-");
    List<String> heureMinuteSecondes = heure.split(":");

    // Display current information
    etReference.text = cas.reference;
    etNaissanceAnnee.text = anneeMoisJourNaissance[0];
    etNaissanceMois.text = anneeMoisJourNaissance[1];
    etNaissanceJour.text = anneeMoisJourNaissance[2];
    etCasAnnee.text = anneeMoisJourCas[0];
    etCasMois.text = anneeMoisJourCas[1];
    etCasJour.text = anneeMoisJourCas[2];
    etCasHeure.text = heureMinuteSecondes[0];
    etCasMinute.text = heureMinuteSecondes[1];
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: formKeyOne,
        child: Column(children: [
          // Référence personnelle
          TextFormFieldContainer(
            controller: etReference,
            text: "Référence personnelle (optionnelle)",
            hidden: false,
            inputType: TextInputType.text,
            lightBackground: true,
          ),
          // Patient Naissance Row
          Container(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      child: Text(
                    "Patient né le",
                    style: cardSubtitleStyle,
                  )),
                  Container(
                    width: 60.0,
                    child: TextFormFieldContainer(
                      controller: etNaissanceJour,
                      value: jourNaissance != null ? jourNaissance : "",
                      text: "Jour",
                      inputType: TextInputType.number,
                      lightBackground: true,
                      hidden: false,
                    ),
                  ),
                  Container(
                    width: 60.0,
                    child: TextFormFieldContainer(
                      controller: etNaissanceMois,
                      text: "Mois",
                      inputType: TextInputType.number,
                      lightBackground: true,
                      hidden: false,
                    ),
                  ),
                  Container(
                    width: 80.0,
                    child: TextFormFieldContainer(
                      controller: etNaissanceAnnee,
                      text: "Année",
                      inputType: TextInputType.number,
                      lightBackground: true,
                      hidden: false,
                    ),
                  )
                ],
              )),
          // Cas effectué le label
          Container(
              padding: EdgeInsets.only(bottom: 20.0),
              alignment: Alignment.topLeft,
              child: Text(
                "Cas effectuée le",
                style: cardSubtitleStyle,
              )),
          // Date ajout row
          Container(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Row(
                children: [
                  Container(
                    width: 60.0,
                    margin: EdgeInsets.only(right: 9.0),
                    child: TextFormFieldContainer(
                      controller: etCasJour,
                      text: "Jour",
                      inputType: TextInputType.number,
                      lightBackground: true,
                      hidden: false,
                    ),
                  ),
                  Container(
                    width: 60.0,
                    margin: EdgeInsets.only(right: 9.0),
                    child: TextFormFieldContainer(
                      controller: etCasMois,
                      text: "Mois",
                      inputType: TextInputType.number,
                      lightBackground: true,
                      hidden: false,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(right: 11.0),
                    width: 80.0,
                    child: TextFormFieldContainer(
                      controller: etCasAnnee,
                      text: "Année",
                      inputType: TextInputType.number,
                      lightBackground: true,
                      hidden: false,
                    ),
                  ),
                  Container(
                      child: Text(
                    "à",
                    style: cardSubtitleStyle,
                  )),
                ],
              )),
          // Heure minutes row
          Container(
              margin: EdgeInsets.only(bottom: 25.0),
              child: Row(
                children: [
                  Container(
                    width: 60.0,
                    margin: EdgeInsets.only(right: 9.0),
                    child: TextFormFieldContainer(
                      controller: etCasHeure,
                      text: "Heure",
                      inputType: TextInputType.number,
                      lightBackground: true,
                      hidden: false,
                    ),
                  ),
                  Container(
                    width: 60.0,
                    child: TextFormFieldContainer(
                      controller: etCasMinute,
                      text: "Minute",
                      inputType: TextInputType.number,
                      lightBackground: true,
                      hidden: false,
                    ),
                  ),
                ],
              ))
        ]));
  }
}
