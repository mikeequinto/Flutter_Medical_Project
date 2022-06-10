import 'package:flutter/material.dart';
import 'package:popi/Screens/Account_Creation/AccountForms/account_form.dart';
import 'package:popi/Styles/styles.dart';

class AccountCreationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get size of device
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        // Set width and height of container
        width: double.infinity, // As big as the parent
        height: size.height,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Align(
            alignment: Alignment.topLeft,
            child: ListView(children: <Widget>[
              Text("Créer un compte", style: screenTitle),
              SizedBox(height: 30),
              NewAccountForm()
            ]),
          ),
        ),
      ),
    );
  }
}
