class Gender {
  int id;
  String name;

  Gender(this.id, this.name);

  Gender.fromJson(Map<String, dynamic> json) {
    this.id = json['ID'];
    this.name = json['Name'];
  }

  Map<String, dynamic> toJson() => {'ID': id, 'Name': name};
}
