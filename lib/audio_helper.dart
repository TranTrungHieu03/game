import 'package:flutter_soloud/flutter_soloud.dart';

class AudioHelper {
  late SoLoud _soLoud;
  late AudioSource _backgroundSource;
  late SoundHandle? _playingBackgroundSource;

  late AudioSource _scoreSource;

  Future<void> initialize() async {
    _soLoud = SoLoud.instance;
    if (_soLoud.isInitialized) {
      return;
    }
    await _soLoud.init();
    _backgroundSource = await _soLoud.loadAsset('assets/audio/background.mp3');
    _scoreSource = await _soLoud.loadAsset('assets/audio/score.mp3');
  }

  void playBackgroundAudio() async {
    _playingBackgroundSource = await _soLoud.play(_backgroundSource);
    _soLoud.setProtectVoice(_playingBackgroundSource!, true);
  }

  void stopBackgroundAudio() async {
    if (_playingBackgroundSource == null) {
      return;
    }
    _soLoud.fadeVolume(
      _playingBackgroundSource!,
      0.0,
      Duration(microseconds: 500),
    );
  }

  void playScoreAudio() async {
    _playingBackgroundSource = await _soLoud.play(_scoreSource);
  }
}
