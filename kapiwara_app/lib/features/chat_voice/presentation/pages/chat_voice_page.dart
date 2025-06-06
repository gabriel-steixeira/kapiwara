import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/chat_voice_bloc.dart';
import '../widgets/kapi_avatar_widget.dart';
import '../widgets/voice_control_widget.dart';

class ChatVoicePage extends StatelessWidget {
  const ChatVoicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatVoiceBloc(),
      child: const ChatVoiceView(),
    );
  }
}

class ChatVoiceView extends StatefulWidget {
  const ChatVoiceView({Key? key}) : super(key: key);

  @override
  State<ChatVoiceView> createState() => _ChatVoiceViewState();
}

class _ChatVoiceViewState extends State<ChatVoiceView> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;
    final isTablet = screenWidth > 600;
    
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.592, 1.0],
            colors: [
              Color(0xFFFFEDD3),
              Color(0xFFFFEDD3),
            ],
          ),
        ),
        child: SafeArea(
          child: BlocBuilder<ChatVoiceBloc, ChatVoiceState>(
            builder: (context, state) {
              return Column(
                children: [                  
                  SizedBox(height: screenHeight * (isSmallScreen ? 0.12 : 0.15)),
                  
                  // Avatar da Kapi
                  KapiAvatarWidget(state: state),
                  
                  SizedBox(height: screenHeight * (isSmallScreen ? 0.04 : 0.06)),
                  
                  // Nome "Kapi" responsivo
                  Text(
                    'Kapi',
                    style: TextStyle(
                      fontFamily: 'DINNext',
                      fontWeight: FontWeight.w700,
                      fontSize: isSmallScreen ? 32 : (isTablet ? 48 : 40),
                      color: const Color(0xFF444444),
                    ),
                  ),
                  
                  SizedBox(height: screenHeight * (isSmallScreen ? 0.04 : 0.06)),
                  
                  // Controles de voz
                  VoiceControlWidget(
                    state: state,
                    onMicrophonePressed: () => _handleMicrophonePress(context, state),
                  ),
                  
                  SizedBox(height: screenHeight * (isSmallScreen ? 0.08 : 0.1)),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _handleMicrophonePress(BuildContext context, ChatVoiceState state) {
    final bloc = context.read<ChatVoiceBloc>();
    
    if (state is ChatVoiceInitial || state is ChatVoiceIdle) {
      // Estado inicial ou idle: vai para listening (microfone ligado)
      bloc.add(StartListeningEvent());
    } else if (state is ChatVoiceListening) {
      // Estava escutando: vai para speaking (microfone desligado + gif da Kapi)
      bloc.add(MessageReceivedEvent(""));
    } else if (state is ChatVoiceSpeaking) {
      // Estava falando: volta para listening (microfone ligado)
      bloc.add(StartListeningEvent());
    }
  }
} 