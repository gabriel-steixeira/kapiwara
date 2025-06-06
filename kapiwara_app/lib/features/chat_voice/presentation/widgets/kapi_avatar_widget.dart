import 'package:flutter/material.dart';
import '../bloc/chat_voice_bloc.dart';

class KapiAvatarWidget extends StatelessWidget {
  final ChatVoiceState state;
  
  const KapiAvatarWidget({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 350,
      height: 350,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF73C086), // Verde
            Color(0xFFE85A5A), // Vermelho
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF73C086),
            blurRadius: 60,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipOval(
        child: Center(
          child: _buildAvatarContent(),
        ),
      ),
    );
  }

  Widget _buildAvatarContent() {
    if (state is ChatVoiceSpeaking) {
      // GIF animado quando está falando/respondendo - key única para forçar reconstrução
      return Image.asset(
        'assets/images/chat_voice_screen/kapi_animated.gif',
        key: ValueKey('gif_${DateTime.now().millisecondsSinceEpoch}'),
        fit: BoxFit.contain,
        width: 350,
        height: 350,
        gaplessPlayback: true,
        repeat: ImageRepeat.noRepeat,
      );
    } else if (state is ChatVoiceListening) {
      // Imagem estática quando escutando
      return Image.asset(
        'assets/images/splash_screen/kapiwara_icon.png',
        key: const ValueKey('listening'),
        fit: BoxFit.contain,
        width: 350,
        height: 350,
      );
    } else {
      // Imagem estática padrão (idle/initial)
      return Image.asset(
        'assets/images/splash_screen/kapiwara_icon.png',
        key: const ValueKey('idle'),
        fit: BoxFit.contain,
        width: 350,
        height: 350,
      );
    }
  }
} 