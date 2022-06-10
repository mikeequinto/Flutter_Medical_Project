class Diplome {
  int id;
  String diplome;
  String annee;

  Diplome(this.diplome, this.annee);

  // Getters and setters
  int getId() {
    return this.id;
  }

  void setId(id) {
    this.id = id;
  }

  String getDiplome() {
    return this.diplome;
  }

  String getAnnee() {
    return this.annee;
  }

  // Json parsing
  Diplome.fromJson(Map<String, dynamic> json)
      : id = int.parse(json['id']),
        diplome = json['diplome'],
        annee = json['annee'];

  Map<String, dynamic> toJson() => {'diplome': diplome, 'annee': annee};
}
