// import 'dart:convert';

// import 'package:football_system/blocs/footballField/FootballFieldProvider.dart';

// import 'package:meta/meta.dart';

// import 'FootBallField.dart';
// import 'FootballFieldBloc.dart';

// import 'package:football_system/blocs/stuff/calls_repository.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared/shared.dart';

// class FootballFieldRepository {
//   FootballFieldProvider footballFieldProvider;

//   FootballFieldRepository() {
//     footballFieldProvider = FootballFieldProvider();
//   }

//   Future<List<Module>> getModules() async {
//     http.Response response = await footballFieldProvider.getModules();

//     List<Module> list;
//     var body = jsonDecode(response.body) as List;

//     list = body.map((module) => Module.fromJson(module));
//     return list;
//   }
// }
