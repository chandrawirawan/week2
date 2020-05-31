import 'dart:math';

import 'package:flutter/material.dart';
import 'package:movpedia/features/login/view/login_screen.dart';
import 'package:movpedia/theme.dart';
import 'package:movpedia/ui/on_boarding_button.dart';
import 'package:movpedia/utilities/enter_exit_route.dart';
import 'package:movpedia/utilities/on_boarding_image_clipper.dart';

const List<ImageAssetWithDimension> images = [
  ImageAssetWithDimension(
    asset: 'assets/graphics/man-workout.jpeg',
    width: 850,
    leftOfsset: -400,
    topOffset: -50,
  ),
  ImageAssetWithDimension(
    asset: 'assets/graphics/woman-workout-a.jpg',
    width: 900,
    leftOfsset: -450,
    topOffset: 0,
  ),
  ImageAssetWithDimension(
    asset: 'assets/graphics/woman-workout-c.jpg',
    width: 1000,
    leftOfsset: -550,
    topOffset: 0,
  ),
  ImageAssetWithDimension(
    asset: 'assets/graphics/woman-workout-d.jpeg',
    width: 600,
    leftOfsset: -150,
    topOffset: 0,
  ),
  ImageAssetWithDimension(
    asset: 'assets/graphics/woman-workout.jpg',
    width: 800,
    leftOfsset: -350,
    topOffset: 0,
  ),
];

final int random = 0 + Random().nextInt(images.length - 0);

class WelcomeScreen extends StatelessWidget {
  static const routeName = '/welcome-screen';
  const WelcomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          ClipPath(
            clipper: OnBoardingImageClipper(),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.colorPrimary.withOpacity(0.8),
                    Colors.green.withOpacity(0.4),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              width: double.infinity,
              height: 0.85 * MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Positioned(
                    left: images[random].leftOfsset,
                    top: images[random].topOffset,
                    child: Image.asset(
                      images[random].asset,
                      fit: BoxFit.cover,
                      repeat: ImageRepeat.repeat,
                      width: images[random].width,
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: double.infinity,
                      height: 540,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppTheme.colorPrimary.withOpacity(0.8),
                            Colors.green.withOpacity(0.001),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 80,
                    right: 20,
                    child: Text(
                      'Hi!',
                      style: AppTheme.decorativeHeadingBoldBright,
                    ),
                  ),
                  Positioned(
                    top: 120,
                    right: 20,
                    child: Text(
                      'How are you?',
                      style: AppTheme.decorativeHeadingBoldBright,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Stack(
            overflow: Overflow.visible,
            children: <Widget>[
              Container(
                height: MediaQuery.of(context).size.height * 0.15,
                width: MediaQuery.of(context).size.width,
              ),
              Positioned(
                left: 30,
                top: -10,
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'Mov',
                        style: AppTheme.decorativeHeadingBold,
                      ),
                      TextSpan(
                        text: 'Pedia',
                        style: AppTheme.decorativeHeading,
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: -50,
                right: 0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                      EnterExitRoute(exitPage: this, enterPage: LoginScreen()));
                  },
                  child: OnBoardingButton(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ImageAssetWithDimension {
  final String asset;
  final double width;
  final double leftOfsset;
  final double topOffset;

  const ImageAssetWithDimension({
    @required this.asset,
    @required this.width,
    @required this.leftOfsset,
    @required this.topOffset,
  });
}
