class Tournament {
  int id;
  String name;

  Tournament(this.id, this.name);

  Tournament.fromJson(Map<String, dynamic> json) {
    this.id = json['ID'];
    this.name = json['Name'];
  }

  Map<String, dynamic> toJson() => {
        'ID': id,
        'Name': name,
      };
}
