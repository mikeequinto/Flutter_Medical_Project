import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:popi/Components/Pathologies/menu_pathologies_item.dart';
import 'package:popi/Components/circle_green.dart';
import 'package:popi/Components/circle_white.dart';
import 'package:popi/Utilities/fetch_methods.dart';
import 'package:popi/api/DataProvider.dart';
import 'package:popi/Styles/styles.dart';
import 'package:popi/models/Pathologie.dart';
import 'package:provider/provider.dart';

import '../../../constraints.dart';

class AjoutFormDeux extends StatelessWidget {
  Widget build(BuildContext context) {
    // List of pathologies
    HashMap<String, List<Pathologie>> listPathologies =
        FetchMethods().getPathologies(context);

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 20.0),
            child: Text(
              etapeDeuxMessage,
              style: cardSubtitleStyle,
            ),
          ),
          // Wait for data provider
          Consumer<DataProvider>(builder: (context, pathologies, child) {
            if (pathologies.fetchingStatus == Status.fetched) {
              return AjoutFormDeuxAvecState(
                pathologies: listPathologies,
              );
            } else {
              // While pathologies are being fetched
              return CircularProgressIndicator();
            }
          }),
        ]);
  }
}

class AjoutFormDeuxAvecState extends StatefulWidget {
  AjoutFormDeuxAvecState({this.pathologies});

  final HashMap<String, List<Pathologie>> pathologies;

  @override
  State<StatefulWidget> createState() {
    return AjoutFormDeuxState();
  }
}

class AjoutFormDeuxState extends State<AjoutFormDeuxAvecState> {
  // Pathologies of patient
  static final HashMap<String, Pathologie> pathologiesPatient =
      new HashMap<String, Pathologie>();

  static final HashMap<String, bool> showOrHidePathologies =
      new HashMap<String, bool>();

  // Method to clear selection
  void clearForm() {
    pathologiesPatient.clear();
    showOrHidePathologies.clear();
  }

  // Method to add or remove pathologie in patient's list
  addOrRemovePathologie(pathologie) {
    if (pathologiesPatient.containsKey(pathologie.pathologie)) {
      setState(() {
        pathologiesPatient.remove(pathologie.pathologie);
      });
    } else {
      setState(() {
        pathologiesPatient[pathologie.pathologie] = pathologie;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Initialize show or hide
    if (showOrHidePathologies.length == 0) {
      widget.pathologies.keys.forEach((famille) {
        showOrHidePathologies[famille] = false;
      });
    }

    return Column(
      children: <Widget>[
        for (var famille in widget.pathologies.keys)
          Column(
            children: [
              // Familles of pathologies
              MenuPathologiesItem(
                label: famille,
                shadow: showOrHidePathologies[famille],
                onPressed: () => {
                  // Show/hide pathologies of current famille
                  setState(() {
                    showOrHidePathologies[famille] =
                        !showOrHidePathologies[famille];
                  }),
                },
              ),

              // Pathologies
              Visibility(
                visible: showOrHidePathologies[famille],
                child: Container(
                  margin: EdgeInsets.only(bottom: 10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(width: 0.1),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15.0),
                      bottomRight: Radius.circular(15.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      for (var pathologie in widget.pathologies[famille])
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
                                    vertical: 20.0, horizontal: 20.0),
                                child: ListTile(
                                  leading: pathologiesPatient
                                          .containsKey(pathologie.pathologie)
                                      ? CircleGreen()
                                      : CircleWhite(),
                                  title: Text(
                                    pathologie.pathologie,
                                    style: cardBoldStyle,
                                  ),
                                )),
                            onTap: (() {
                              addOrRemovePathologie(pathologie);
                            }),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          )
      ],
    );
  }
}
