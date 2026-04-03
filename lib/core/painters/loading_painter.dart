import 'package:flutter/widgets.dart';

class MiniLoadingPainter extends CustomPainter {
  final Color color;

  MiniLoadingPainter({
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint backgroundPaint = Paint()
      ..color = color.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    final Paint foregroundPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3;

    final Offset center = size.center(Offset.zero);
    final double radius = (size.shortestSide - 3) / 2;

    canvas.drawCircle(center, radius, backgroundPaint);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.141592653589793 / 2,
      3.141592653589793 * 1.5,
      false,
      foregroundPaint,
    );
  }

  @override
  bool shouldRepaint(covariant MiniLoadingPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

