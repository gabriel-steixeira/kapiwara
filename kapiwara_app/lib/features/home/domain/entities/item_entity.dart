import 'package:equatable/equatable.dart';

class ItemEntity extends Equatable {
  final int id;
  final String title;
  final String description;
  final String imageUrl;
  final DateTime createdAt;
  
  const ItemEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.createdAt,
  });
  
  @override
  List<Object> get props => [id, title, description, imageUrl, createdAt];
} 