import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_demo/bloc/game/game_cubit.dart';
import 'package:game_demo/flappy_dash_game.dart';
import 'package:game_demo/widgets/game_over_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late FlappyDashGame _flappyDashGame;
  late GameCubit gameCubit;
  late PlayingState? _latestState;

  @override
  void initState() {
    gameCubit = BlocProvider.of<GameCubit>(context);
    _flappyDashGame = FlappyDashGame(gameCubit);
    super.initState(); //
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GameCubit, GameState>(
      listener: (context, state) {
        if (state.currentPlayingState.isIdle &&
            (_latestState?.isGameOver ?? false)) {
          setState(() {
            _flappyDashGame = FlappyDashGame(gameCubit);
          });
        }
        _latestState = state.currentPlayingState;
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              GameWidget(
                game: _flappyDashGame,
                backgroundBuilder: (context) {
                  return Container(color: Colors.white);
                },
              ),
              if (state.currentPlayingState.isGameOver) GameOverWidget(),
              if (state.currentPlayingState.isIdle)
                Align(
                  alignment: Alignment(0, 0.2),
                  child: IgnorePointer(
                    child:
                        Text(
                              'TAP TO PLAY',
                              style: TextStyle(
                                color: Color(0xFF2387FC),
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                                letterSpacing: 4,
                              ),
                            )
                            .animate(
                              onPlay: (controller) =>
                                  controller.repeat(reverse: true),
                            )
                            .scale(
                              begin: Offset(1.0, 1.0),
                              end: Offset(1.2, 1.2),
                              duration: Duration(milliseconds: 500),
                            ),
                  ),
                ),
              if (!state.currentPlayingState.isGameOver)
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Text(
                      '0',
                      style: TextStyle(color: Colors.black, fontSize: 38),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
