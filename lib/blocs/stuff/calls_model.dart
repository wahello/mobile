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

class Championship {
  int id;
  String name;
  String createdAt;
  String updatedAt;
  String deletedAt;

  Championship(
      this.id, this.name, this.createdAt, this.deletedAt, this.updatedAt);

  Championship.fromJson(Map<String, dynamic> json) {
    this.id = json['ID'];
    this.name = json['Name'];
    this.createdAt = json['CreatedAt'];
    this.deletedAt = json['DeletedAt'];
    this.updatedAt = json['UpdatedAt'];
  }

  Map<String, dynamic> toJson() => {
        'ID': id,
        'Name': name,
        'CreatedAt': createdAt,
        'DeletedAt': deletedAt,
        'UpdatedAt': updatedAt
      };
}

class Match {
  int id;
  String name;
  String createdAt;
  String updatedAt;
  String deletedAt;

  Match(this.id, this.name, this.createdAt, this.deletedAt, this.updatedAt);

  Match.fromJson(Map<String, dynamic> json) {
    this.id = json['ID'];
    this.name = json['Name'];
    this.createdAt = json['CreatedAt'];
    this.deletedAt = json['DeletedAt'];
    this.updatedAt = json['UpdatedAt'];
  }

  Map<String, dynamic> toJson() => {
        'ID': id,
        'Name': name,
        'CreatedAt': createdAt,
        'DeletedAt': deletedAt,
        'UpdatedAt': updatedAt
      };
}

class Category {
  int id;
  String name;
  String createdAt;
  String updatedAt;
  String deletedAt;

  Category(this.id, this.name, this.createdAt, this.deletedAt, this.updatedAt);

  Category.fromJson(Map<String, dynamic> json) {
    this.id = json['ID'];
    this.name = json['Name'];
    this.createdAt = json['CreatedAt'];
    this.deletedAt = json['DeletedAt'];
    this.updatedAt = json['UpdatedAt'];
  }

  Map<String, dynamic> toJson() => {
        'ID': id,
        'Name': name,
        'CreatedAt': createdAt,
        'DeletedAt': deletedAt,
        'UpdatedAt': updatedAt
      };
}

class Tournament {
  int id;
  String name;
  String createdAt;
  String updatedAt;
  String deletedAt;

  Tournament(
      this.id, this.name, this.createdAt, this.deletedAt, this.updatedAt);

  Tournament.fromJson(Map<String, dynamic> json) {
    this.id = json['ID'];
    this.name = json['Name'];
    this.createdAt = json['CreatedAt'];
    this.deletedAt = json['DeletedAt'];
    this.updatedAt = json['UpdatedAt'];
  }

  Map<String, dynamic> toJson() => {
        'ID': id,
        'Name': name,
        'CreatedAt': createdAt,
        'DeletedAt': deletedAt,
        'UpdatedAt': updatedAt
      };
}
