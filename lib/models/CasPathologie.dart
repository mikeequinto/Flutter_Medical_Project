class CasPathologie {
  int id;

  CasPathologie(
    this.id,
  );

  int get getId => id;

  // Json parsing
  CasPathologie.fromJson(Map<String, dynamic> json)
      : id = int.parse(json['id']);

  // Json encode
  Map<String, dynamic> toJson() => {'id': id};
}
