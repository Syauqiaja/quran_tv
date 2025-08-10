// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../reciter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReciterModel _$ReciterModelFromJson(Map<String, dynamic> json) => ReciterModel(
  json['madzhab'] as String?,
  (json['id'] as num).toInt(),
  name: json['name'] as String,
  rewaya: json['rewaya'] as String?,
  domicile: json['domicile'] as String?,
  imageUrl: json['image_url'] as String?,
);

Map<String, dynamic> _$ReciterModelToJson(ReciterModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'rewaya': instance.rewaya,
      'domicile': instance.domicile,
      'madzhab': instance.madzhab,
      'image_url': instance.imageUrl,
    };
