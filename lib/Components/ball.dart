import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:throw_ball/Components/stamp.dart';
import 'package:throw_ball/game.dart';

class Ball extends PositionComponent with HasGameRef<ThrowBall> {
  Ball()
      : super(
          size: Vector2(100, 100), // a vector2 is like a tuple of python.
          anchor: Anchor.center,
        );
  static final _paint = Paint()..color = Colors.white;

  final double bias = 10.0;
  bool isThrowed = false;
  late double velocityX;
  late double velocityY;
  double radius = 100.0; //! radius should be calculated according to z axis.
  double gravity = 10.0;
  double mass = 1;
  double timeY = 0;
  double heightY = 0;
  double totalTime = 0;
  @override
  void render(Canvas canvas) {
    double centerY = height / 2;
    double centerX = width / 2;

    // Now, draw the circle:
    canvas.drawCircle(Offset(centerX, centerY), radius, _paint);
  }

  void move(Vector2 pos) {
    position.add(pos);
  }

  void throwBall(double velocity, Vector2 direction) {
    isThrowed = true;
    velocityX = direction.x * bias;
    velocityY = direction.y * bias;

    timeY = (velocityY / bias) / gravity;
    timeY = timeY.abs();
    heightY = ((velocityY / bias) * (velocityY / bias)) / (2 * gravity);
  }

  bool isStampAdded = false;
  late Stamp stamp;
  @override
  void update(double dt) {
    super.update(dt);
    totalTime += dt;

    if (isThrowed) {
      double positionY = ((velocityY / bias) * totalTime) +
          (gravity * totalTime * totalTime / 2);

      position.y += positionY;
      // position.y += dt * velocityY;
      position.x += dt * velocityX;
      if (radius < 60) {
        if (position.x > 1350) {
          if (position.y > ((game.height * (6 / 10)) - 60)) {
            // stop ball movement
            isThrowed = false;
          }
        } else {
          if (position.y > (game.height * (4 / 6))) {
            // stop ball movement
            isThrowed = false;
          }
        }

        checkStamp(position);
        increaseGravity();
      } else {
        setRadius(radius - 0.5);
      }
    }
    if (position.x < -width ||
        position.y > game.size.y ||
        position.x > game.size.x) {
      game.resetGame();
    }
  }

  void setRadius(double newRadius) {
    if (radius < 20) {
      return;
    } else {
      radius = newRadius;
    }
  }

  void increaseGravity() {
    if (gravity == 10) {
      gravity = 15;
    }
  }

  void checkStamp(Vector2 pos) {
    if (!isStampAdded) {
      stamp = Stamp()..position = pos;
      game.world.add(stamp);
      isStampAdded = true;
    } else {
      return;
    }
  }
}

/*  z axis:
    y-axis
      ^     .
      |    /
      |   /
      |  /
      | /
      |/
      |________________> x-axis
*/
