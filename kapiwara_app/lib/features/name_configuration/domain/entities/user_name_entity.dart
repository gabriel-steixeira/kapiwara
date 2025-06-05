import 'package:equatable/equatable.dart';

class UserNameEntity extends Equatable {
  final String name;
  final DateTime updatedAt;
  
  const UserNameEntity({
    required this.name,
    required this.updatedAt,
  });
  
  @override
  List<Object> get props => [name, updatedAt];
} 