import 'package:flutter/material.dart';

import '../../../../shared/themes/app_theme.dart';
import '../../../../shared/widgets/bottom_navigation_menu.dart';
import '../widgets/alert_card.dart';

class AlertsScreen extends StatefulWidget {
  const AlertsScreen({super.key});

  @override
  State<AlertsScreen> createState() => _AlertsScreenState();
}

class _AlertsScreenState extends State<AlertsScreen> {
  int selectedIndex = 0; // Alerts está no índice 0 (Home)

  bool _isDayTime() {
    final now = DateTime.now();
    final hour = now.hour;
    return hour >= 6 && hour < 18;
  }

  @override
  Widget build(BuildContext context) {
    final isDayTime = _isDayTime();
    
    final List<Map<String, dynamic>> alerts = [
      {
        'title': 'Fogo Próximo',
        'subtitle': 'Agora mesmo',
        'description': 'Fogo onde o rio faz curva',
        'borderColor': AppTheme.homeAmbientalCard,
        'icon': 'assets/images/alerts_screen/fire_icon.svg',
        'listenIcon': 'assets/images/alerts_screen/fire_listen.svg',
        'viewMoreIcon': 'assets/images/alerts_screen/fire_view_more.svg',
        'listenColor': AppTheme.homeClimateCard,
        'viewMoreColor': AppTheme.homeBiologicalCard,
      },

      {
        'title': 'Tempestade Chegando',
        'subtitle': 'Hoje, antes do sol se pôr',
        'description': 'Chuva forte antes do sol se pôr',
        'borderColor': AppTheme.homeClimateCard,
        'icon': 'assets/images/alerts_screen/storm_icon.svg',
        'listenIcon': 'assets/images/alerts_screen/storm_listen.svg',
        'viewMoreIcon': 'assets/images/alerts_screen/storm_view_more.svg',
        'listenColor': AppTheme.homeClimateCard,
        'viewMoreColor': AppTheme.homeBiologicalCard,
      },
      {
        'title': 'Surto de Malária',
        'subtitle': 'Agora mesmo',
        'description': 'Cuidado com os mosquitos',
        'borderColor': AppTheme.homeBiologicalCard,
        'icon': 'assets/images/alerts_screen/back_arrow.svg',
        'listenIcon': 'assets/images/alerts_screen/malaria_listen.svg',
        'viewMoreIcon': 'assets/images/alerts_screen/malaria_view_more.svg',
        'listenColor': AppTheme.homeClimateCard,
        'viewMoreColor': AppTheme.homeBiologicalCard,
      },
    ];

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: isDayTime ? AppTheme.alertsLightBackground : AppTheme.alertsDarkBackground,
          image: DecorationImage(
            image: AssetImage(isDayTime ? 'assets/images/alerts_screen/background.png' : 'assets/images/alerts_screen/background_night.png'),
            fit: BoxFit.contain,
            alignment: Alignment.topCenter,
          ),
        ),
        child: Stack(
          children: [
            SafeArea(
              child: Column(
                children: [
                  // Header
                  SizedBox(
                    height: 220,
                    child: Stack(
                      children: [
                        // Título
                        Positioned(
                          left: 0,
                          right: 0,
                          top: 120,
                          child: Center(
                            child: Text(
                              'Alertas',
                              style: TextStyle(
                                fontFamily: 'DINNext',
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                                color: isDayTime ? AppTheme.alertsLightTitle : AppTheme.alertsDarkTitle,
                                height: 0.85,
                                letterSpacing: 0.4,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Lista de alertas
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: isDayTime ? AppTheme.alertsLightBackground : AppTheme.alertsDarkBackground,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(58),
                          topRight: Radius.circular(58),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 39,
                          right: 39,
                          top: 50,
                          bottom: 0, // Espaço para o bottom navigation
                        ),
                        child: ListView.separated(
                          itemCount: alerts.length,
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 30),
                          itemBuilder: (context, index) {
                            final alert = alerts[index];
                            return AlertCard(
                              title: alert['title'],
                              subtitle: alert['subtitle'],
                              description: alert['description'],
                              borderColor: alert['borderColor'],
                              icon: alert['icon'],
                              listenIcon: alert['listenIcon'],
                              viewMoreIcon: alert['viewMoreIcon'],
                              listenColor: alert['listenColor'],
                              viewMoreColor: alert['viewMoreColor'],
                              isDarkTheme: !isDayTime,
                              onListen: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Reproduzindo alerta: ${alert['title']}',
                                    ),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              },
                              onViewMore: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Ver mais sobre: ${alert['title']}',
                                    ),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  // Bottom Navigation Menu Component
                  BottomNavigationMenu(selectedIndex: selectedIndex, isWeatherScreen: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
