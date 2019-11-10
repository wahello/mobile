class Championship {
  int id;
  String name;

  Championship(this.id, this.name);

  Championship.fromJson(Map<String, dynamic> json) {
    this.id = json['ID'];
    this.name = json['Name'];
  }

  Map<String, dynamic> toJson() => {'ID': id, 'Name': name};
}
