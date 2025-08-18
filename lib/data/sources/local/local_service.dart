import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quran_tv/data/models/quran_line_model.dart';
import 'package:quran_tv/data/models/quran_model.dart';
import 'package:quran_tv/data/models/reciter_model.dart';
import 'package:quran_tv/data/sources/result.dart';

class LocalService {
  Future<Result<List<ReciterModel>>> getAllReciters({String? query}) {
    return _loadList(
      "assets/raw/reciters.json",
      (json) => ReciterModel.fromJson(json),
    );
  }

  Future<Result<List<QuranModel>>> getQurans() {
    return _loadList(
      "assets/raw/quran.json",
      (json) => QuranModel.fromJson(json),
    );
  }

  Future<Result<QuranModel>> getQuran(int surah) async {
    final result = await getQurans();
    switch (result) {
      case Success():
        final quranModel = result.value.indexWhere((e) => e.number == surah);
        if (quranModel != -1) {
          return Result.success(
            result.value.firstWhere((e) => e.number == surah),
          );
        } else {
          return Result.error(Exception("Surah $surah not found"));
        }
      case Error():
        return Result.error(result.error);
    }
  }

  Future<Result<List<QuranLineModel>>> getQuranLines(int surah) {
    return _loadList(
      "assets/quran/al-mulk/067_aligned_lines_with_start_times.json",
      (json) => QuranLineModel.fromJson(json),
    );
  }

  /// Generic JSON loader & parser
  Future<Result<List<T>>> _loadList<T>(
    String assetPath,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    try {
      final data = await rootBundle.loadString(assetPath);
      final List<dynamic> parsedResult = jsonDecode(data) as List<dynamic>;

      final items = parsedResult
          .map((e) => fromJson(e as Map<String, dynamic>))
          .toList();

      return Result.success(items);
    } catch (e, s) {
      debugPrintStack(stackTrace: s);
      return Result.error(e);
    }
  }
}
