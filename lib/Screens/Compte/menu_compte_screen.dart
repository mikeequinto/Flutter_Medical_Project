import 'package:flutter/material.dart';
import 'package:popi/Screens/Compte/credits_screen.dart';
import 'package:popi/Screens/Compte/informations_screen.dart';
import 'package:popi/Screens/Compte/diplomes_screen.dart';
import 'package:popi/providers/UserProvider.dart';
import 'package:popi/shared_preferences/UserPreferences.dart';
import 'package:provider/provider.dart';

import '../../Components/Compte/menu_compte_item.dart';
import 'diplomes_screen.dart';
import 'informations_screen.dart';

class MenuCompte extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // Informations générales
      MenuCompteItem(
        icon: 'assets/icons/resume.png',
        label: 'Informations générales',
        onPressed: () => {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CompteInformationsScreen()))
        },
      ),

      // Diplômes
      MenuCompteItem(
        icon: 'assets/icons/certificate.png',
        label: 'Diplômes',
        onPressed: () => {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CompteDiplomesScreen()))
        },
      ),

      // Crédits de l'application
      MenuCompteItem(
        icon: 'assets/icons/greeting-card.png',
        label: "Crédits de l'application",
        onPressed: () => {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CompteCreditsScreen()))
        },
      ),

      // Déconnexion
      MenuCompteItem(
        icon: 'assets/icons/logout.png',
        label: 'Déconnexion',
        onPressed: () => {
          logout(context)
          /*UserPreferences().removeUser(),
          Provider.of<UserProvider>(context, listen: false).removeUser(),*/
        },
      ),
    ]);
  }

  void logout(context) {
    UserPreferences().removeUser();
    Provider.of<UserProvider>(context, listen: false).removeUser();
  }
}
