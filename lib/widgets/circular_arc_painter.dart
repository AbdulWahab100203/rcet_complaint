import 'package:flutter/material.dart';
import 'dart:math' as math;

class CircularArcPainter extends CustomPainter {
  final List<Color> colors;
  final double strokeWidth;

  CircularArcPainter({
    required this.colors,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final totalAngle = 210 * (math.pi / 180);
    final startAngle = -195 * (math.pi / 180);

    final segmentCount = colors.length;
    final segmentAngle = totalAngle / segmentCount;

    for (var i = 0; i < segmentCount; i++) {
      final paint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      final segmentStart = startAngle + (i * segmentAngle);

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        segmentStart,
        segmentAngle - (2 * math.pi / 180),
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
