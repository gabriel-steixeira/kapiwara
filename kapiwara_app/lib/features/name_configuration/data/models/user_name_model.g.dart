// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_name_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserNameModel _$UserNameModelFromJson(Map<String, dynamic> json) =>
    UserNameModel(
      name: json['name'] as String,
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$UserNameModelToJson(UserNameModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'updatedAt': instance.updatedAt.toIso8601String(),
    };
