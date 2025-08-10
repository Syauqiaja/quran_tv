// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../quran_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuranModel _$QuranModelFromJson(Map<String, dynamic> json) => QuranModel(
  json['type'] as String?,
  (json['duration'] as num?)?.toInt(),
  title: json['title'] as String,
  totalAyahs: (json['total_ayahs'] as num?)?.toInt(),
  totalLines: (json['total_lines'] as num?)?.toInt(),
);

Map<String, dynamic> _$QuranModelToJson(QuranModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'type': instance.type,
      'total_ayahs': instance.totalAyahs,
      'total_lines': instance.totalLines,
      'duration': instance.duration,
    };
