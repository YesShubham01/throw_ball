import 'dart:async';
import 'package:flame/components.dart';
import 'package:throw_ball/game.dart';

class Background extends SpriteComponent with HasGameRef<ThrowBall> {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // Load the image for the Angry Bird sprite
    sprite = await Sprite.load('background.png');

    size = Vector2(game.width, game.height);
    anchor = Anchor.center;
    position = gameRef.size / 2;
  }
}
