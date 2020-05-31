import 'package:flutter/material.dart';
import 'package:movpedia/theme.dart';
import 'package:movpedia/ui/layout/standard_layout.dart';

class ClassesView extends StatelessWidget {
  static String routeName = './classes';
  const ClassesView();

  @override
  Widget build(BuildContext context) {
    return StandardLayout(
      appBar: true,
      bodyWidget: Text('Under Development'),
      appBarTitle: Text('Class', style: AppTheme.headingBold,),
      backButtonAppBar: true,
      bottomBar: true,
    );
  }
}