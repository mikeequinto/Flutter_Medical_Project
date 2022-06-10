class Pathologie {
  int id;
  String pathologie;
  String famille;

  Pathologie(this.id, this.pathologie, this.famille);

  int getId() {
    return this.id;
  }

  String getPathologie() {
    return this.pathologie;
  }

  String getFamille() {
    return this.famille;
  }

  String toString() {
    return "id: " +
        this.id.toString() +
        ", pathologie: " +
        this.pathologie +
        ", famille: " +
        this.famille;
  }

  // Json parsing
  Pathologie.fromJson(Map<String, dynamic> json)
      : id = int.parse(json['id']),
        pathologie = json['pathologie'],
        famille = json['famille'];
}
