import 'package:flutter/material.dart';

import '../constraints.dart';

class TextFormFieldContainer extends StatelessWidget {
  const TextFormFieldContainer({
    this.controller,
    this.text,
    this.value,
    this.hidden,
    this.inputType,
    this.errorMessage,
    this.login,
    this.lightBackground,
    Key key,
  }) : super(key: key);

  final TextEditingController controller;
  final String value;
  final String text;
  final bool hidden;
  final TextInputType inputType;
  final String errorMessage;
  final bool login; //To know if we need to validate password
  final bool lightBackground; // To know if background will be transparent

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // Text field controller (id)
      controller: controller,

      // Input text field style
      decoration: InputDecoration(
        hintText: value == null ? "" : value,
        labelText: text,
        labelStyle: TextStyle(
            color: lightBackground ? kGreyLabel : Colors.white, fontSize: 14.0),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                lightBackground ? BorderSide(width: 0.1) : BorderSide.none),
        enabledBorder: OutlineInputBorder(
            borderSide: lightBackground
                ? BorderSide(color: kGreyLabel)
                : BorderSide.none),
        filled: true,
        fillColor: lightBackground ? klightGreyBackground : kPrimaryLightColor,
        contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      ),
      style: TextStyle(color: lightBackground ? Colors.black : Colors.white),
      keyboardType: inputType,
      obscureText: hidden,

      // Input text validator
      validator: (value) {
        // If input is empty
        if (value == '' && !text.contains("Référence")) {
          return "*Champ obligatoire";
        }

        // If email is correct
        bool emailValid = RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value);

        if (text == "Email" && !emailValid) {
          return "Le format de l'email est incorrect";
        }

        // Check if value is greater than 50
        if (text != "Mot de passe" && value.length > 50)
          return "Le nombre de caractères maximum est 50";

        if (text == "Mot de passe") {
          if (login == null) {
            if (value.length < 6)
              return "Votre mot de passe doit comporter 6 caractères minimum";
          }
        }

        // Validation for date of birth
        if (text.contains('Année')) {
          var now = new DateTime.now();
          try {
            if (int.parse(value.trim()) < 1900 ||
                int.parse(value.trim()) > now.year) return "Année non valide";
          } catch (e) {
            debugPrint(e.toString());
            return "Format invalide";
          }
        }

        // Validation for cas creation
        if (text == "Jour") {
          try {
            if ((int.parse(value.trim()) < 1 || int.parse(value.trim()) > 31)) {
              return "Jour non valide";
            }
          } catch (e) {
            debugPrint(e.toString());
            return "Format invalide";
          }
        }

        if (text == "Mois") {
          try {
            if ((int.parse(value.trim()) < 1 || int.parse(value.trim()) > 12)) {
              return "Mois non valide";
            }
          } catch (e) {
            debugPrint(e.toString());
            return "Format invalide";
          }
        }

        if (text == "Heure") {
          try {
            if ((int.parse(value.trim()) < 0 || int.parse(value.trim()) > 23)) {
              return "Heure non valide";
            }
          } catch (e) {
            debugPrint(e.toString());
            return "Format invalide";
          }
        }

        if (text == "Minute") {
          try {
            if ((int.parse(value.trim()) < 0 || int.parse(value.trim()) > 59)) {
              return "Minute non valide";
            }
          } catch (e) {
            debugPrint(e.toString());
            return "Format invalide";
          }
        }

        return null;
      },
    );
  }
}
