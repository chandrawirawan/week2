import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movpedia/features/home/views/home_screen.dart';
import 'package:movpedia/theme.dart';
import 'package:movpedia/utilities/on_boarding_image_clipper.dart';
import 'package:movpedia/features/auth/bloc/auth_bloc.dart';
import 'package:movpedia/features/login/bloc/bloc.dart';

enum CredentialsMode { LOGIN, SIGNUP }

class LoginScreen extends StatelessWidget {
  static const String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (c, state) {
        if (state.isSuccess) {
          BlocProvider.of<AuthBloc>(context).add(LoggedIn());
          Navigator.of(context).pushNamed(HomeScreen.routeName);
        }
      },
      child: Splash(),
    );
  }
}

class GoogleSignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LoginBloc _loginBloc = BlocProvider.of<LoginBloc>(context);
    return RaisedButton(
      elevation: 2,
      color: Colors.white,
      onPressed: () {
        _loginBloc.add(LoginWithGooglePressed());
      },
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(50),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Image(
              image: AssetImage('assets/graphics/google_logo.png'),
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Login melalui Google',
                style: AppTheme.regularText,
              ),
            )
          ],
        ),
      ),
    );
  }
}

const List<ImageAssetWithDimension> images = [
  ImageAssetWithDimension(
    asset: 'assets/graphics/man-workout.jpeg',
    width: 850,
    leftOfsset: -300,
    topOffset: -50,
  ),
  ImageAssetWithDimension(
    asset: 'assets/graphics/woman-workout-a.jpg',
    width: 900,
    leftOfsset: -350,
    topOffset: 0,
  ),
  ImageAssetWithDimension(
    asset: 'assets/graphics/woman-workout-c.jpg',
    width: 1000,
    leftOfsset: -450,
    topOffset: 0,
  ),
  ImageAssetWithDimension(
    asset: 'assets/graphics/woman-workout-d.jpeg',
    width: 600,
    leftOfsset: -50,
    topOffset: 0,
  ),
  ImageAssetWithDimension(
    asset: 'assets/graphics/woman-workout.jpg',
    width: 800,
    leftOfsset: -250,
    topOffset: 0,
  ),
];

final int random = 0 + Random().nextInt(images.length - 0);

class Splash extends StatelessWidget {
  static const routeName = '/welcome-screen';
  const Splash({Key key}) : super(key: key);

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
              height: 0.80 * MediaQuery.of(context).size.height,
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
                      'Login!',
                      style: AppTheme.decorativeHeadingBoldBright,
                    ),
                  ),
                  Positioned(
                    top: 120,
                    right: 20,
                    child: Text(
                      'Let\'s go',
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
                height: MediaQuery.of(context).size.height * 0.20,
                width: MediaQuery.of(context).size.width,
              ),
              Positioned(
                top: -30,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RichText(
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
                      GoogleSignInButton(),
                    ],
                  ),
                ),
              )
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
