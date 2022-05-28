import 'dart:math';

import 'package:flutter/material.dart';

class CircleBlurPainter extends CustomPainter {
  CircleBlurPainter(
      {required this.circleWidth,
      required this.blurSigma,
      required this.color});

  double circleWidth;
  double blurSigma;
  Color color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint line = Paint()
      ..color = color
      // ..strokeCap = StrokeCap.round
      // ..style = PaintingStyle.stroke
      ..strokeWidth = circleWidth
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, blurSigma);
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, line);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
