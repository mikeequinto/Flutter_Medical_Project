import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:popi/Components/Cas/alert_update.dart';
import 'package:popi/Components/large_button.dart';
import 'package:popi/Screens/Cas/CasComponents/ajout_form_un.dart';
import 'package:popi/Styles/styles.dart';
import 'package:popi/Utilities/fetch_methods.dart';
import 'package:popi/api/DataProvider.dart';
import 'package:popi/constraints.dart';
import 'package:popi/models/Cas.dart';
import 'package:popi/models/CasPrescription.dart';
import 'package:popi/models/Compte.dart';
import 'package:popi/models/Pathologie.dart';
import 'package:popi/models/Prescription.dart';
import 'package:provider/provider.dart';
import 'CasComponents/modification_prescriptions_tab.dart';

class InformationsCasScreen extends StatefulWidget {
  InformationsCasScreen({
    this.compte,
    this.cas,
    this.pathologies,
    this.prescriptions, // All prescriptions
  });

  final Compte compte;
  final Cas cas;
  final List<Pathologie> pathologies;
  final List<Prescription> prescriptions;

  @override
  InformationsCasScreenState createState() => InformationsCasScreenState();
}

class InformationsCasScreenState extends State<InformationsCasScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  HashMap<Pathologie, List<Prescription>> pathologiesPrescriptions =
      new HashMap<Pathologie, List<Prescription>>();

  List<CasPrescription> prescriptionsReponses = new List<CasPrescription>();

  @override
  void initState() {
    _tabController = new TabController(length: 2, vsync: this);
    super.initState();

    for (var pathologie in widget.pathologies) {
      // Initialize list prescription for pathologie
      pathologiesPrescriptions[pathologie] = FetchMethods()
          .getPrescriptionsByPathologie(
              widget.prescriptions, pathologie.pathologie);
    }

    // Initialize forms
    AjoutFormUnState().displayCasInfo(widget.cas);
    ModificationPrescriptionsTabState().initialize(widget.cas.prescriptions);
  }

  void modifyCas(mapData) async {
    String date = mapData['CasAnnee'] +
        "-" +
        mapData['CasMois'] +
        "-" +
        mapData['CasJour'] +
        " " +
        mapData['CasHeure'] +
        ":" +
        mapData['CasMinute'] +
        ":00";

    String naissance = mapData['naissanceAnnee'] +
        "-" +
        mapData['naissanceMois'] +
        "-" +
        mapData['naissanceJour'];

    String reference = mapData['reference'];

    HashMap<int, int> reponses = ModificationPrescriptionsTabState.reponses;

    for (var reponse in reponses.keys) {
      CasPrescription casPrescription =
          new CasPrescription(reponse, reponses[reponse]);
      prescriptionsReponses.add(casPrescription);
    }

    Cas cas = new Cas(
        int.parse(widget.compte.id),
        date,
        naissance,
        reference,
        widget.cas.duree,
        widget.cas.commentaire,
        widget.cas.pathologies,
        prescriptionsReponses);

    cas.setId(widget.cas.id);

    updateCas(cas);
  }

  Future<void> updateCas(Cas cas) async {
    DataProvider dataProvider =
        Provider.of<DataProvider>(context, listen: false);

    dataProvider.updateCas(cas).then((result) => {
          // If update successful
          if (result['status'])
            {
              showDialog<void>(
                  context: context,
                  barrierDismissible: false, // user must tap button!
                  builder: (BuildContext context) {
                    return AlertUpdate(
                        title: "Succès",
                        message: alertSuccessMessage,
                        dismiss: "Retour à la consultation");
                  }),
            }
          else
            {
              showDialog<void>(
                  context: context,
                  barrierDismissible: false, // user must tap button!
                  builder: (BuildContext context) {
                    return AlertUpdate(
                        title: "Erreur",
                        message: alertFailMessage,
                        dismiss: "Retour à la consultation");
                  }),
            }
        });
  }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Annuler"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Continuer"),
      onPressed: () {
        deleteCas(context);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Attention"),
      content: Text(deleteConfirmation),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  void deleteCas(context) {
    DataProvider dataProvider =
        Provider.of<DataProvider>(context, listen: false);

    dataProvider.deleteCas(widget.cas.id).then((result) => {
          // If update successful
          if (result['status'])
            {
              // Go back 2 pages, the first is the current cas
              Navigator.pop(context),
              Navigator.pop(context),
            }
          else
            {
              showDialog<void>(
                  context: context,
                  barrierDismissible: false, // user must tap button!
                  builder: (BuildContext context) {
                    return AlertUpdate(
                        title: "Erreur",
                        message: alertFailMessage,
                        dismiss: "Retour à la consultation");
                  }),
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    // Get size of device
    Size size = MediaQuery.of(context).size;

    // Get form data
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

    return new Scaffold(
        // To avoid resiying when keyboard appears
        resizeToAvoidBottomPadding: false,
        appBar: new AppBar(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          title: Text(
            "Cas",
            style: screenTitle,
          ),
          bottom: TabBar(
            unselectedLabelColor: Colors.grey[400],
            labelColor: Colors.white,
            tabs: [
              new Tab(icon: Text("Informations")),
              new Tab(icon: Text("Prescription(s)")),
            ],
            controller: _tabController,
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,
          ),
          bottomOpacity: 1,
        ),
        body: Container(
          child: Stack(
            children: [
              TabBarView(
                children: [
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(20.0),
                    child: AjoutFormUn(),
                  ),
                  Container(
                    color: Colors.grey[100],
                    child: ModificationPrescriptionsTab(
                      fonction: widget.compte.fonction,
                      pathologiesPrescriptions: pathologiesPrescriptions,
                      //pathologie: widget.pathologie,
                      prescriptionsReponses: widget.cas.prescriptions,
                    ),
                  ),
                ],
                controller: _tabController,
              ),
              Positioned(
                bottom: size.height * 7 / 100,
                child: Container(
                  width: size.width,
                  alignment: FractionalOffset.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      LargeButton(
                        text: "METTRE À JOUR",
                        color: kPrimaryColor,
                        size: 41,
                        onPressed: (() {
                          modifyCas(mapData);
                        }),
                      ),
                      LargeButton(
                        text: "SUPPRIMER",
                        color: kWarningColor,
                        size: 41,
                        onPressed: (() {
                          showAlertDialog(context);
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
