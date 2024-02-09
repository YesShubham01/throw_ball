import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:throw_ball/Components/ball.dart';

class ThrowBall extends FlameGame with PanDetector, KeyboardEvents {
  late Ball ball;

  TextComponent titleText = TextComponent(
    text: 'Throw Ball!',
  );
  TextComponent velocityText = TextComponent(
    text: 'Velocity: 0',
  );
  TextComponent t1 = TextComponent(
    text: 'Velocity: 0',
  );
  TextComponent t2 = TextComponent(
    text: 'Velocity: 0',
  );
  TextComponent t3 = TextComponent(
    text: 'Velocity: 0',
  );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    ball = Ball();
    add(
      ball
        ..position = Vector2((size.x / 2) + 50, (size.y / 2) + 100)
        ..anchor = Anchor.center,
    );

    add(titleText..position = Vector2(size.x / 2, 0));
    add(velocityText..position = Vector2(size.x / 2, 40));
    // add target and a target spawner.
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    double velocity = info.delta.global.length;
    Vector2 direction = info.delta.global;
    ball.move(info.delta.global);
    velocityText.text = 'Velocity: $velocity'; // this gives velocity
    t1.text = "value : $direction"; // this gives coordinates
    ball.throwBall(velocity, direction);
  }

  void resetGame() {
    ball.position = Vector2((size.x / 2) + 50, (size.y / 2) + 100);
    ball.radius = 50;
    ball.isThrowed = false;
    ball.totalTime = 0;
    ball.mass = 1;
    ball.timeY = 0;
    ball.heightY = 0;
    ball.gravity = 10;
    // Reset other game variables as needed
  }

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isR = keysPressed.contains(LogicalKeyboardKey.keyR);

    if (isR) {
      resetGame();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }
}
