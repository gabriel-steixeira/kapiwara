import 'package:equatable/equatable.dart';

enum ChatVoiceStatus {
  idle,      // Parado (imagem estática)
  listening, // Escutando (animação de escuta)
  speaking,  // Falando/Respondendo (gif animado)
}

class ChatVoiceStateEntity extends Equatable {
  final ChatVoiceStatus status;
  final String? currentMessage;
  final String? response;

  const ChatVoiceStateEntity({
    required this.status,
    this.currentMessage,
    this.response,
  });

  ChatVoiceStateEntity copyWith({
    ChatVoiceStatus? status,
    String? currentMessage,
    String? response,
  }) {
    return ChatVoiceStateEntity(
      status: status ?? this.status,
      currentMessage: currentMessage ?? this.currentMessage,
      response: response ?? this.response,
    );
  }

  @override
  List<Object?> get props => [status, currentMessage, response];
} 