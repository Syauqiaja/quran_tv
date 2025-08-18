import 'package:quran_tv/data/models/quran_line_model.dart';
import 'package:quran_tv/data/models/quran_model.dart';
import 'package:quran_tv/data/sources/local/local_service.dart';
import 'package:quran_tv/data/sources/result.dart';
import 'package:quran_tv/domain/repositories/quran_repository.dart';

final class QuranRepositoryImpl extends QuranRepository {
  final LocalService localService;

  QuranRepositoryImpl({required this.localService});
  @override
  Future<Result<List<QuranLineModel>>> getQuranLineModelOf(int surah) {
    print('QuranRepositoryImpl : getQuranLineModelOf $surah');
    return localService.getQuranLines(surah);
  }

  @override
  Future<Result<List<QuranModel>>> getQuranList() {
    print('QuranRepositoryImpl : getQuranList');
    return localService.getQurans();
  }
  
  @override
  Future<Result<QuranModel>> getQuranModel(int surah) {
    print('QuranRepositoryImpl : getQuranModel $surah');
    return localService.getQuran(surah);
  }
}