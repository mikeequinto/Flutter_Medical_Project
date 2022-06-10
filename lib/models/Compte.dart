import 'Diplome.dart';

class Compte {
  String id;
  String email;
  String motDePasse;
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

  Compte(
      {this.id,
      this.email,
      this.motDePasse,
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

  void setMotdepasse(motDePasse) {
    this.motDePasse = motDePasse;
  }

  void addDiplome(Diplome diplome) {
    this.diplomes.add(diplome);
  }

  void deleteDiplome(int index) {
    this.diplomes.removeAt(index);
  }

  // Json parsing
  Compte.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    motDePasse = json['passe'];
    nom = json['nom'];
    sexe = json['sexe'];
    anneeNaissance = json['annee'];
    fonction = json['fonction'];
    typeInstitution = json['institution_type'];
    nomInstitution = json['institution'];
    codePostal = json['npa'];
    ville = json['localite'];
    pays = json['pays'];
    diplomes = [];

    List diplomesJson = json['diplomes'];

    for (var i = 0; i < diplomesJson.length; i++) {
      diplomes.add(Diplome.fromJson(diplomesJson[i]));
    }
  }

  // Json encoding
  Map<String, dynamic> toJson() => {
        'email': email,
        'passe': motDePasse,
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
