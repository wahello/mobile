class Match {
  int id;
  String name;

  Match(this.id, this.name);

  Match.fromJson(Map<String, dynamic> json) {
    this.id = json['ID'];
    this.name = json['Name'];
  }

  Map<String, dynamic> toJson() => {'ID': id, 'Name': name};
}
