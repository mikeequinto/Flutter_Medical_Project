import 'package:flutter/material.dart';
import 'package:popi/Styles/styles.dart';

import '../../constraints.dart';

class CompteCreditsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get size of device
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        // Set width and height of container
        width: double.infinity, // As big as the parent
        height: size.height,

        //Background color
        color: Colors.white,
        child: ListView(
          children: [
            // Screen title
            Container(
              color: kPrimaryColor,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text("Crédits de l'application", style: screenTitle),
                ),
              ),
            ),

            // Screen body
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Text("popi.mail@aphp.fr", style: cardTitleBoldStyle),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Text(remerciements1, style: cardBoldStyle),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Text(remerciements2, style: cardBoldStyle),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Text(remerciements3, style: cardBoldStyle),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Text(remerciements4, style: cardBoldStyle),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Text(remerciements3, style: cardBoldStyle),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Text(remerciements5, style: cardBoldStyle),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Text(remerciements6, style: cardBoldStyle),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: [
                        Text(remerciements7, style: cardBoldStyle),
                        Text(remerciements8, style: cardBoldStyle),
                        Text(remerciements9, style: cardBoldStyle),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: [
                        Text(remerciements10, style: cardBoldStyle),
                        Text(remerciements11, style: cardBoldStyle),
                        Text(remerciements12, style: cardBoldStyle),
                        Text(remerciements13, style: cardBoldStyle),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Text(remerciements14, style: cardBoldStyle),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Text(remerciements15, style: cardBoldStyle),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
