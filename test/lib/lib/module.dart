class Module {
  //ARRAY CHE CONTIENE LE POSIZIONI DEI GIOCATORI NELLA "SCACCHIERA".
  final List<String> fieldPostions;
  //NOME DEL MODULO. ES:4-4-2
  final String name;

  Module({this.fieldPostions, this.name});

  factory Module.fromJson(Map<String, dynamic> json) {
    return Module(
      fieldPostions: json["fieldPostions"] as List<String>,
      name: json["name"],
    );
  }
}
