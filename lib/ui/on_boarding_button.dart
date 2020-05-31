import 'package:flutter/material.dart';
import 'package:movpedia/theme.dart';
import 'package:movpedia/utilities/on_boarding_button_clipper.dart';

class OnBoardingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: OnBoardingButtonClipper(),
          child: Container(
        width: 135,
        height: 135,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppTheme.colorPrimary,
              AppTheme.colorPrimary.withBlue(300).withRed(200),
            ],
            stops: [
              0.7,
              1.0,
            ],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 45),
            child: Icon(
              Icons.arrow_forward_ios,
              color: Colors.white
            ),
          ),
        ),
      ),
    );
  }
}
