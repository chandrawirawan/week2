import 'package:flutter/material.dart';
import 'package:movpedia/theme.dart';
import 'package:movpedia/ui/layout/standard_layout.dart';

class ProfileScreen extends StatelessWidget {
  static String routeName = './profile';
  const ProfileScreen();

  @override
  Widget build(BuildContext context) {
    return StandardLayout(
      appBar: true,
      bodyWidget: Text('Under Development Profile'),
      appBarTitle: Text('Profile', style: AppTheme.headingBold,),
      backButtonAppBar: true,
      bottomBar: true,
    );
  }
}