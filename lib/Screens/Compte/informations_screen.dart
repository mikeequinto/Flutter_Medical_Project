import 'package:flutter/material.dart';
import 'package:popi/Screens/Account_Creation/AccountForms/account_form.dart';
import 'package:popi/Styles/styles.dart';
import 'package:popi/models/Compte.dart';
import 'package:popi/providers/UserProvider.dart';
import 'package:provider/provider.dart';

import '../../constraints.dart';

class CompteInformationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get size of device
    Size size = MediaQuery.of(context).size;

    // User info
    Compte compte = Provider.of<UserProvider>(context, listen: false).user;

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
                    child: Text("Informations générales", style: screenTitle),
                  )),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              child: NewAccountForm(compte: compte),
            ),
          ],
        ),
      ),
    );
  }
}
