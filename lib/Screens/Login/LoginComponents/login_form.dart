import 'package:flutter/material.dart';
import 'package:popi/Components/submit_button.dart';
import 'package:popi/Components/text_field_container.dart';
import 'package:popi/Styles/styles.dart';
import 'package:popi/api/AuthProvider.dart';
import 'package:popi/models/Compte.dart';
import 'package:popi/providers/UserProvider.dart';
import 'package:popi/shared_preferences/UserPreferences.dart';
import 'package:provider/provider.dart';

import '../../../constraints.dart';

// Define a custom Form widget.
class LoginForm extends StatefulWidget {
  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  //Email and password controllers
  TextEditingController etEmail = new TextEditingController();
  TextEditingController etPassword = new TextEditingController();

  //Variable to show error if unsuccessful login
  bool _loginError = false;
  bool _wrongCredentials = false;

  //Show or hide loading circle
  bool _authenticating = false;

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(key: _formKey, child: Column(children: getFormWidget()));
  }

  List<Widget> getFormWidget() {
    List<Widget> formWidget = new List();

    // Email
    formWidget.add(TextFormFieldContainer(
      controller: etEmail,
      text: "Email",
      hidden: false,
      lightBackground: false,
      inputType: TextInputType.text,
    ));
    formWidget.add(SizedBox(height: 30));

    // Mot de passe
    formWidget.add(TextFormFieldContainer(
        controller: etPassword,
        text: "Mot de passe",
        hidden: true,
        lightBackground: false,
        inputType: TextInputType.text,
        login: true));
    formWidget.add(SizedBox(height: 30));

    formWidget.add(Visibility(
        visible: _authenticating,
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(),
              Text(" Authenticating ... Please wait")
            ],
          )
        ])));

    // Error message if unsuccessful login
    formWidget.add(Visibility(
        visible: _loginError,
        child: Column(children: [
          Text(_wrongCredentials ? loginErrorMessage : serverConnectionError,
              style: loginErrorMessageStyle),
          SizedBox(
            height: 30,
          )
        ])));

    // Create account button
    formWidget.add(SubmitButton(
        text: "SE CONNECTER",
        lightBackground: false,
        onPressed: (() {
          handleLogin(context);
        })));

    return formWidget;
  }

  handleLogin(context) {
    // If form inputs correct
    if (_formKey.currentState.validate()) {
      AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);

      var email = etEmail.text.trim();
      var password = etPassword.text.trim();

      auth.login(email, password).then((result) => {
            // If login successful
            if (result['status'])
              {
                // Get user info
                auth.getInfoCompte(result['userId']).then((compteResult) {
                  // If user found
                  if (compteResult['status']) {
                    Compte user = compteResult['compte'];
                    user.setMotdepasse(etPassword.text);
                    Provider.of<UserProvider>(context, listen: false)
                        .setUser(user);
                    UserPreferences().saveUser(user);
                  }
                }),
                setState(() {
                  _authenticating = false;
                  _wrongCredentials = false;
                })
              }
            else
              {
                setState(() {
                  _authenticating = false;
                  _loginError = true;
                  _wrongCredentials =
                      result['message'] == 'wrong credentials' ? true : false;
                })
              }
          });
    }
  }
}
