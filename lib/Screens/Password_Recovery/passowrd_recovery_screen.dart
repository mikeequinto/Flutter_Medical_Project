import 'package:flutter/material.dart';
import 'package:popi/Components/submit_button.dart';
import 'package:popi/Components/text_field_container.dart';
import 'package:popi/Styles/styles.dart';
import 'package:popi/api/AuthProvider.dart';
import 'package:popi/constraints.dart';

class PasswordRecoveryScreen extends StatefulWidget {
  PasswordRecoveryScreenState createState() => PasswordRecoveryScreenState();
}

class PasswordRecoveryScreenState extends State<PasswordRecoveryScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController etEmail = new TextEditingController();

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
              // Title
              Text("Mot de passe oublié ?", style: screenTitle),
              SizedBox(height: 30),

              // Subtitle
              Text(
                "Entrez votre email pour recevoir un lien pour récupérer votre compte",
              ),
              SizedBox(height: 30),

              Form(
                key: _formKey,
                child: TextFormFieldContainer(
                  controller: etEmail,
                  text: "Email",
                  inputType: TextInputType.emailAddress,
                  hidden: false,
                  lightBackground: false,
                ),
              ),
              // Email input

              SizedBox(height: 40),

              // Submit button
              SubmitButton(
                text: "VALIDER",
                lightBackground: false,
                onPressed: () {
                  recoverPassword(context);
                },
              )
            ]),
          ),
        ),
      ),
    );
  }

  void recoverPassword(context) {
    if (_formKey.currentState.validate()) {
      //Verify if email is taken
      AuthProvider().verifyEmail(etEmail.text).then((result) {
        if (result['taken']) {
          // Email exists

          AuthProvider().generatePassword(etEmail.text).then((resultEmail) {
            if (resultEmail['status']) {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Succès"),
                      content: Text(recoverySuccessful),
                      actions: [
                        FlatButton(
                          child: Text("Retour à la page de connexion"),
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    );
                  });
            } else {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Erreur"),
                      content: Text(alertFailMessage),
                      actions: [
                        FlatButton(
                          child: Text("D'accord"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    );
                  });
            }
          });
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Erreur"),
                  content: Text(emailInconnu),
                  actions: [
                    FlatButton(
                      child: Text("D'accord"),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
        }
      });
    }
  }
}
