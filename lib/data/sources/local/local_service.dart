import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:quran_tv/data/models/reciter_model.dart';
import 'package:quran_tv/data/sources/result.dart';

class LocalService {
  Future<Result<List<ReciterModel>>> getAllReciters({String? query}) async {
    try {
      final data = await rootBundle.loadString("assets/raw/reciters.json");
      final Map<String, dynamic> result = jsonDecode(data);
      final List<dynamic> parsedResult = result['data'] as List<dynamic>;

      final reciters = parsedResult
          .map((e) => ReciterModel.fromJson(e as Map<String, dynamic>))
          .toList();

      return Result.success(reciters);
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      // ensure any error becomes an Exception
      return Result.error(e);
    }
  }
}
