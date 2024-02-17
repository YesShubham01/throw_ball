import 'package:flame/components.dart';
import 'package:throw_ball/game.dart';

class Pokeball extends SpriteComponent with HasGameRef<ThrowBall> {
  Pokeball()
      : super(
          size: Vector2(100, 150),
          anchor: Anchor.center,
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    sprite = await gameRef.loadSprite('pokeball.png');

    position = gameRef.size / 2;
  }

  void move(Vector2 delta) {
    position.add(delta);
  }
}
