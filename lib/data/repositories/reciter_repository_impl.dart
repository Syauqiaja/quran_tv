import 'package:quran_tv/data/models/reciter_model.dart';
import 'package:quran_tv/data/sources/local/local_service.dart';
import 'package:quran_tv/data/sources/result.dart';
import 'package:quran_tv/domain/repositories/reciter_repository.dart';

final class ReciterRepositoryImpl extends ReciterRepository{

  final LocalService localService;

  ReciterRepositoryImpl({required this.localService});
  
  @override
  Future<Result<List<ReciterModel>>> getAllReciters({String? query}) {
    return localService.getAllReciters(query: query);
  }
}