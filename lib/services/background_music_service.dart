import 'package:audioplayers/audioplayers.dart';

class BackgroundMusicService {
  static final AudioPlayer _player = AudioPlayer()
    ..setReleaseMode(ReleaseMode.loop);

  static Future<void> play() async {
    await _player
        .play(AssetSource('images/audio/background/cute_cat_theme.mp3'));
  }

  static Future<void> stop() async {
    await _player.stop();
  }

  static Future<void> setVolume(double volume) async {
    await _player.setVolume(0.7); // 0.0 to 1.0
  }
}
