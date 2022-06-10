import 'package:popi/models/CasPathologie.dart';

import 'CasPrescription.dart';

class Cas {
  int id;
  int compteId;
  String date;
  String naissance;
  String reference;
  int duree;
  String commentaire;
  List<CasPathologie> pathologies;
  List<CasPrescription> prescriptions;

  Cas(
    this.compteId,
    this.date,
    this.naissance,
    this.reference,
    this.duree,
    this.commentaire,
    this.pathologies,
    this.prescriptions,
  );

  int get getId => id;

  void setId(int id) {
    this.id = id;
  }

  int get getCompteId => compteId;

  String get getDate => date;

  String get getNaissance => naissance;

  String get getReference => reference;

  int get getDuree => duree;

  String get getCommentaire => commentaire;

  List<CasPathologie> get getPathologies => pathologies;

  List<CasPrescription> get getPrescriptions => prescriptions;

  // Json parsing
  Cas.fromJson(Map<String, dynamic> json) {
    id = int.parse(json['id']);
    compteId = int.parse(json['compte_id']);
    date = json['date'];
    naissance = json['naissance'];
    reference = json['reference'];
    duree = int.parse(json['duree']);
    commentaire = json['commentaire'];
    pathologies = [];
    prescriptions = [];

    List pathologiesJson = json['pathologies'];

    for (var i = 0; i < pathologiesJson.length; i++) {
      pathologies.add(CasPathologie.fromJson(pathologiesJson[i]));
    }

    List prescriptionsJson = json['prescriptions'];

    for (var i = 0; i < prescriptionsJson.length; i++) {
      prescriptions.add(CasPrescription.fromJson(prescriptionsJson[i]));
    }
  }

  // Json encoding
  Map<String, dynamic> toJson() => {
        'compte_id': compteId,
        'date': date,
        'naissance': naissance,
        'reference': reference,
        'duree': duree,
        'commentaire': commentaire,
        'pathologies': pathologiesToJson(),
        'prescriptions': prescriptionsToJson(),
      };

  List pathologiesToJson() {
    List pathologiesJson = [];
    for (var i = 0; i < pathologies.length; i++) {
      pathologiesJson.add(pathologies[i].toJson());
    }
    return pathologiesJson;
  }

  List prescriptionsToJson() {
    List prescriptionsJson = [];
    for (var i = 0; i < prescriptions.length; i++) {
      prescriptionsJson.add(prescriptions[i].toJson());
    }
    return prescriptionsJson;
  }
}
