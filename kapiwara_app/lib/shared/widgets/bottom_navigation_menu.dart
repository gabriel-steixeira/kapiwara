import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../themes/app_theme.dart';

class BottomNavigationMenu extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;
  final VoidCallback? onMicrophoneTapped;

  const BottomNavigationMenu({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
    this.onMicrophoneTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Bottom Menu
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 80,
            decoration: const BoxDecoration(
              color: AppTheme.homeBottomMenu,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
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
                ),
                
                // Map icon
                _buildMenuItem(
                  iconPath: 'assets/images/home_screen/map_icon.svg',
                  index: 1,
                  isSelected: selectedIndex == 1,
                ),
                
                // Espaço para o microfone
                const SizedBox(width: 48),
                
                // People icon
                _buildMenuItem(
                  iconPath: 'assets/images/home_screen/people_icon.svg',
                  index: 2,
                  isSelected: selectedIndex == 2,
                ),
                
                // Emergency icon
                _buildMenuItem(
                  iconPath: 'assets/images/home_screen/emergency_icon.svg',
                  index: 3,
                  isSelected: selectedIndex == 3,
                ),
              ],
            ),
          ),
        ),
        
        // Microfone icon (z-index mais alto - por cima de tudo)
        Positioned(
          bottom: 45,
          left: 0,
          right: 0,
          child: Center(
            child: Container(
              width: 74,
              height: 74,
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
                  width: 7,
                ),
              ),
              child: InkWell(
                onTap: onMicrophoneTapped,
                borderRadius: BorderRadius.circular(32),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/home_screen/microphone_icon.svg',
                    width: 36,
                    height: 36,
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
  }) {
    return GestureDetector(
      onTap: () => onItemTapped(index),
      child: Container(
        padding: const EdgeInsets.only(top: 12),
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
                  width: 28,
                  height: 28,
                ),
              )
            : SvgPicture.asset(
                iconPath,
                width: 28,
                height: 28,
                colorFilter: const ColorFilter.mode(
                  AppTheme.homeUnselectedIcon,
                  BlendMode.srcIn,
                ),
              ),
      ),
    );
  }
} 