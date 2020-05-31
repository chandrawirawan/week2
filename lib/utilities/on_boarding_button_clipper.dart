import 'package:flutter/material.dart';

class OnBoardingButtonClipper extends CustomClipper<Path> {

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.height / 10, size.height * 0.40);
    path.quadraticBezierTo(0, size.height * 0.40 + size.height / 10, size.height / 10, size.height * 0.40 + ((size.height / 10) * 2));
    path.lineTo(size.height / 10, size.height * 0.6);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}