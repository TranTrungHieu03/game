import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:game_demo/bloc/game/game_cubit.dart';
import 'package:game_demo/component/hidden_coin.dart';
import 'package:game_demo/component/pipe.dart';
import 'package:game_demo/component/pipe_pair.dart';
import 'package:game_demo/flappy_dash_game.dart';

class Dash extends PositionComponent
    with
        CollisionCallbacks,
        HasGameRef<FlappyDashGame>,
        FlameBlocReader<GameCubit, GameState> {
  Dash()
    : super(
        position: Vector2(0, 0),
        size: Vector2.all(80.0),
        anchor: Anchor.center,
        priority: 10,
      );

  late Sprite _dashSprite;
  final Vector2 _gravity = Vector2(0, 1400.0);
  Vector2 _velocity = Vector2(0, 0);
  final Vector2 jumpForce = Vector2(0, -500);

  @override
  void update(double dt) {
    super.update(dt);
    if (!bloc.state.currentPlayingState.isPlaying) {
      return;
    }
    _velocity += _gravity * dt;
    position += _velocity * dt;
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    _dashSprite = await Sprite.load('dash.png');
    final radius = size.x / 2;
    final center = size / 2;
    add(
      CircleHitbox(
        radius: radius * 0.8,
        position: center * 1.1,
        anchor: Anchor.center,
      ),
    );
  }

  void jump() {
    if (!bloc.state.currentPlayingState.isPlaying) {
      return;
    }
    _velocity = jumpForce;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    _dashSprite.render(canvas, size: size);
    // canvas.drawCircle(Offset.zero, 20, BasicPalette.blue.paint());
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (!bloc.state.currentPlayingState.isPlaying) {
      return;
    }
    if (other is HiddenCoin) {
      bloc.increaseScore();
      other.removeFromParent();
    } else if (other is Pipe) {
      bloc.gameOver();
    }
  }
}
