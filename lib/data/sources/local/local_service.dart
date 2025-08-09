import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:quran_tv/data/models/reciter_model.dart';
import 'package:quran_tv/data/sources/result.dart';

class LocalService {
  Future<Result<List<ReciterModel>>> getAllReciters({String? query}) async {
    try {
      String data = await rootBundle.loadString("assets/raw/reciters.json");
      List<Map<String, dynamic>> result = jsonDecode(data);
      return Result.success(result.map((e) => ReciterModel.fromJson(e)).toList());
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      return Result.error(e as Exception);
    } 
  }
}