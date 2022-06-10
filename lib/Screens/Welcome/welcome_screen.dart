import 'package:flutter/material.dart';
import 'package:popi/Components/popi_logo.dart';
import 'package:popi/Screens/Login/login_screen.dart';

class WelcomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen())
            );
          },
          child: PopiLogo()
        )
        
      )
    );
  }
}