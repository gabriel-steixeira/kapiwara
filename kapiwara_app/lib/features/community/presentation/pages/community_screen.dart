import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../shared/themes/app_theme.dart';
import '../../../../shared/widgets/bottom_navigation_menu.dart';
import '../../../alerts/presentation/pages/alerts_screen.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  int selectedIndex = 2; // Community está selecionado
  bool isLikedPost1 = false;
  bool isLikedPost2 = false;
  int likesPost1 = 23;
  int likesPost2 = 23;
  bool isAldeiaSelected = false; // Estado para controlar Feed/Aldeia

  void _toggleLike(int postIndex) {
    setState(() {
      if (postIndex == 1) {
        isLikedPost1 = !isLikedPost1;
        likesPost1 += isLikedPost1 ? 1 : -1;
      } else {
        isLikedPost2 = !isLikedPost2;
        likesPost2 += isLikedPost2 ? 1 : -1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.languageScreenBackground, // #FFEDD3
      body: Stack(
        children: [
          SafeArea(
            child: Column(
              children: [
                // Header com botão voltar, título e ícones
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    children: [
                      // Primeira linha: botão voltar, avatar e ícone mapa
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
               
                          // Avatar do usuário
                          Container(
                            width: 62,
                            height: 62,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: const DecorationImage(
                                image: AssetImage('assets/images/community_screen/user_avatar.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          
                          // Ícone de notificação
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) => const AlertsScreen()),
                              );
                            },
                            child: SvgPicture.asset(
                              'assets/images/community_screen/notification_red.svg',
                              width: 40,
                              height: 40,
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Título "Comunidade"
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Comunidade',
                          style: TextStyle(
                            fontFamily: 'DINNext',
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.textPrimary,
                            height: 0.83,
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 18),
                      
                      // Navegação Feed/Aldeia
                      Column(
                        children: [
                          Row(
                            children: [
                              // Feed
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isAldeiaSelected = false;
                                  });
                                },
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/community_screen/messages_icon.svg',
                                      width: 15,
                                      height: 15,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      'Feed',
                                      style: TextStyle(
                                        fontFamily: 'DINNext',
                                        fontSize: 16,
                                        fontWeight: !isAldeiaSelected ? FontWeight.w700 : FontWeight.w400,
                                        color: AppTheme.textPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                              const SizedBox(width: 57),
                              
                              // Aldeia
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isAldeiaSelected = true;
                                  });
                                },
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/community_screen/users_icon.svg',
                                      width: 15,
                                      height: 15,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      'Aldeia',
                                      style: TextStyle(
                                        fontFamily: 'DINNext',
                                        fontSize: 16,
                                        fontWeight: isAldeiaSelected ? FontWeight.w700 : FontWeight.w400,
                                        color: AppTheme.textPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          
                          const SizedBox(height: 24),
                          
                          // Stack para linha divisória e indicador
                          Stack(
                            children: [
                              // Linha divisória principal
                              SvgPicture.asset(
                                'assets/images/community_screen/main_divider.svg',
                                width: 342,
                                height: 2,
                              ),
                              
                              // Indicador de seleção
                              if (!isAldeiaSelected)
                                Positioned(
                                  left: 0, // Posição do Feed baseada no Figma
                                  child: SvgPicture.asset(
                                    'assets/images/community_screen/tab_indicator.svg',
                                    width: 81,
                                    height: 2,
                                  ),
                                ),
                              
                              if (isAldeiaSelected)
                                Positioned(
                                  left: 98, // Posição da Aldeia baseada no Figma
                                  child: SvgPicture.asset(
                                    'assets/images/community_screen/tab_indicator.svg',
                                    width: 81,
                                    height: 2,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                      
                      //const SizedBox(height: 15),
                    ],
                  ),
                ),
                
                // Conteúdo dinâmico baseado na seleção Feed/Aldeia
                Expanded(
                  child: isAldeiaSelected ? _buildAldeiaContent() : _buildFeedContent(),
                ),
                // Bottom Navigation Menu
                BottomNavigationMenu(
                  selectedIndex: selectedIndex,
                ),
              ],
            ),
          ),
          
        ],
      ),
    );
  }

  Widget _buildFeedContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          //const SizedBox(height: 8),
          
          // Botão "COMPARTILHAR COM A COMUNIDADE" - apenas no Feed
          Container(
            width: 342,
            height: 48,
            decoration: BoxDecoration(
              color: AppTheme.primaryButton, // #73C086
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.primaryButton,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryButtonShadow, // #347F43
                  offset: const Offset(0, 4),
                  blurRadius: 0,
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  // Implementar funcionalidade de compartilhamento
                },
                borderRadius: BorderRadius.circular(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/community_screen/share_icon.svg',
                      width: 14,
                      height: 14,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'COMPARTILHAR COM A COMUNIDADE',
                      style: TextStyle(
                        fontFamily: 'DINNext',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            offset: const Offset(0, 1),
                            blurRadius: 14.5,
                            color: Colors.black.withValues(alpha: 0.25),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Post 1 - Caê
          Container(
            width: 342,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8EA), // #FFF8EA
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.textPrimary.withValues(alpha: 0.25),
                  offset: const Offset(0, 4),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(17),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header do post
                  Row(
                    children: [
                      // Avatar Caê
                      Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: const DecorationImage(
                            image: AssetImage('assets/images/community_screen/cae_avatar.png'),
                            fit: BoxFit.cover,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.25),
                              offset: const Offset(0, -273),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Caê',
                        style: TextStyle(
                          fontFamily: 'DINNext',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textPrimary,
                          height: 2.875,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Imagem do post
                  Container(
                    width: 310,
                    height: 154,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/community_screen/post_image.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Ações do post
                  Row(
                    children: [
                      // Like
                      GestureDetector(
                        onTap: () => _toggleLike(1),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/community_screen/like_icon.svg',
                              width: 15.6,
                              height: 15,
                              colorFilter: ColorFilter.mode(
                                isLikedPost1 ? AppTheme.primaryButton : AppTheme.textPrimary,
                                BlendMode.srcIn,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '$likesPost1',
                              style: TextStyle(
                                fontFamily: 'DINNext',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF524034),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(width: 40),
                      
                      // Comentários
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/community_screen/like_icon.svg', // Usando como placeholder
                            width: 15.6,
                            height: 15,
                            colorFilter: const ColorFilter.mode(
                              AppTheme.textPrimary,
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '23',
                            style: TextStyle(
                              fontFamily: 'DINNext',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF524034),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 20),
          
          // Post 2 - Potira
          Container(
            width: 342,
            decoration: BoxDecoration(
              color: const Color(0xFFFFF8EA), // #FFF8EA
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.textPrimary.withValues(alpha: 0.25),
                  offset: const Offset(0, 4),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(17),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header do post
                  Row(
                    children: [
                      // Avatar Potira
                      Container(
                        width: 35,
                        height: 35,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/images/community_screen/potira_avatar.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Potira',
                        style: TextStyle(
                          fontFamily: 'DINNext',
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textPrimary,
                          height: 2.875,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Card de comentário
                  Container(
                    width: 310,
                    height: 45,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFEDCC), // #FFEDCC
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Linha divisória (placeholder)
                          SvgPicture.asset(
                            'assets/images/community_screen/divider_line.svg',
                            width: 208,
                            height: 1,
                          ),
                          // Timestamp
                          Text(
                            '14s',
                            style: TextStyle(
                              fontFamily: 'DINNext',
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF524034),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Ações do post
                  Row(
                    children: [
                      // Like
                      GestureDetector(
                        onTap: () => _toggleLike(2),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/community_screen/like_icon.svg',
                              width: 15.6,
                              height: 15,
                              colorFilter: ColorFilter.mode(
                                isLikedPost2 ? AppTheme.primaryButton : AppTheme.textPrimary,
                                BlendMode.srcIn,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              '$likesPost2',
                              style: TextStyle(
                                fontFamily: 'DINNext',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF524034),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      const SizedBox(width: 40),
                      
                      // Comentários
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/images/community_screen/like_icon.svg', // Usando como placeholder
                            width: 15.6,
                            height: 15,
                            colorFilter: const ColorFilter.mode(
                              AppTheme.textPrimary,
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '23',
                            style: TextStyle(
                              fontFamily: 'DINNext',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF524034),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          
          // Espaçamento para o bottom menu
          const SizedBox(height: 150),
        ],
      ),
    );
  }

  Widget _buildAldeiaContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 8),
          
          // Grid de avatares da aldeia
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 32,
              mainAxisSpacing: 30,
              childAspectRatio: 154 / 192, // Proporção baseada no Figma
              children: [
                // Taina
                _buildAldeiaCard(
                  'assets/images/community_screen/taina_avatar.png',
                  'Taina',
                ),
                
                // Caê
                _buildAldeiaCard(
                  'assets/images/community_screen/cae_avatar_aldeia.png',
                  'Caê',
                ),
                
                // Potira
                _buildAldeiaCard(
                  'assets/images/community_screen/potira_avatar_aldeia.png',
                  'Potira',
                ),
                
                // Jaci
                _buildAldeiaCard(
                  'assets/images/community_screen/jaci_avatar.png',
                  'Jaci',
                ),
              ],
            ),
          ),
          
          // Espaçamento para o bottom menu
          //const SizedBox(height: 150),
        ],
      ),
    );
  }

  Widget _buildAldeiaCard(String imagePath, String name) {
    return Column(
      children: [
        // Avatar card
        Expanded(
          child: Container(
            width: 154,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22.39),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        
        const SizedBox(height: 8),
        
        // Nome
        Text(
          name,
          style: TextStyle(
            fontFamily: 'DINNext',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppTheme.textPrimary,
            height: 2.875,
          ),
        ),
      ],
    );
  }
}