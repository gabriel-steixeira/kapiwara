import 'package:equatable/equatable.dart';

class EmergencyContactEntity extends Equatable {
  final String nome;
  final String telefone;
  final String tipo;
  final String? iconePath;
  final String? imagePath;

  const EmergencyContactEntity({
    required this.nome,
    required this.telefone,
    required this.tipo,
    this.iconePath,
    this.imagePath,
  });

  @override
  List<Object?> get props => [nome, telefone, tipo, iconePath, imagePath];
} 