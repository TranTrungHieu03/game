import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame_bloc/flame_bloc.dart';
import 'package:game_demo/bloc/game/game_cubit.dart';
import 'package:game_demo/component/dash.dart';
import 'package:game_demo/component/dash_parallex_background.dart';
import 'package:game_demo/component/pipe_pair.dart';
import 'package:game_demo/flappy_dash_game.dart';

class FlappyDashRootComponent extends Component
    with
        HasGameReference<FlappyDashGame>,
        FlameBlocReader<GameCubit, GameState> {
  late Dash _dash;
  late PipePair _lastPipe;
  static const _pipeDistance = 400.0;

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(DashParallaxBackground());
    add(_dash = Dash());
    generatePipes(fromX: 350);
    // game.camera.viewfinder.add(
    //   _scoreText = TextComponent(position: Vector2(0, -(game.size.y / 2))),
    // );
  }

  void generatePipes({int count = 5, double fromX = 0.0}) {
    for (int i = 0; i < count; i++) {
      const area = 600;
      final y = (Random().nextDouble() * area) - (area / 2);
      add(
        _lastPipe = PipePair(position: Vector2(fromX + (i * _pipeDistance), y)),
      );
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    _checkToStart();
    _dash.jump();
  }

  void onSpaceDown() {
    _checkToStart();
    _dash.jump();
  }

  @override
  void update(double dt) {
    super.update(dt);
    // _scoreText.text = bloc.state.currentScore.toString();
    if (_dash.x >= _lastPipe.x) {
      generatePipes(fromX: _pipeDistance);
      _removePipes();
    }
    // game.camera.viewfinder.zoom = 0.05;
  }

  void _removePipes() {
    final pipes = children.whereType<PipePair>();
    final shouldBeRemoved = max(pipes.length - 5, 0);
    pipes.take(shouldBeRemoved).forEach((pipe) {
      pipe.removeFromParent();
    });
  }

  void _checkToStart() {
    if (bloc.state.currentPlayingState == PlayingState.idle) {
      bloc.startPlaying();
    }
  }
}
