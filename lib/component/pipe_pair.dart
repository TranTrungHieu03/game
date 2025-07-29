import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:game_demo/bloc/game/game_cubit.dart';
import 'package:game_demo/component/hidden_coin.dart';
import 'package:game_demo/component/pipe.dart';

class PipePair extends PositionComponent
    with FlameBlocReader<GameCubit, GameState> {
  PipePair({required super.position, this.gap = 200.0, this.speed = 200})
    : super(priority: 2, anchor: Anchor.center);

  final double gap;
  final double speed;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    addAll([
      Pipe(isFlipped: false, position: Vector2(0, gap / 2)),
      Pipe(isFlipped: true, position: Vector2(0, -gap / 2)),
      HiddenCoin(position: Vector2(10, 0)),
    ]);
  }

  @override
  void update(double dt) {
    switch (bloc.state.currentPlayingState) {
      case PlayingState.idle:
      case PlayingState.paused:
      case PlayingState.gameOver:
        break;
      case PlayingState.playing:
        position.x -= speed * dt;
        break;
    }

    super.update(dt);
  }
}
