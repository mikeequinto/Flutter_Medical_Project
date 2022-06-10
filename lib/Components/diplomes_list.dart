import 'package:flutter/material.dart';
import 'package:popi/models/Compte.dart';
import 'package:popi/models/Diplome.dart';

import '../constraints.dart';

class DiplomeList extends StatefulWidget {
  const DiplomeList(
      {this.compte, this.lightBackground, this.updateMethod, Key key})
      : super(key: key);

  final Compte compte;
  final bool lightBackground;
  final VoidCallback updateMethod;

  @override
  _DiplomeListState createState() => _DiplomeListState();
}

class _DiplomeListState extends State<DiplomeList> {
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start, children: showDiplomes());
  }

  showDiplomes() {
    Compte compte = widget.compte;

    // Widget list containing diplomas
    List<Widget> diplomeWidgetList = new List();

    diplomeWidgetList.add(
      Align(
        alignment: Alignment.centerLeft,
        child: Container(
          child: Text("Diplômes :",
              style: widget.lightBackground
                  ? TextStyle(color: kGreyLabel)
                  : TextStyle(color: Colors.white)),
        ),
      ),
    );
    diplomeWidgetList.add(SizedBox(height: 20));

    // Compte diplomes list
    List<Diplome> diplomesList = widget.compte.getDiplomes();

    for (var i = 0; i < widget.compte.getDiplomes().length; i++) {
      String diplomeName = diplomesList[i].getDiplome();
      if (diplomeName.length > 21) {
        diplomeName = diplomeName.substring(0, 22) + "...";
      }

      diplomeWidgetList.add(
        Container(
            child: Column(children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              "- " + diplomeName + ", " + diplomesList[i].annee,
              style: widget.lightBackground
                  ? TextStyle(color: Colors.black)
                  : TextStyle(color: Colors.white),
            ),
            GestureDetector(
                child: CircleAvatar(
                  child: ImageIcon(
                    AssetImage('assets/icons/close.png'),
                    color: widget.lightBackground ? Colors.black : Colors.white,
                    size: 15.0,
                  ),
                  radius: 15.0,
                  backgroundColor: widget.lightBackground
                      ? klightGreyBackground
                      : kPrimaryLightColor,
                ),
                onTap: () {
                  setState(() {
                    compte.deleteDiplome(i);
                  });
                  if (widget.lightBackground) {
                    widget.updateMethod();
                  }
                }),
          ]),
          SizedBox(height: 20)
        ])),
      );
    }

    return diplomeWidgetList;
  }
}
