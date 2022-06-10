import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:popi/Styles/styles.dart';

class CasCard extends StatelessWidget {
  const CasCard({this.title, this.subtitle, this.date, this.onTap, Key key})
      : super(key: key);

  final String title;
  final String subtitle;
  final String date;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
          margin: EdgeInsets.only(bottom: 10.0),
          child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              child: Container(
                  padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
                  child: Column(
                    children: [
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 15.0, bottom: 5.0),
                            child: Text("Patient né le " + title,
                                style: cardTitleBoldStyle),
                          )),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 15.0, bottom: 5.0),
                            child: Text(subtitle, style: cardSubtitleStyle),
                          )),
                      Align(
                          alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 15.0, bottom: 5.0),
                            child: Text(date, style: cardDateStyle),
                          )),
                    ],
                  ))),
        ),
        onTap: onTap);
  }
}
