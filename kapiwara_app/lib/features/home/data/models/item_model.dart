import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/item_entity.dart';

part 'item_model.g.dart';

@JsonSerializable()
class ItemModel extends ItemEntity {
  const ItemModel({
    required super.id,
    required super.title,
    required super.description,
    required super.imageUrl,
    required super.createdAt,
  });
  
  factory ItemModel.fromJson(Map<String, dynamic> json) => _$ItemModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$ItemModelToJson(this);
  
  factory ItemModel.fromEntity(ItemEntity entity) {
    return ItemModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      imageUrl: entity.imageUrl,
      createdAt: entity.createdAt,
    );
  }
} 