import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/user_name_entity.dart';

part 'user_name_model.g.dart';

@JsonSerializable()
class UserNameModel extends UserNameEntity {
  const UserNameModel({
    required super.name,
    required super.updatedAt,
  });
  
  factory UserNameModel.fromJson(Map<String, dynamic> json) => _$UserNameModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$UserNameModelToJson(this);
  
  factory UserNameModel.fromEntity(UserNameEntity entity) {
    return UserNameModel(
      name: entity.name,
      updatedAt: entity.updatedAt,
    );
  }
} 