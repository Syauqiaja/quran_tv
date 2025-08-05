
import 'package:json_annotation/json_annotation.dart';
part 'generated/reciter_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ReciterModel {
  final String? name;
  final String? rewaya;
  final String? domicile;
  final String? imageUrl;

  ReciterModel({required this.name, required this.rewaya, required this.domicile, required this.imageUrl});

  factory ReciterModel.fromJson(Map<String, dynamic> json) => _$ReciterModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReciterModelToJson(this);
}