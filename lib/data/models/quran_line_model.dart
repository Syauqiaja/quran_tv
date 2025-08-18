import 'package:json_annotation/json_annotation.dart';

part 'generated/quran_line_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
final class QuranLineModel {
  final String lineText;
  final String surah;
  final String page;
  final String line;
  final int startTimeMs;
  final int levenshteinDistance;

  QuranLineModel({required this.lineText, required this.surah, required this.page, required this.line, required this.startTimeMs, required this.levenshteinDistance});

  factory QuranLineModel.fromJson(Map<String, dynamic> json) => _$QuranLineModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuranLineModelToJson(this);
}