import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flaguru/models/SettingsHandler.dart';
import 'package:flutter/material.dart';

class GlobalAudioPlayer with WidgetsBindingObserver {
  AudioCache _cache = AudioCache(prefix: 'audio/');
  AudioPlayer _musicPlayer;
  AudioPlayer _soundPlayer;

  SettingsHandler _settings;

  GlobalAudioPlayer(this._settings) {
    WidgetsBinding.instance.addObserver(this);
  }

//  final _musicNames = ['elevate.mp3'];
//  final _soundNames = ['right.m4a', 'wrong.mp3', 'score.mp3'];
//
//  Future loadAllAudio() async {
//    await _cache.loadAll([..._musicNames, ..._soundNames]);
//  }

  Future playMusic() async {
    if (!_settings.isMusicEnabled) return;
    if (_musicPlayer == null)
      _musicPlayer = await _cache.loop('elevate.mp3')
        ..setVolume(0.2);
    else
      _musicPlayer.resume();
  }

  Future playSoundRight() async {
    if (!_settings.isSoundEnabled) return;
    _soundPlayer = await _cache.play('right.m4a')
      ..setVolume(0.5);
  }

  Future playSoundWrong() async {
    if (!_settings.isSoundEnabled) return;
    _soundPlayer = await _cache.play('wrong.mp3');
  }

  Future playSoundScore() async {
    if (!_settings.isSoundEnabled) return;
    _soundPlayer = await _cache.play('score.mp3')
      ..setVolume(0.8);
  }

  Future playSoundResult() async {
    if (!_settings.isSoundEnabled) return;
    _soundPlayer = await _cache.play('score.mp3')
      ..setVolume(0.5);
  }

  void pauseMusic() {
    _musicPlayer?.pause();
  }

  void pauseSound() {
    _soundPlayer?.pause();
  }

  void stopAll() {
    _soundPlayer?.stop();
    _musicPlayer?.stop();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      pauseMusic();
      pauseSound();
    } else if (_settings.isMusicEnabled && state == AppLifecycleState.resumed) {
      _musicPlayer?.resume();
    } else if (_settings.isMusicEnabled &&
        _soundPlayer.state == AudioPlayerState.PAUSED &&
        state == AppLifecycleState.resumed) {
      _soundPlayer?.resume();
    }

    super.didChangeAppLifecycleState(state);
  }
}

GlobalAudioPlayer audioPlayer;
