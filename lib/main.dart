import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_demo/audio_helper.dart';
import 'package:game_demo/bloc/game/game_cubit.dart';
import 'package:game_demo/main_page.dart';
import 'package:game_demo/service_locator.dart';

void main() async {
  await setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => GameCubit(getIt.get<AudioHelper>()),
      child: MaterialApp(
        title: 'Flappy Dash',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          fontFamily: "Chewy",
        ),
        home: MainPage(),
      ),
    );
  }
}
