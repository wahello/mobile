import 'package:flutter/material.dart';
import 'package:football_system/blocs/stuff/calls_repository.dart';

import '../user/user_repository.dart';
import 'index.dart';

class HomePage extends StatefulWidget {
  final UserRepository userRepository;
  final CallsRepository callsRepository;

  HomePage(
      {Key key, @required this.userRepository, @required this.callsRepository})
      : assert(userRepository != null && callsRepository != null),
        super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
