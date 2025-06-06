import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../bloc/chat_voice_bloc.dart';
import '../../../../shared/themes/app_theme.dart';

class VoiceControlWidget extends StatefulWidget {
  final ChatVoiceState state;
  final VoidCallback onMicrophonePressed;
  
  const VoiceControlWidget({
    Key? key,
    required this.state,
    required this.onMicrophonePressed,
  }) : super(key: key);

  @override
  State<VoiceControlWidget> createState() => _VoiceControlWidgetState();
}

class _VoiceControlWidgetState extends State<VoiceControlWidget>
    with TickerProviderStateMixin {
  late AnimationController _waveController;
  late Animation<double> _waveAnimation;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _waveAnimation = Tween<double>(
      begin: 0.8,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: _waveController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void didUpdateWidget(VoiceControlWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.state is ChatVoiceListening && oldWidget.state is! ChatVoiceListening) {
      _waveController.repeat(reverse: true);
    } else if (widget.state is! ChatVoiceListening && oldWidget.state is ChatVoiceListening) {
      _waveController.stop();
      _waveController.reset();
    }
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isListening = widget.state is ChatVoiceListening;
    
    return Container(
      width: isListening ? 341 : 291, // Aumenta a largura quando escutando
      height: 100,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Círculos de ondas de som (quando escutando)
          if (isListening) ..._buildSoundWaves(),
          
          // Layout horizontal dos controles com animação
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: Row(
              mainAxisAlignment: isListening 
                  ? MainAxisAlignment.spaceBetween 
                  : MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Botão esquerdo (azul) - mensagens
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  margin: EdgeInsets.only(
                    right: isListening ? 40 : 0,
                  ),
                  child: _buildMessagesButton(),
                ),
                
                // Botão central do microfone
                _buildMicrophoneButton(),
                
                // Botão direito (vermelho) - parar
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  margin: EdgeInsets.only(
                    left: isListening ? 40 : 0,
                  ),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: _buildControlButton(
                      color: const Color(0xFFE85A5A),
                      icon: Icons.close,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildSoundWaves() {
    return [
      // Círculo externo com animação
      AnimatedBuilder(
        animation: _waveAnimation,
        builder: (context, child) {
          return Positioned(
            child: Container(
              width: 240 * _waveAnimation.value,
              height: 240 * _waveAnimation.value,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF73C086).withOpacity(0.3),
                  width: 1,
                ),
              ),
            ),
          );
        },
      ),
      // Círculo médio com animação (delay)
      AnimatedBuilder(
        animation: _waveAnimation,
        builder: (context, child) {
          return Positioned(
            child: Container(
              width: 220 * (_waveAnimation.value * 0.9),
              height: 220 * (_waveAnimation.value * 0.9),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF73C086).withOpacity(0.5),
                  width: 1,
                ),
              ),
            ),
          );
        },
      ),
      // Círculo interno com animação (menor delay)
      AnimatedBuilder(
        animation: _waveAnimation,
        builder: (context, child) {
          return Positioned(
            child: Container(
              width: 190 * (_waveAnimation.value * 0.8),
              height: 190 * (_waveAnimation.value * 0.8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF73C086).withOpacity(0.7),
                  width: 1,
                ),
              ),
            ),
          );
        },
      ),
    ];
  }

  Widget _buildMicrophoneButton() {
    return GestureDetector(
      onTap: widget.onMicrophonePressed,
      child: Container(
        width: 85,
        height: 85,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              AppTheme.homeMicrophoneGradientStart, // Vermelho
              AppTheme.homeMicrophoneGradientEnd,   // Verde
            ],
          ),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF73C086).withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Icon(
          widget.state is ChatVoiceListening ? Icons.mic : Icons.mic_none,
          size: 50,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildMessagesButton() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF345995),
        border: Border.all(color: const Color(0xFF345995)),
      ),
      child: Center(
        child: SvgPicture.asset(
          'assets/icons/messages_icon.svg',
          width: 30,
          height: 30,
          colorFilter: const ColorFilter.mode(
            Colors.white,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }

  Widget _buildControlButton({
    required Color color,
    required IconData icon,
  }) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: color),
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 40,
      ),
    );
  }
} 