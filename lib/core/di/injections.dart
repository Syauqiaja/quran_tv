
import 'package:get_it/get_it.dart';
import 'package:quran_tv/data/repositories/reciter_repository_impl.dart';
import 'package:quran_tv/data/sources/local/local_service.dart';
import 'package:quran_tv/domain/repositories/reciter_repository.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupInjections() async {
  getIt.registerLazySingleton<LocalService>(() => LocalService());
  getIt.registerSingleton<ReciterRepository>(ReciterRepositoryImpl(localService: getIt<LocalService>()));
}