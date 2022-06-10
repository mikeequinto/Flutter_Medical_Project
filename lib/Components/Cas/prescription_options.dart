import 'package:flutter/material.dart';
import 'package:popi/Styles/styles.dart';

import '../circle_green.dart';
import '../circle_white.dart';

class PrescriptionOptions extends StatefulWidget {
  PrescriptionOptions({
    this.prescriptionId,
    this.options,
    this.reponses,
    this.onTap,
  });

  final int prescriptionId;
  final Map<int, String> options;
  final Map<int, int> reponses;
  final Function onTap;

  PrescriptionOptionsState createState() => PrescriptionOptionsState();
}

class PrescriptionOptionsState extends State<PrescriptionOptions> {
  static int reponseId;

  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var option in widget.options.keys)
          FractionallySizedBox(
              widthFactor: 0.95,
              child: GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Colors.grey[500], width: 0.3),
                    ),
                  ),
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                  child: ListTile(
                    leading: widget.reponses[widget.prescriptionId] == option
                        ? CircleGreen()
                        : CircleWhite(),
                    title: Text(
                      widget.options[option],
                      style: cardBoldStyle,
                    ),
                  ),
                ),
                onTap: (() {
                  widget.onTap(widget.prescriptionId, option);
                }),
              )),
      ],
    );
  }
}
