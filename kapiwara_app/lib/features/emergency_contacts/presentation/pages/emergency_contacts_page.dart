import 'package:flutter/material.dart';
import '../../domain/entities/emergency_contact_entity.dart';
import '../widgets/emergency_contact_card.dart';
import '../../../../shared/widgets/bottom_navigation_menu.dart';
import '../../../home/presentation/pages/home_screen.dart';

class EmergencyContactsPage extends StatefulWidget {
  const EmergencyContactsPage({Key? key}) : super(key: key);

  @override
  State<EmergencyContactsPage> createState() => _EmergencyContactsPageState();
}

class _EmergencyContactsPageState extends State<EmergencyContactsPage> {
  int selectedIndex = 3; // Emergency está selecionado por padrão
  
  static const List<EmergencyContactEntity> contatos = [
    EmergencyContactEntity(
      nome: '🔥 BOMBEIROS - 193',
      telefone: '193',
      tipo: 'Incêndios • Resgates • Emergências Médicas',
      imagePath: 'assets/images/emergency_contacts_screen/capivara_figma.png',
    ),
    EmergencyContactEntity(
      nome: '🆘 SAMU - 192',
      telefone: '192',
      tipo: 'Ambulância • Acidentes • Envenenamentos',
    ),
    EmergencyContactEntity(
      nome: '🪶 FUNAI  - (61) 3313-3500',
      telefone: '(61) 3313-3500',
      tipo: 'Proteção Indígena • Conflitos Territoriais',
    ),
    EmergencyContactEntity(
      nome: '🌿 IBAMA - 0800 61 8080',
      telefone: '0800 61 8080',
      tipo: 'Crimes Ambientais • Queimadas • Desmatamento',
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
    
    // Aqui você pode adicionar navegação para outras telas
    switch (index) {
      case 0:
        // Home
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
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
        // Emergency - já estamos aqui
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 400;
    final isTablet = screenWidth > 600;
    
    return Scaffold(
      backgroundColor: const Color(0xFFFFEDD3),
      body: SafeArea(
        child: Stack(
          children: [
            // Conteúdo principal
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: isSmallScreen ? 32 : 48),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: isSmallScreen ? 16 : 24),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: isSmallScreen ? 3 : 1,
                        child: Padding(
                          padding: EdgeInsets.only(top: isSmallScreen ? 30 : 50),
                          child: Text(
                            'Contatos de\nEmergência',
                            style: TextStyle(
                              fontFamily: 'DINNext',
                              fontWeight: FontWeight.w700,
                              fontSize: isSmallScreen ? 26 : (isTablet ? 40 : 34),
                              color: const Color(0xFF444444),
                              letterSpacing: 0.32,
                            ),
                            maxLines: 2,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: isSmallScreen ? 2 : 1,
                        child: Image.asset(
                          'assets/images/emergency_contacts_screen/capivara_figma.png',
                          width: isSmallScreen ? 120 : 150,
                          height: isSmallScreen ? 160 : 200,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(
                      top: isSmallScreen ? 16 : 24,
                      bottom: isSmallScreen ? 120 : 150,
                    ),
                    itemCount: contatos.length,
                    itemBuilder: (context, index) {
                      final contact = contatos[index];
                      return Padding(
                        padding: EdgeInsets.only(
                          left: isSmallScreen ? 16 : 24,
                          right: isSmallScreen ? 16 : 24,
                          bottom: isSmallScreen ? 8 : 12,
                          top: index == 0 ? 0 : (isSmallScreen ? 8 : 12),
                        ),
                        child: EmergencyContactCard(contact: contact),
                      );
                    },
                  ),
                ),
              ],
            ),
            
            // Bottom Navigation Menu Component
            BottomNavigationMenu(
              selectedIndex: selectedIndex,
              onItemTapped: _onItemTapped,
            ),
          ],
        ),
      ),
    );
  }
} 