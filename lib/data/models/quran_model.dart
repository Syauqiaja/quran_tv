import 'package:json_annotation/json_annotation.dart';
part 'generated/quran_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class QuranModel {
  final String title;
  final String? type; //Makiyah or Madaniyah
  final int? totalAyahs;
  final int? totalLines;
  final int? duration; //in seconds

  QuranModel(this.type, this.duration, {required this.title, required this.totalAyahs, required this.totalLines});

  factory QuranModel.fromJson(Map<String, dynamic> json) => _$QuranModelFromJson(json);

  Map<String, dynamic> toJson() => _$QuranModelToJson(this);
}