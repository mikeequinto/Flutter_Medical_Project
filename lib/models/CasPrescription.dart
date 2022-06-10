class CasPrescription {
  int id;
  int reponse;

  CasPrescription(this.id, this.reponse);

  int get getId => id;

  // Json parsing
  CasPrescription.fromJson(Map<String, dynamic> json)
      : id = int.parse(json['id']),
        reponse = int.parse(json['reponse']);

  // Json encode
  Map<String, dynamic> toJson() => {'id': id, 'reponse': reponse};
}
