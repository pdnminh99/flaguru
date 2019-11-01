import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

class GlobalAudioPlayer {
  AudioCache _cache = AudioCache(prefix: 'audio/');
  AudioPlayer _player;



  final _fileNames = [
    'perception.mp3',
  ];

  double get musicVolume => 0.2;

  double get soundVolume => 1;

  Future loadAllAudio() async {
    await _cache.loadAll(_fileNames);
  }

  Future playMusic() async {
    _player = await _cache.loop('perception.mp3')
      ..setVolume(musicVolume);
  }

  Future playSoundRight() {}

  Future playSoundWrong() {}

  Future stop() async {
    await _player.stop();
  }
}

GlobalAudioPlayer audioPlayer = GlobalAudioPlayer();
