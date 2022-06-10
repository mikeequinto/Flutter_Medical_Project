class Prescription {
  int id;
  String numero;
  int type;
  String prescription;
  bool toutePathologie;
  int filtreSexe;
  int moisMin;
  int moisMax;
  int idPathologie;
  String pathologie;
  String famille;

  Prescription(
      this.id,
      this.numero,
      this.type,
      this.prescription,
      this.toutePathologie,
      this.filtreSexe,
      this.moisMin,
      this.moisMax,
      this.idPathologie,
      this.pathologie,
      this.famille);

  int get getId => id;

  String get getNumero => numero;

  int get getType => type;

  String get getPrescription => prescription;

  bool get getToutePathologie => toutePathologie;

  int get getFiltreSexe => filtreSexe;

  int get getMoisMin => moisMin;

  int get getMoisMax => moisMax;

  int get getIdPathologie => idPathologie;

  String get getPathologie => pathologie;

  String get getFamille => famille;

  // Json parsing
  Prescription.fromJson(Map<String, dynamic> json)
      : id = int.parse(json['id']),
        numero = json['numero'],
        type = int.parse(json['type']),
        prescription = json['prescription'],
        toutePathologie = json['toute_pathologie'],
        filtreSexe = int.parse(json['filtre_sexe']),
        moisMin = int.parse(json['mois_min']),
        moisMax = int.parse(json['mois_max']),
        idPathologie = int.parse(json['id_pathologie']),
        pathologie = json['pathologie'],
        famille = json['famille'];
}
