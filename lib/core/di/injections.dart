import 'package:audio_session/audio_session.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:get_it/get_it.dart';
import 'package:quran_tv/core/services/google_storage_service.dart';
import 'package:quran_tv/data/repositories/quran_repository_impl.dart';
import 'package:quran_tv/data/repositories/reciter_repository_impl.dart';
import 'package:quran_tv/data/sources/local/local_service.dart';
import 'package:quran_tv/domain/repositories/quran_repository.dart';
import 'package:quran_tv/domain/repositories/reciter_repository.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupInjections() async {
  getIt.registerLazySingleton<LocalService>(() => LocalService());
  getIt.registerSingleton<ReciterRepository>(
    ReciterRepositoryImpl(localService: getIt<LocalService>()),
  );
  getIt.registerSingleton<QuranRepository>(
    QuranRepositoryImpl(localService: getIt<LocalService>()),
  );
  getIt.registerSingletonAsync<FlutterSoundPlayer>(()async{
    final player = await FlutterSoundPlayer().openPlayer();

      final session = await AudioSession.instance;
      await session.configure(
        AudioSessionConfiguration(
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
        ),
      );

      session.setActive(true);

      return player!;
  });
  getIt.registerSingleton<GoogleStorageService>(GoogleStorageService());
}
