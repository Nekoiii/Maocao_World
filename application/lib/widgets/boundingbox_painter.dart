import 'package:flutter/material.dart';

class WireBoxPainter extends CustomPainter {
  final List<Rect> boxes;

  WireBoxPainter(this.boxes);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Colors.red;
    paint.strokeWidth = 3.0;
    paint.style = PaintingStyle.stroke;

    for (var box in boxes) {
      canvas.drawRect(box, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
