// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../reciter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReciterModel _$ReciterModelFromJson(Map<String, dynamic> json) => ReciterModel(
  name: json['name'] as String?,
  rewaya: json['rewaya'] as String?,
  domicile: json['domicile'] as String?,
  imageUrl: json['image_url'] as String?,
);

Map<String, dynamic> _$ReciterModelToJson(ReciterModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'rewaya': instance.rewaya,
      'domicile': instance.domicile,
      'image_url': instance.imageUrl,
    };
