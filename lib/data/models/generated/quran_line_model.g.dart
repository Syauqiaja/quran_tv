// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../quran_line_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuranLineModel _$QuranLineModelFromJson(Map<String, dynamic> json) =>
    QuranLineModel(
      lineText: json['line_text'] as String,
      surah: json['surah'] as String,
      page: json['page'] as String,
      line: json['line'] as String,
      startTimeMs: (json['start_time_ms'] as num).toInt(),
      levenshteinDistance: (json['levenshtein_distance'] as num).toInt(),
    );

Map<String, dynamic> _$QuranLineModelToJson(QuranLineModel instance) =>
    <String, dynamic>{
      'line_text': instance.lineText,
      'surah': instance.surah,
      'page': instance.page,
      'line': instance.line,
      'start_time_ms': instance.startTimeMs,
      'levenshtein_distance': instance.levenshteinDistance,
    };
