import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../shared/themes/app_theme.dart';
import '../../../../shared/widgets/bottom_navigation_menu.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  int selectedIndex = 1; // Weather está selecionado (índice 1 - cloud icon)
  
  // Mock data para os medidores
  final double sunProgress = 0.6; // 80%
  final double cloudProgress = 0.4; // 60%
  final double windProgress = 0.8; // 40%
  final double rainProgress = 0.2; // 20%
  
  final String temperature = '35°'; // Temperatura mockada

  bool _isDayTime() {
    final now = DateTime.now();
    final hour = now.hour;
    return hour >= 6 && hour < 18;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 400;
    final isDayTime = _isDayTime();
    
    return Scaffold(
      backgroundColor: isDayTime ? const Color(0xFF715848) : const Color(0xFF040C13),
      body: SafeArea(
        child: Stack(
          children: [
            // Conteúdo de fundo (medidores)
            Column(
              children: [
                // Espaço para a parte superior (50% da tela)
                Expanded(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    color: isDayTime ? const Color(0xFF715848) : const Color(0xFF040C13),
                  ),
                ),
                
                // Parte inferior com medidores (50% da tela)
                Expanded(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    color: isDayTime ? const Color(0xFF715848) : const Color(0xFF040C13),
                    padding: EdgeInsets.only(
                      top: isSmallScreen ? 50 : 32,
                      left: isSmallScreen ? 20 : 32,
                      right: isSmallScreen ? 20 : 32,
                      bottom: 35, // Espaço fixo de 35px para o menu
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(height: isSmallScreen ? 16 : 24), // Espaçamento inicial reduzido
                          
                          // Medidor 1 - Sol
                          _buildMeter(
                            iconPath: 'assets/images/weather_screen/sun_icon.svg',
                            progress: sunProgress,
                            isSmallScreen: isSmallScreen,
                          ),
                          
                          SizedBox(height: isSmallScreen ? 12 : 20), // Espaçamento reduzido
                          
                          // Medidor 2 - Nuvem
                          _buildMeter(
                            iconPath: 'assets/images/weather_screen/cloud_icon.svg',
                            progress: cloudProgress,
                            isSmallScreen: isSmallScreen,
                          ),
                          
                          SizedBox(height: isSmallScreen ? 12 : 20), // Espaçamento reduzido
                          
                          // Medidor 3 - Vento
                          _buildMeter(
                            iconPath: 'assets/images/weather_screen/wind.svg',
                            progress: windProgress,
                            isSmallScreen: isSmallScreen,
                          ),
                          
                          SizedBox(height: isSmallScreen ? 12 : 20), // Espaçamento reduzido
                          
                          // Medidor 4 - Chuva
                          _buildMeter(
                            iconPath: 'assets/images/weather_screen/rain.svg',
                            progress: rainProgress,
                            isSmallScreen: isSmallScreen,
                          ),
                          
                          //SizedBox(height: isSmallScreen ? 16 : 24), // Espaçamento final
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            
            // Imagem de fundo na frente (50% superior da tela)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: MediaQuery.of(context).size.height * 0.5, // 50% da altura da tela
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      isDayTime 
                        ? 'assets/images/weather_screen/light_theme.png'
                        : 'assets/images/weather_screen/dark_theme.png'
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Stack(
                  children: [
                    // Ícone de notificação no canto superior direito
                    Positioned(
                      top: 20,
                      right: 20,
                      child: Container(
                        width: isSmallScreen ? 44 : 52,
                        height: isSmallScreen ? 44 : 52,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(isSmallScreen ? 20 : 24),
                          color: Colors.transparent,
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: SvgPicture.asset(
                                'assets/images/home_screen/alert_icon.svg',
                                width: isSmallScreen ? 28 : 32,
                                height: isSmallScreen ? 28 : 32,
                                colorFilter: isDayTime 
                                    ? null // Cor original durante o dia
                                    : const ColorFilter.mode(
                                        Colors.white,
                                        BlendMode.srcIn,
                                    ), // Cor branca durante a noite
                              ),
                            ),
                            // Ponto vermelho de notificação
                            Positioned(
                              top: isSmallScreen ? 2 : 4,
                              right: isSmallScreen ? 2 : 4,
                              child: Container(
                                width: isSmallScreen ? 6 : 8,
                                height: isSmallScreen ? 6 : 8,
                                decoration: const BoxDecoration(
                                  color: AppTheme.homeAmbientalCard,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    // Temperatura no centro
                    Center(
                      child: ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: isDayTime 
                            ? [
                                const Color(0xFFE18700),
                                const Color(0xFFE18700).withValues(alpha: 0.7),
                              ]
                            : [
                                const Color(0xFF345995),
                                const Color(0xFF345995).withValues(alpha: 0.7),
                              ],
                        ).createShader(bounds),
                        child: Text(
                          temperature,
                          style: TextStyle(
                            fontFamily: 'DINNext',
                            fontSize: isSmallScreen ? 64 : 80,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            // Menu de navegação inferior
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: BottomNavigationMenu(
                selectedIndex: selectedIndex,
                isWeatherScreen: true
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMeter({
    required String iconPath,
    required double progress,
    required bool isSmallScreen,
  }) {    
    return Row(
      children: [
        // Ícone com largura fixa para alinhamento
        SizedBox(
          width: isSmallScreen ? 56 : 64, // Largura aumentada para ícones maiores
          child: Center(
            child: SvgPicture.asset(
              iconPath,
              width: isSmallScreen ? 48 : 56, // Ícones maiores
              height: isSmallScreen ? 48 : 56, // Ícones maiores
            ),
          ),
        ),
        
        SizedBox(width: isSmallScreen ? 12 : 24), // Espaçamento aumentado
        
        // Progress bar
        Expanded(
          child: Container(
            height: isSmallScreen ? 18 : 26, // Altura aumentada das progress bars
            decoration: BoxDecoration(
              color: const Color(0xFF212023),
              borderRadius: BorderRadius.circular(isSmallScreen ? 10 : 13),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: progress,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color(0xFF73C086), // 0%
                      Color(0xFFE85A5A), // 100%
                    ],
                  ),
                  borderRadius: BorderRadius.circular(isSmallScreen ? 10 : 13),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
} 