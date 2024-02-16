import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:throw_ball/Components/ball.dart';
import 'package:throw_ball/Components/bg.dart';
import 'package:throw_ball/Components/config.dart';

class ThrowBall extends FlameGame with PanDetector, KeyboardEvents {
  ThrowBall()
      : super(
          camera: CameraComponent.withFixedResolution(
            width: gameWidth,
            height: gameHeight,
          ),
        );

  double get width => size.x;
  double get height => size.y;

  late Ball ball;
  late Background _bg;

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
    camera.viewfinder.anchor = Anchor.topLeft;

    _bg = Background();
    world.add(_bg);

    ball = Ball();
    world.add(
      ball
        ..position = Vector2((width / 2), (height / 2))
        ..anchor = Anchor.topLeft,
    );

    world.add(titleText..position = Vector2(width / 2, 0));
    world.add(velocityText..position = Vector2(width / 2, 40));
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
    ball.radius = 100;
    ball.isThrowed = false;
    ball.totalTime = 0;
    ball.mass = 1;
    ball.timeY = 0;
    ball.heightY = 0;
    ball.gravity = 10;
    ball.stamp.removeFromParent();
    ball.isStampAdded = false;
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
