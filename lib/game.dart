import 'dart:async';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:throw_ball/Cat%20Component/cat.dart';
import 'package:throw_ball/Components/ball.dart';
import 'package:throw_ball/Components/bg.dart';
import 'package:throw_ball/Components/config.dart';
import 'package:throw_ball/Components/ball_sprite.dart';
import 'package:throw_ball/Components/switch.dart';

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
  late BallSprite pokeball;
  late SwitchOn switchOn;

  late Background _bg;
  late Cat cat;

  TextComponent titleText = TextComponent(
    text: 'Throw Ball!',
  );
  TextComponent velocityText = TextComponent(
    text: 'Velocity: 0',
  );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    camera.viewfinder.anchor = Anchor.topLeft;

    _bg = Background();
    world.add(_bg);

    switchOn = SwitchOn();
    world.add(switchOn);

    cat = Cat();
    world.add(cat);

    // ball = Ball();
    // world.add(
    //   ball
    //     ..position = Vector2((width / 2), (height / 2))
    //     ..anchor = Anchor.topLeft,
    // );

    pokeball = BallSprite();
    world.add(pokeball);

    // world.add(Stamp()..position = Vector2(2020, size.y / 2));

    world.add(titleText..position = Vector2(width / 2, 0));
    world.add(velocityText..position = Vector2(width / 2, 40));
    // add target and a target spawner.
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    Vector2 direction = info.delta.global;
    pokeball.move(direction);
    // ball.move(info.delta.global);
    // ball.throwBall(velocity, direction);
    pokeball.throwBall(direction);
  }

  bool checkCollision(Vector2 hitPosition) {
    Vector2 switchPosition = switchOn.position;

    double distance = hitPosition.distanceTo(switchPosition);
    print(distance);

    velocityText.text = "$distance";
    return distance <= 100;
  }

  void resetGame() {
    // ball.position = Vector2((size.x / 2) + 50, (size.y / 2) + 100);
    // ball.radius = 100;
    // ball.isThrowed = false;
    // ball.totalTime = 0;
    // ball.mass = 1;
    // ball.timeY = 0;
    // ball.heightY = 0;
    // ball.gravity = 10;
    // if (ball.isStampAdded) {
    //   ball.stamp.removeFromParent();
    // }
    // ball.isStampAdded = false;
    // Reset other game variables as needed

    pokeball.position = Vector2((size.x / 2) + 50, (size.y / 2) + 100);
    pokeball.isThrowed = false;
    pokeball.totalTime = 0;
    pokeball.mass = 1;
    pokeball.timeY = 0;
    pokeball.heightY = 0;
    pokeball.gravity = 10;
    if (pokeball.isStampAdded) {
      pokeball.stamp.removeFromParent();
    }
    pokeball.isStampAdded = false;
    pokeball.size = Vector2(250, 250);
    pokeball.diameter = 250;
    pokeball.timeToBounce = false;
    pokeball.bounceTime = 0;
    pokeball.countBounceTime = false;
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
