import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_demo/bloc/game/game_cubit.dart';

class GameOverWidget extends StatelessWidget {
  const GameOverWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: Container(
            color: Colors.black54,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'GAME OVER',
                    style: TextStyle(
                      color: Color(0xFFFFCA00),
                      letterSpacing: 4,
                      fontWeight: FontWeight.bold,
                      fontSize: 48,
                    ),
                  ),

                  const SizedBox(height: 6),
                  Text(
                    'Score: ${state.currentScore}',
                    style: TextStyle(
                      color: Colors.white,
                      letterSpacing: 4,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      context.read<GameCubit>().restartGame();
                    },
                    child: Text('PLAY AGAIN'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
