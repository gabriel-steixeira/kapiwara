import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../shared/themes/app_theme.dart';
import '../../../../shared/widgets/bottom_navigation_menu.dart';

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

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    
    // Aqui você pode adicionar navegação para outras telas
    switch (index) {
      case 0:
        // Home - já estamos aqui
        break;
      case 1:
        // Map
        print('Navegando para Mapa');
        break;
      case 2:
        // People
        print('Navegando para Pessoas');
        break;
      case 3:
        // Emergency
        print('Navegando para Emergência');
        break;
    }
  }

  void _onMicrophoneTapped() {
    print('Microfone pressionado');
    // Aqui você pode adicionar a funcionalidade do microfone
  }

  @override
  Widget build(BuildContext context) {
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
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Primeira linha: Avatar e notificação
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Avatar
                          Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              /*border: Border.all(
                                color: AppTheme.languageCardBorder,
                                width: 2,
                              ),*/
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(22),
                              child: Image.asset(
                                'assets/images/home_screen/avatar.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          
                          // Ícone de notificação
                          Container(
                            width: 52,
                            height: 52,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: Colors.transparent,
                              // boxShadow: [
                              //   BoxShadow(
                              //     color: Colors.black.withValues(alpha: 0.1),
                              //     blurRadius: 8,
                              //     offset: const Offset(0, 2),
                              //   ),
                              // ],
                            ),
                            child: Stack(
                              children: [
                                Center(
                                  child: SvgPicture.asset(
                                    'assets/images/home_screen/alert_icon.svg',
                                    width: 32,
                                    height: 32,
                                  ),
                                ),
                                // Ponto vermelho de notificação
                                Positioned(
                                  top: 4,
                                  right: 4,
                                  child: Container(
                                    width: 8,
                                    height: 8,
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
                      
                      const SizedBox(height: 24),
                      
                      // Segunda linha: Saudação
                      Text(
                        'Anauê, $userName',
                        style: const TextStyle(
                          fontFamily: 'DINNext',
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Grid de cards
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        // Card de Clima (ocupa toda a largura)
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(bottom: 48),
                            padding: const EdgeInsets.only(right: 0, top: 0, bottom: 0, left: 0),
                            decoration: BoxDecoration(
                              color: AppTheme.homeClimateCard,
                              borderRadius: BorderRadius.circular(24),
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
                                // Ação do card Clima
                              },
                              borderRadius: BorderRadius.circular(24),
                              child: Row(
                                children: [
                                  // Área do texto (20% da largura)
                                  Expanded(
                                    flex: 3,
                                    child: Container(
                                      height: double.infinity,
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'Clima',
                                        style: TextStyle(
                                          fontFamily: 'DINNext',
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  
                                  // Área da imagem (80% da largura)
                                  Expanded(
                                    flex: 7,
                                    child: Container(
                                      height: double.infinity,
                                      margin: EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.1, top: 0, bottom: 0, left: 0), // 10% de margem à direita
                                      padding: EdgeInsets.only(right: 0, top: 0, bottom: 0, left: 0),
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(24),
                                          bottomRight: Radius.circular(24),
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(24),
                                          bottomRight: Radius.circular(24),
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
                        
                        // Cards inferiores (Ambiental e Biológico)
                        Expanded(
                          flex: 1,
                          child: Row(
                            children: [
                              // Card Ambiental
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(right: 16),
                                  decoration: BoxDecoration(
                                    color: AppTheme.homeAmbientalCard,
                                    borderRadius: BorderRadius.circular(24),
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
                                    borderRadius: BorderRadius.circular(24),
                                    child: Stack(
                                      children: [
                                        // Imagem da floresta no fundo
                                        Positioned(
                                          bottom: 0,
                                          left: 0,
                                          right: 0,
                                          child: ClipRRect(
                                            borderRadius: const BorderRadius.only(
                                              bottomLeft: Radius.circular(24),
                                              bottomRight: Radius.circular(24),
                                            ),
                                            child: Image.asset(
                                              'assets/images/home_screen/forest.png',
                                              fit: BoxFit.cover,
                                              width: double.infinity,
                                            ),
                                          ),
                                        ),
                                        
                                        // Texto "Ambiental" sobreposto
                                        const Positioned(
                                          top: 16,
                                          left: 16,
                                          child: Text(
                                            'Ambiental',
                                            style: TextStyle(
                                              fontFamily: 'DINNext',
                                              fontSize: 24,
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
                                  margin: const EdgeInsets.only(left: 16),
                                  decoration: BoxDecoration(
                                    color: AppTheme.homeBiologicalCard,
                                    borderRadius: BorderRadius.circular(24),
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
                                    borderRadius: BorderRadius.circular(24),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Texto "Biológico"
                                        const Padding(
                                          padding: EdgeInsets.all(16),
                                          child: Text(
                                            'Biológico',
                                            style: TextStyle(
                                              fontFamily: 'DINNext',
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        
                                        // Imagem da saúde
                                        Expanded(
                                          child: Container(
                                            width: double.infinity,
                                            padding: const EdgeInsets.symmetric(horizontal: 24),
                                            child: Center(
                                              child: Image.asset(
                                                'assets/images/home_screen/health.png',
                                                fit: BoxFit.contain,
                                                width: double.infinity,
                                              ),
                                            ),
                                          ),
                                        ),
                                        
                                        const SizedBox(height: 16),
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
                
                // Espaçamento para o bottom menu
                const SizedBox(height: 150),
              ],
            ),
            
            // Bottom Navigation Menu Component
            BottomNavigationMenu(
              selectedIndex: selectedIndex,
              onItemTapped: _onItemTapped,
              onMicrophoneTapped: _onMicrophoneTapped,
            ),
          ],
        ),
      ),
    );
  }
} 