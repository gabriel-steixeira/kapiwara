import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../shared/themes/app_theme.dart';
import '../../../../shared/widgets/bottom_navigation_menu.dart';
import '../../../weather/presentation/pages/weather_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String userName = '';
  int selectedIndex = 0; // Home está selecionado por padrão

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final prefs = await SharedPreferences.getInstance();
    final savedName = prefs.getString('user_name') ?? '';
    setState(() {
      userName = savedName;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 400;
    final isTablet = screenWidth > 600;
    
    return Scaffold(
      backgroundColor: AppTheme.languageScreenBackground,
      body: SafeArea(
        child: Stack(
          children: [
            // Conteúdo principal
            Column(
              children: [
                // Header com avatar e notificação
                Padding(
                  padding: EdgeInsets.all(isSmallScreen ? 20 : 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Primeira linha: Avatar e notificação
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Avatar responsivo
                          Container(
                            width: isSmallScreen ? 56 : 64,
                            height: isSmallScreen ? 56 : 64,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(isSmallScreen ? 20 : 24),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(isSmallScreen ? 18 : 22),
                              child: Image.asset(
                                'assets/images/home_screen/avatar.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          
                          // Ícone de notificação responsivo
                          Container(
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
                        ],
                      ),
                      
                      SizedBox(height: isSmallScreen ? 16 : 24),
                      
                      // Segunda linha: Saudação responsiva
                      Text(
                        'Anauê, $userName',
                        style: TextStyle(
                          fontFamily: 'DINNext',
                          fontSize: isSmallScreen ? 28 : (isTablet ? 42 : 36),
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Grid de cards responsivo
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 20 : 40),
                    child: Column(
                      children: [
                        // Card de Clima (ocupa toda a largura)
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(bottom: isSmallScreen ? 24 : 48),
                            decoration: BoxDecoration(
                              color: AppTheme.homeClimateCard,
                              borderRadius: BorderRadius.circular(isSmallScreen ? 20 : 24),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => const WeatherScreen()),
                                );
                              },
                              borderRadius: BorderRadius.circular(isSmallScreen ? 20 : 24),
                              child: Row(
                                children: [
                                  // Área do texto responsiva
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      height: double.infinity,
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Clima',
                                        style: TextStyle(
                                          fontFamily: 'DINNext',
                                          fontSize: isSmallScreen ? 20 : 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  
                                  // Área da imagem responsiva
                                  Expanded(
                                    flex: 7,
                                    child: Container(
                                      height: double.infinity,
                                      margin: EdgeInsets.only(
                                        right: screenWidth * 0.1,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(isSmallScreen ? 20 : 24),
                                          bottomRight: Radius.circular(isSmallScreen ? 20 : 24),
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(isSmallScreen ? 20 : 24),
                                          bottomRight: Radius.circular(isSmallScreen ? 20 : 24),
                                        ),
                                        child: Image.asset(
                                          'assets/images/home_screen/rain_image.png',
                                          fit: BoxFit.contain,
                                          width: double.infinity,
                                          height: double.infinity,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        
                        // Cards inferiores (Ambiental e Biológico) responsivos
                        Expanded(
                          flex: 1,
                          child: Row(
                            children: [
                              // Card Ambiental
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(right: isSmallScreen ? 8 : 16),
                                  decoration: BoxDecoration(
                                    color: AppTheme.homeAmbientalCard,
                                    borderRadius: BorderRadius.circular(isSmallScreen ? 20 : 24),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.1),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      // Ação do card Ambiental
                                    },
                                    borderRadius: BorderRadius.circular(isSmallScreen ? 20 : 24),
                                    child: Stack(
                                      children: [
                                        // Imagem da floresta no fundo
                                        Positioned(
                                          bottom: 0,
                                          left: 0,
                                          right: 0,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(isSmallScreen ? 20 : 24),
                                              bottomRight: Radius.circular(isSmallScreen ? 20 : 24),
                                            ),
                                            child: Image.asset(
                                              'assets/images/home_screen/forest.png',
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                            ),
                                          ),
                                        ),
                                        
                                        // Texto "Ambiental" sobreposto responsivo
                                        Positioned(
                                          top: isSmallScreen ? 12 : 16,
                                          left: isSmallScreen ? 12 : 16,
                                          child: Text(
                                            'Ambiental',
                                            style: TextStyle(
                                              fontFamily: 'DINNext',
                                              fontSize: isSmallScreen ? 18 : 24,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              
                              // Card Biológico
                              Expanded(
                                child: Container(
                                  margin: EdgeInsets.only(left: isSmallScreen ? 8 : 16),
                                  decoration: BoxDecoration(
                                    color: AppTheme.homeBiologicalCard,
                                    borderRadius: BorderRadius.circular(isSmallScreen ? 20 : 24),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.1),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      // Ação do card Biológico
                                    },
                                    borderRadius: BorderRadius.circular(isSmallScreen ? 20 : 24),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Texto "Biológico" responsivo
                                        Padding(
                                          padding: EdgeInsets.all(isSmallScreen ? 12 : 16),
                                          child: Text(
                                            'Biológico',
                                            style: TextStyle(
                                              fontFamily: 'DINNext',
                                              fontSize: isSmallScreen ? 18 : 24,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        
                                        // Imagem da saúde responsiva
                                        Expanded(
                                          child: Container(
                                            width: double.infinity,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: isSmallScreen ? 16 : 24,
                                            ),
                                            child: Center(
                                              child: Image.asset(
                                                'assets/images/home_screen/health.png',
                                                fit: BoxFit.contain,
                                                width: double.infinity,
                                              ),
                                            ),
                                          ),
                                        ),
                                        
                                        SizedBox(height: isSmallScreen ? 12 : 16),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Espaçamento para o bottom menu responsivo
                SizedBox(height: isSmallScreen ? 120 : 150),
                
                // Bottom Navigation Menu Component
                BottomNavigationMenu(
                  selectedIndex: selectedIndex,
                ),
              ],
            ),
            
          ],
        ),
      ),
    );
  }
} 