import 'package:quran_tv/data/models/reciter_model.dart';
import 'package:quran_tv/data/sources/result.dart';

abstract class ReciterRepository {
  Future<Result<List<ReciterModel>>> getAllReciters({String? query});
}