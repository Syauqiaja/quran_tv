import 'package:quran_tv/data/models/quran_line_model.dart';
import 'package:quran_tv/data/models/quran_model.dart';
import 'package:quran_tv/data/sources/result.dart';

abstract class QuranRepository {
  Future<Result<List<QuranModel>>> getQuranList();
  Future<Result<QuranModel>> getQuranModel(int surah);
  Future<Result<List<QuranLineModel>>> getQuranLineModelOf(int surah);
}