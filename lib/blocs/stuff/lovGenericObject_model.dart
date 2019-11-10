class LovGenericObject {
  String key;
  String value;

  LovGenericObject(this.key, this.value);

  LovGenericObject.fromJson(Map<String, dynamic> json) {
    this.key = json['key'];
    this.value = json['value'];
  }

  Map<String, dynamic> toJson() => {
        'key': key,
        'value': value,
      };
}
