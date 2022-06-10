import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:popi/Components/Pathologies/pathologies_list_famille.dart';
import 'package:popi/models/Pathologie.dart';

import 'menu_pathologies_item.dart';

class ListPathologies extends StatefulWidget {
  const ListPathologies({this.pathologies, Key key}) : super(key: key);

  final HashMap<String, List<Pathologie>> pathologies;

  @override
  ListPathologiesState createState() => ListPathologiesState();
}

class ListPathologiesState extends State<ListPathologies> {
// HashMap containing famille and bool
  // bool shows/hide pathologies for famille
  HashMap<String, bool> famillesPathologies = new HashMap<String, bool>();

  @override
  Widget build(BuildContext context) {
    // Reinitialize Show/hide when widget rebuilds
    if (famillesPathologies.length == 0) {
      initPathologies();
    }

    return Column(
      children: <Widget>[
        for (var famille in widget.pathologies.keys)
          Column(
            children: [
              // Familles of pathologies
              MenuPathologiesItem(
                label: famille,
                shadow: famillesPathologies[famille],
                onPressed: () => {
                  // Show/hide pathologies of current famille
                  showPathologies(famillesPathologies, famille),
                },
              ),

              // Pathologies
              Visibility(
                  visible: famillesPathologies[famille],
                  child: ListPathologiesFamille(
                    pathologies: widget.pathologies[famille],
                  ))
            ],
          )
      ],
    );
  }

  void showPathologies(famillesPathologies, famille) {
    setState(() {
      famillesPathologies[famille] = !famillesPathologies[famille];
    });
  }

  void initPathologies() {
    // First, we only see the pathologies familles
    widget.pathologies.keys.forEach((key) {
      famillesPathologies[key] = false;
    });
  }
}
