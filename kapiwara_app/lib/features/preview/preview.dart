import 'package:flutter/material.dart';
import 'package:kapiwara_app/features/emergency_contacts/presentation/pages/emergency_contacts_page.dart';
import 'package:kapiwara_app/features/name_configuration/presentation/pages/name_configuration_screen.dart';
import 'package:kapiwara_app/features/splash/presentation/pages/splash_screen.dart';
import 'package:kapiwara_app/features/home/presentation/pages/home_screen.dart';
import 'package:kapiwara_app/features/chat_voice/presentation/pages/chat_voice_page.dart';
import 'package:kapiwara_app/features/weather/presentation/pages/weather_screen.dart';

void main() { 
  runApp(const Preview());
}

/// Aplicativo de visualização para testar a tela isoladamente.
class Preview extends StatelessWidget {
  const Preview({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherScreen(),
    );
  }
} 