import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:throw_ball/game.dart';

class Target extends PositionComponent with HasGameRef<ThrowBall> {
  Target()
      : super(
          size: Vector2(100, 100), // a vector2 is like a tuple of python.
          anchor: Anchor.center,
        );

  static final _paint = Paint()..color = Colors.yellow;

  @override
  void render(Canvas canvas) {
    double centerY = height / 2;
    double centerX = width / 2;
    double radius = 60;

    // Now, draw the circle:
    canvas.drawCircle(Offset(centerX, centerY), radius, _paint);
  }
}
