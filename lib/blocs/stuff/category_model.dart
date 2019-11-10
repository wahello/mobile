class Category {
  int id;
  String name;

  Category(this.id, this.name);

  Category.fromJson(Map<String, dynamic> json) {
    this.id = json['ID'];
    this.name = json['Name'];
  }

  Map<String, dynamic> toJson() => {'ID': id, 'Name': name};
}
