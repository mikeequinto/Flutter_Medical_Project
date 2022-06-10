import 'package:flutter/material.dart';

// Dropdown options
List<DropdownMenuItem> sexeList = [
  new DropdownMenuItem(
    child: new Text('Sexe'),
    value: 'label',
  ),
  new DropdownMenuItem(
    child: new Text('Homme'),
    value: "0",
  ),
  new DropdownMenuItem(
    child: new Text('Femme'),
    value: "1",
  ),
];

List<DropdownMenuItem> fonctionList = [
  new DropdownMenuItem(
    child: new Text('Fonction'),
    value: 'label',
  ),
  new DropdownMenuItem(
    child: new Text('Infirmier'),
    value: 'Infirmier',
  ),
  new DropdownMenuItem(
    child: new Text('Infirmier (Etudiant)'),
    value: 'Infirmier (Etudiant)',
  ),
  new DropdownMenuItem(
    child: new Text('Médecin'),
    value: 'Médecin',
  ),
  new DropdownMenuItem(
    child: new Text('Médecin (Interne)'),
    value: 'Médecin (Interne)',
  ),
  new DropdownMenuItem(
    child: new Text('Médecin (Etudiant)'),
    value: 'Médecin (Etudiant)',
  ),
  new DropdownMenuItem(
    child: new Text('Pharmacien'),
    value: 'Pharmacien',
  ),
  new DropdownMenuItem(
    child: new Text('Pharmacien (Interne)'),
    value: 'Pharmacien (Interne)',
  ),
  new DropdownMenuItem(
    child: new Text('Pharmacien (Etudiant)'),
    value: 'Pharmacien (Etudiant)',
  ),
  new DropdownMenuItem(
    child: new Text('Préparateur en pharmacie'),
    value: 'Préparateur en pharmacie',
  ),
  new DropdownMenuItem(
    child: new Text('Préparateur en pharmacie (Etudiant)'),
    value: 'Préparateur en pharmacie (Etudiant)',
  ),
  new DropdownMenuItem(
    child: new Text('Autre'),
    value: 'fonctionAutre',
  ),
];

List<DropdownMenuItem> instituteTypeList = [
  new DropdownMenuItem(
    child: new Text("Type d'institution"),
    value: 'label',
  ),
  new DropdownMenuItem(
    child: new Text('Centre Hospitalier'),
    value: 'Centre Hospitalier',
  ),
  new DropdownMenuItem(
    child: new Text('Exercice libéral'),
    value: 'Exercice libéral',
  ),
  new DropdownMenuItem(
    child: new Text('Maison de santé'),
    value: 'Maison de santé',
  ),
  new DropdownMenuItem(
    child: new Text("Pharmacie d'officine"),
    value: "Pharmacie d'officine",
  ),
  new DropdownMenuItem(
    child: new Text('Autre'),
    value: 'institutionAutre',
  ),
];

List<DropdownMenuItem> diplomeList = [
  new DropdownMenuItem(
    child: new Text("Diplôme"),
    value: 'label',
  ),
  new DropdownMenuItem(
    child: new Text('Brevet de préparateur en pharmacie'),
    value: 'Brevet de préparateur en pharmacie',
  ),
  new DropdownMenuItem(
    child: new Text('Doctorat en médecine'),
    value: 'Doctorat en médecine',
  ),
  new DropdownMenuItem(
    child: new Text('Doctorat en pharmacie'),
    value: 'Doctorat en pharmacie',
  ),
  new DropdownMenuItem(
    child: new Text('Doctorat de sciences'),
    value: 'Doctorat de sciences',
  ),
  new DropdownMenuItem(
    child: new Text('Master 1'),
    value: 'Master 1',
  ),
  new DropdownMenuItem(
    child: new Text('Master 2'),
    value: 'Master 2',
  ),
  new DropdownMenuItem(
    child: new Text('Autre'),
    value: 'diplomeAutre',
  ),
];

// Options responses for pathologies
Map<int, String> prescriptionsOmisesOption = {
  1: "Je l'ai déjà prescrit",
  2: "J'ai failli oublié de le prescrire",
  3: "Je ne l'ai pas prescrit, mais je confirme que je ne veux pas le prescrire",
  4: "Non applicable dans ce cas"
};

Map<int, String> prescriptionsInapproprieesOption = {
  5: "Je l'ai prescrit mais je vais arrêter/modifier la prescription",
  6: "Je l'ai prescrit et je maintiens la prescription",
  7: "Je ne l'ai pas prescrit",
  8: "Non applicable dans ce cas"
};

Map<int, String> prescriptionsOmisesAutreOption = {
  9: "Est déjà prescrit",
  10: "N'est pas prescrit, je vais considérer l'ajout (avec contact du prescripteur si nécessaire)",
  11: "N'est pas prescrit, mais je ne veux pas que ce soit ajouté",
  12: "Non applicable dans ce cas"
};

Map<int, String> prescriptionsInapproprieesAutreOption = {
  13: "A été prescrit, je vais contacter le prescripteur pour discuter de l'arrêt/modification",
  14: "A été prescrit et je suis d'accord pour dispenser/administrer",
  15: "N'a pas été prescrit",
  16: "Non applicable dans ce cas"
};
