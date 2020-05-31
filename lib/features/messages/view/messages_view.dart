import 'package:flutter/material.dart';
import 'package:movpedia/theme.dart';
import 'package:movpedia/ui/layout/standard_layout.dart';

class MessagesScreen extends StatelessWidget {
  static String routeName = './message';
  const MessagesScreen();

  @override
  Widget build(BuildContext context) {
    return StandardLayout(
      appBar: true,
      bodyWidget: Text('Under Development'),
      appBarTitle: Text('Message', style: AppTheme.headingBold,),
      backButtonAppBar: true,
      bottomBar: true,
    );
  }
}