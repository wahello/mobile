import 'package:flutter/material.dart';

import 'index.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

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
