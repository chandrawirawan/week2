import 'package:flutter/material.dart';
import 'package:movpedia/features/all_playlist/view/all_playlist.dart';
import 'package:movpedia/ui/layout/standard_layout.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return StandardLayout(
      appBar: true,
      appBarTitle: Image.asset(
        'assets/logo/logo.png',
        height: 25,
      ),
      bodyWidget: AllPlaylist(),
      bottomBar: true,
    );
  }
}
