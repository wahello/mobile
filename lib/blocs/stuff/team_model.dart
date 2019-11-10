class Team {
  int id;
  String name;

  Team(this.id, this.name);

  Team.fromJson(Map<String, dynamic> json) {
    this.id = json['ID'];
    this.name = json['Name'];
  }

  Map<String, dynamic> toJson() => {'ID': id, 'Name': name};
}
