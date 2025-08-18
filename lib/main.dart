import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:quran_tv/app.dart';
import 'package:quran_tv/core/di/injections.dart';


// App entrance

FlutterSoundPlayer? flutterSoundPlayer = FlutterSoundPlayer()..openPlayer();
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupInjections();
  initAudio();
  runApp(const MyApp());
}

initAudio() async {
  flutterSoundPlayer = await FlutterSoundPlayer().openPlayer();

  final session = await AudioSession.instance;
  await session.configure(AudioSessionConfiguration(
    avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
    avAudioSessionCategoryOptions:
        AVAudioSessionCategoryOptions.allowBluetooth |
            AVAudioSessionCategoryOptions.defaultToSpeaker,
    avAudioSessionMode: AVAudioSessionMode.spokenAudio,
    avAudioSessionRouteSharingPolicy:
        AVAudioSessionRouteSharingPolicy.defaultPolicy,
    avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
    androidAudioAttributes: const AndroidAudioAttributes(
      contentType: AndroidAudioContentType.speech,
      flags: AndroidAudioFlags.none,
      usage: AndroidAudioUsage.voiceCommunication,
    ),
    androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
    androidWillPauseWhenDucked: true,
  ));

  session.setActive(true);

  print("Audio finished loading on main");
}
