import 'package:popi/models/Compte.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class UserPreferences {
  void saveUser(Compte user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("id", user.id);
    prefs.setString("nom", user.nom);
    prefs.setString("email", user.email);
    prefs.setString("motDePasse", user.motDePasse);
    prefs.setString("sexe", user.sexe);
    prefs.setString("anneeNaissance", user.anneeNaissance);
    prefs.setString("fonction", user.fonction);
    prefs.setString("typeInstitution", user.typeInstitution);
    prefs.setString("nomInstitution", user.nomInstitution);
    prefs.setString("codePostal", user.codePostal);
    prefs.setString("ville", user.ville);
    prefs.setString("pays", user.pays); 
  }

  Future<Compte> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String id = prefs.getString("id");
    String nom = prefs.getString("nom");
    String email = prefs.getString("email");
    String motDePasse = prefs.getString("motDePasse");
    String sexe = prefs.getString("sexe");
    String anneeNaissance = prefs.getString("anneeNaissance");
    String fonction = prefs.getString("fonction");
    String typeInstitution = prefs.getString("typeInstitution");
    String nomInstitution = prefs.getString("nomInstitution");
    String codePostal = prefs.getString("codePostal");
    String ville = prefs.getString("ville");
    String pays = prefs.getString("pays");

    return Compte(
      id: id,
      email: email,
      motDePasse: motDePasse,
      nom: nom,
      sexe: sexe,
      anneeNaissance: anneeNaissance,
      fonction: fonction,
      typeInstitution: typeInstitution,
      nomInstitution: nomInstitution,
      codePostal: codePostal,
      ville: ville,
      pays: pays);
  }

  void removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove("id");
    prefs.remove("nom");
    prefs.remove("email");
    prefs.remove("motDePasse");
    prefs.remove("sexe");
    prefs.remove("anneeNaissance");
    prefs.remove("fonction");
    prefs.remove("typeInstitution");
    prefs.remove("nomInstitution");
    prefs.remove("codePostal");
    prefs.remove("ville");
    prefs.remove("pays");
  }

}