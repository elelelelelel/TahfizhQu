

import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';

class SoundPlayer {
  FlutterSoundPlayer? _audioPlayer;

  bool get isPlaying => _audioPlayer!.isPlaying;

  Future init()async{
    _audioPlayer = FlutterSoundPlayer();

    await _audioPlayer!.openPlayer();
  }

  void dispose(){
    _audioPlayer!.closePlayer();
    _audioPlayer = null;
  }

  Future _play(VoidCallback whenFinished) async {
    await _audioPlayer!
        .startPlayer(fromURI: 'audio', whenFinished: whenFinished);}

    Future _stop() async {
      await _audioPlayer!.stopPlayer();
    }

    Future tooglePlaying({required VoidCallback whenFinished}) async {
      if (_audioPlayer!.isStopped) {
        await _play(whenFinished);
      } else {
        await _stop();
      }
    }
  
}
