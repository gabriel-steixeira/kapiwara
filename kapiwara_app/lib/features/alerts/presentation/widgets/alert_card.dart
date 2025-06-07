import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../shared/themes/app_theme.dart';

class AlertCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final Color borderColor;
  final String icon;
  final String listenIcon;
  final String viewMoreIcon;
  final Color listenColor;
  final Color viewMoreColor;
  final VoidCallback onListen;
  final VoidCallback onViewMore;
  final bool isDarkTheme;

  const AlertCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.borderColor,
    required this.icon,
    required this.listenIcon,
    required this.viewMoreIcon,
    required this.listenColor,
    required this.viewMoreColor,
    required this.onListen,
    required this.onViewMore,
    this.isDarkTheme = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 312,
      height: 120,
      decoration: BoxDecoration(
        color: isDarkTheme ? AppTheme.alertsDarkCardBackground : AppTheme.alertsLightCardBackground,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: borderColor,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: borderColor,
            blurRadius: 0,
            offset: const Offset(-6, 0),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: isDarkTheme ? 0.3 : 0.15),
            blurRadius: 34,
            offset: const Offset(0, 34),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Ícone do tipo de alerta (lado esquerdo)
          Positioned(
            left: 12,
            top: 15,
            child: SvgPicture.asset(
              icon,
              width: 19,
              height: 19,
              colorFilter: isDarkTheme 
                ? const ColorFilter.mode(Colors.white, BlendMode.srcIn)
                : null,
            ),
          ),
          // Título e subtítulo
          Positioned(
            left: 36,
            top: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'DINNext',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDarkTheme ? AppTheme.darkThemeTextPrimary : AppTheme.textPrimary,
                    height: 1.375,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontFamily: 'DINNext',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: isDarkTheme ? AppTheme.darkThemeTextSecondary : AppTheme.textPrimary,
                    height: 1.375,
                  ),
                ),
              ],
            ),
          ),
          // Descrição
          Positioned(
            left: 36,
            top: 53,
            child: Text(
              description,
              style: TextStyle(
                fontFamily: 'DINNext',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: isDarkTheme ? AppTheme.darkThemeTextTertiary : AppTheme.textPrimary,
                height: 1.375,
              ),
            ),
          ),
          // Botão OUVIR
          Positioned(
            left: 36,
            top: 79,
            child: GestureDetector(
              onTap: onListen,
              child: Container(
                width: 95,
                height: 25,
                decoration: BoxDecoration(
                  color: listenColor,
                  borderRadius: BorderRadius.circular(16.59),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: isDarkTheme ? 0.3 : 0.15),
                      blurRadius: 28.21,
                      offset: const Offset(0, 28.21),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      listenIcon,
                      width: 14,
                      height: 14,
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'OUVIR',
                      style: TextStyle(
                        fontFamily: 'DINNext',
                        fontSize: 11.61,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.375,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Botão VER MAIS
          Positioned(
            left: 194,
            top: 79,
            child: GestureDetector(
              onTap: onViewMore,
              child: Container(
                width: 95,
                height: 25,
                decoration: BoxDecoration(
                  color: viewMoreColor,
                  borderRadius: BorderRadius.circular(16.59),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: isDarkTheme ? 0.3 : 0.15),
                      blurRadius: 28.21,
                      offset: const Offset(0, 28.21),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      viewMoreIcon,
                      width: 14,
                      height: 14,
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'VER MAIS',
                      style: TextStyle(
                        fontFamily: 'DINNext',
                        fontSize: 11.61,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        height: 1.375,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
} 