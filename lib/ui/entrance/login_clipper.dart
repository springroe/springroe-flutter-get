import 'package:flutter/material.dart';

class LoginClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height - 40);
    var firstControlPoint = Offset(size.width / 4, size.height);
    var firstendPoint = Offset(size.width / 2.25, size.height - 30);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstendPoint.dx, firstendPoint.dy);
    var secondConttorPoint = Offset(size.width / 4 * 3, size.height - 90);
    var secondendPoint = Offset(size.width, size.height - 40);
    path.quadraticBezierTo(secondConttorPoint.dx, secondConttorPoint.dy,
        secondendPoint.dx, secondendPoint.dy);
    path.lineTo(size.width, size.height - 40);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
