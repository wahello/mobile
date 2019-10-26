// import 'package:football_system/blocs/user/user_provider.dart';
// import 'package:http/http.dart' as http;
// import 'package:mockito/mockito.dart';
// import 'package:shared/shared.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:test/test.dart' as prefix0;

// class MockClient extends Mock implements http.Client {}

// main() {
//   prefix0.group('userProvider', () {
//     prefix0.test('login', () async {
//       final client = MockClient();
//       final UserProvider userProvider = new UserProvider();
//       when(client.post(Endpoints.loginEndpoint)).thenAnswer(
//           (_) async => http.Response('{"reasonPhrase": "OK"}', 200));

//       prefix0.expect(await userProvider.login('', ''),
//           const prefix0.TypeMatcher<http.Response>());
//     });

//     prefix0.test('newPassword', () async {
//       final client = MockClient();
//       final UserProvider userProvider = new UserProvider();
//       when(client.post(Endpoints.resetPassword)).thenAnswer(
//           (_) async => http.Response('{"reasonPhrase": "OK"}', 200));

//       prefix0.expect(await userProvider.newPassword('', ''),
//           const prefix0.TypeMatcher<http.Response>());
//     });

//     prefix0.test('authenticate', () async {
//       final client = MockClient();
//       final UserProvider userProvider = new UserProvider();
//       SharedPreferences.setMockInitialValues({}); //set values here
//       SharedPreferences pref = await SharedPreferences.getInstance();
//       String token = 'token';
//       pref.setString('token', token);
//       when(client.post(Endpoints.askOtpEndpoint)).thenAnswer(
//           (_) async => http.Response('{"reasonPhrase": "OK"}', 200));

//       prefix0.expect(await userProvider.askOtp('', ''),
//           const prefix0.TypeMatcher<http.Response>());
//     });
//   });
// }
