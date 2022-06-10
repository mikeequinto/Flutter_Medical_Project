import 'package:flutter/material.dart';
import 'package:popi/Components/popi_logo.dart';
import 'package:popi/Screens/Account_Creation/account_creation_screen.dart';
import 'package:popi/Screens/Password_Recovery/passowrd_recovery_screen.dart';

import 'LoginComponents/login_form.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get size of device
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Container(
        width: double.infinity, // As big as the parent
        height: size.height,

        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView(shrinkWrap: true, children: <Widget>[
              // POPI logo
              Center(
                child: PopiLogo(),
              ),
              SizedBox(height: 20), // Spacing between elements

              Container(
                  child: Text(
                      "Pour profiter pleinement de l'application, veuillez vous connecter")),
              SizedBox(height: 30),

              // Login form
              LoginForm(),
              SizedBox(height: 30),

              // Password recovery
              Center(
                child: TextLink(
                  text: "Mot de passe oublié?",
                  screen: PasswordRecoveryScreen(),
                ),
              ),
              SizedBox(height: 20),

              // Account creation
              Center(
                child: TextLink(
                  text: "S'inscrire",
                  screen: AccountCreationScreen(),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class TextLink extends StatelessWidget {
  const TextLink({
    this.text,
    this.screen,
    Key key,
  }) : super(key: key);

  final String text;
  final Widget screen;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => screen));
        },
        child:
            Text(text, style: TextStyle(decoration: TextDecoration.underline)));
  }
}
