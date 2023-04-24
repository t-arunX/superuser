import 'package:flutter/material.dart';
import 'package:superuser/widgets/HomePage.dart';
import 'package:superuser/widgets/components/createForm.dart';

import 'components/Tile.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        dividerColor: Colors.grey,
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}
