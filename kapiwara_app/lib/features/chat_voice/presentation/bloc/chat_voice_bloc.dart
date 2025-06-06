import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/chat_voice_state_entity.dart';

// Events
abstract class ChatVoiceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class StartListeningEvent extends ChatVoiceEvent {}

class StopListeningEvent extends ChatVoiceEvent {}

class MessageReceivedEvent extends ChatVoiceEvent {
  final String message;

  MessageReceivedEvent(this.message);

  @override
  List<Object?> get props => [message];
}

class StartSpeakingEvent extends ChatVoiceEvent {
  final String response;

  StartSpeakingEvent(this.response);

  @override
  List<Object?> get props => [response];
}

class FinishSpeakingEvent extends ChatVoiceEvent {}

// States
abstract class ChatVoiceState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ChatVoiceInitial extends ChatVoiceState {}

class ChatVoiceIdle extends ChatVoiceState {}

class ChatVoiceListening extends ChatVoiceState {}

class ChatVoiceSpeaking extends ChatVoiceState {
  final String response;

  ChatVoiceSpeaking(this.response);

  @override
  List<Object?> get props => [response];
}

class ChatVoiceError extends ChatVoiceState {
  final String message;

  ChatVoiceError(this.message);

  @override
  List<Object?> get props => [message];
}

// BLoC
class ChatVoiceBloc extends Bloc<ChatVoiceEvent, ChatVoiceState> {
  ChatVoiceBloc() : super(ChatVoiceInitial()) {
    on<StartListeningEvent>(_onStartListening);
    on<StopListeningEvent>(_onStopListening);
    on<MessageReceivedEvent>(_onMessageReceived);
    on<StartSpeakingEvent>(_onStartSpeaking);
    on<FinishSpeakingEvent>(_onFinishSpeaking);
  }

  void _onStartListening(StartListeningEvent event, Emitter<ChatVoiceState> emit) {
    emit(ChatVoiceListening());
  }

  void _onStopListening(StopListeningEvent event, Emitter<ChatVoiceState> emit) {
    emit(ChatVoiceIdle());
  }

  void _onMessageReceived(MessageReceivedEvent event, Emitter<ChatVoiceState> emit) {
    // Simular processamento e ir direto para o estado de fala sem texto
    emit(ChatVoiceSpeaking(""));
    
    // Não volta automaticamente para idle - usuário controla pelo clique
  }

  void _onStartSpeaking(StartSpeakingEvent event, Emitter<ChatVoiceState> emit) {
    emit(ChatVoiceSpeaking(event.response));
  }

  void _onFinishSpeaking(FinishSpeakingEvent event, Emitter<ChatVoiceState> emit) {
    emit(ChatVoiceIdle());
  }
} 