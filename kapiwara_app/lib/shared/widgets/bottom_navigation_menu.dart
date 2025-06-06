import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../themes/app_theme.dart';
import '../../features/chat_voice/presentation/pages/chat_voice_page.dart';

class BottomNavigationMenu extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BottomNavigationMenu({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 400;
    
    return Stack(
      children: [
        // Bottom Menu
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: isSmallScreen ? 70 : 80,
            decoration: BoxDecoration(
              color: AppTheme.homeBottomMenu,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(isSmallScreen ? 20 : 24),
                topRight: Radius.circular(isSmallScreen ? 20 : 24),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Home icon
                _buildMenuItem(
                  iconPath: 'assets/images/home_screen/home_icon.svg',
                  index: 0,
                  isSelected: selectedIndex == 0,
                  isSmallScreen: isSmallScreen,
                ),
                
                // Map icon
                _buildMenuItem(
                  iconPath: 'assets/images/home_screen/map_icon.svg',
                  index: 1,
                  isSelected: selectedIndex == 1,
                  isSmallScreen: isSmallScreen,
                ),
                
                // Espaço para o microfone
                SizedBox(width: isSmallScreen ? 60 : 80),
                
                // People icon
                _buildMenuItem(
                  iconPath: 'assets/images/home_screen/people_icon.svg',
                  index: 2,
                  isSelected: selectedIndex == 2,
                  isSmallScreen: isSmallScreen,
                ),
                
                // Emergency icon
                _buildMenuItem(
                  iconPath: 'assets/images/home_screen/emergency_icon.svg',
                  index: 3,
                  isSelected: selectedIndex == 3,
                  isSmallScreen: isSmallScreen,
                ),
              ],
            ),
          ),
        ),
        
        // Microfone icon (z-index mais alto - por cima de tudo) responsivo
        Positioned(
          bottom: isSmallScreen ? 35 : 45,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              width: isSmallScreen ? 64 : 74,
              height: isSmallScreen ? 64 : 74,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    AppTheme.homeMicrophoneGradientStart, // Vermelho
                    AppTheme.homeMicrophoneGradientEnd,   // Verde
                  ],
                  stops: [0.3, 1], // 70% vermelho, 30% verde
                ),
                border: Border.all(
                  color: AppTheme.languageScreenBackground,
                  width: isSmallScreen ? 5 : 7,
                ),
              ),
              child: InkWell(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ChatVoicePage()),
                ),
                borderRadius: BorderRadius.circular(32),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/home_screen/microphone_icon.svg',
                    width: isSmallScreen ? 30 : 36,
                    height: isSmallScreen ? 30 : 36,
                    colorFilter: const ColorFilter.mode(
                      AppTheme.homeMicrophoneIcon,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required String iconPath,
    required int index,
    required bool isSelected,
    required bool isSmallScreen,
  }) {
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Container(
        padding: EdgeInsets.only(top: isSmallScreen ? 8 : 12),
        child: isSelected
            ? ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [
                    AppTheme.homeSelectedIconStart,
                    AppTheme.homeSelectedIconEnd,
                  ],
                ).createShader(bounds),
                child: SvgPicture.asset(
                  iconPath,
                  width: isSmallScreen ? 24 : 28,
                  height: isSmallScreen ? 24 : 28,
                ),
              )
            : SvgPicture.asset(
                iconPath,
                width: isSmallScreen ? 24 : 28,
                height: isSmallScreen ? 24 : 28,
                colorFilter: const ColorFilter.mode(
                  AppTheme.homeUnselectedIcon,
                  BlendMode.srcIn,
                ),
              ),
      ),
    );
  }
} 