import 'Diplome.dart';

class ExistingCompte {
  String id;
  String email;
  String nom;
  String sexe;
  String anneeNaissance;
  String fonction;
  String typeInstitution;
  String nomInstitution;
  String codePostal;
  String ville;
  String pays;
  List<Diplome> diplomes;

  ExistingCompte(
      {this.id,
      this.email,
      this.nom,
      this.sexe,
      this.anneeNaissance,
      this.fonction,
      this.typeInstitution,
      this.nomInstitution,
      this.codePostal,
      this.ville,
      this.pays}) {
    this.diplomes = [];
  }

  //Getters and setters
  String getId() {
    return this.id;
  }

  void setId(String id) {
    this.id = id;
  }

  List<Diplome> getDiplomes() {
    return this.diplomes;
  }

  void setDiplomes(diplomes) {
    this.diplomes = diplomes;
  }

  void addDiplome(Diplome diplome) {
    this.diplomes.add(diplome);
  }

  void deleteDiplome(int index) {
    this.diplomes.removeAt(index);
  }

  // Json encoding for exisiting compte
  Map<String, dynamic> toJson() => {
        'email': email,
        'nom': nom,
        'sexe': sexe,
        'annee': anneeNaissance,
        'fonction': fonction,
        'institution_type': typeInstitution,
        'institution': nomInstitution,
        'npa': codePostal,
        'localite': ville,
        'pays': pays,
        'diplomes': diplomesToJson()
      };

  // Encode diplomes to Json
  List diplomesToJson() {
    List diplomesJson = [];
    for (var i = 0; i < diplomes.length; i++) {
      diplomesJson.add(diplomes[i].toJson());
    }
    return diplomesJson;
  }
}
