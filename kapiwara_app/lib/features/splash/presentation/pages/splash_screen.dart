import 'package:flutter/material.dart';

import '../../../../shared/themes/app_theme.dart';
import '../../../language_selection/presentation/pages/language_selection_screen.dart';
import '../widgets/animated_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _nameFadeController; // Novo controller para o nome na fase 2
  late Animation<double> _fadeAnimation;
  late Animation<double> _nameFadeAnimation; // Nova animação para o nome na fase 2
  late Animation<Offset> _slideAnimation;
  
  int _currentPhase = 2; // 1, 2, 3 para as três fases
  
  @override
  void initState() {
    super.initState();
    
    // Controller para fade in/out da fase 1 e 3
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    
    // Controller para slide up
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    // Controller separado para fade do nome na fase 2
    _nameFadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    // Animação de fade principal
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));
    
    // Animação de fade para o nome na fase 2
    _nameFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _nameFadeController,
      curve: Curves.easeInOut,
    ));
    
    // Animação de slide (de baixo para cima)
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutBack,
    ));
    
    _startAnimationSequence();
  }
  
  void _startAnimationSequence() async {
    // Fase 1: Mostrar nome "Kapiwara" com fade in
    // await _fadeController.forward();
    // await Future.delayed(const Duration(milliseconds: 1500));
    
    // Transição para fase 2: Fade out do nome da fase 1
    // await _fadeController.reverse();
    // setState(() {
    //   _currentPhase = 2;
    // });
    
    // Fase 2: Slide up do ícone e fade in do nome
    await Future.wait([
      _slideController.forward(),
      _nameFadeController.forward(),
    ]);
    await Future.delayed(const Duration(milliseconds: 800));
    
    // Transição para fase 3: Fade out da fase 2 e mostrar tela final
    await _nameFadeController.reverse();
    setState(() {
      _currentPhase = 3;
    });
    await _fadeController.forward();
    
    // Aguardar um pouco e navegar para home
    await Future.delayed(const Duration(milliseconds: 1500));
    
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LanguageSelectionScreen()),
      );
    }
  }
  
  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _nameFadeController.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: _getBackgroundDecoration(),
        child: _buildCurrentPhase(),
      ),
    );
  }
  
  BoxDecoration _getBackgroundDecoration() {
    switch (_currentPhase) {
      case 1:
        // Gradiente marrom terra das primeiras animações (0% #715848 → 100% #BE7E51)
        return const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.splashBrownTop,    // #715848
              AppTheme.splashBrownBottom, // #BE7E51
            ],
          ),
        );
      case 2:
        // Gradiente marrom terra da segunda animação (0% #715848 → 100% #BE7E51)
        return const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.splashBrownTop,    // #715848
              AppTheme.splashBrownBottom, // #BE7E51
            ],
          ),
        );
      case 3:
        // Gradiente verde para vermelho da animação final (0% #73C086 → 100% #E85A5A)
        return const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppTheme.splashGreenTop,  // #73C086
              AppTheme.splashRedBottom, // #E85A5A
            ],
          ),
        );
      default:
        return const BoxDecoration(color: Colors.white);
    }
  }
  
  Widget _buildCurrentPhase() {
    switch (_currentPhase) {
      case 1:
        return _buildPhase1();
      case 2:
        return _buildPhase2();
      case 3:
        return _buildPhase3();
      default:
        return const SizedBox.shrink();
    }
  }
  
  // Fase 1: Nome "Kapiwara" com fade in posicionado mais abaixo
  Widget _buildPhase1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        FadeTransition(
          opacity: _fadeAnimation,
          child: const AnimatedLogo(
            assetPath: 'assets/images/splash_screen/kapiwara_name.svg',
            width: 250,
            height: 120,
            isSvg: true,
          ),
        ),
        const SizedBox(height: 300), // Espaçamento da parte inferior da tela
      ],
    );
  }
  
  // Fase 2: Ícone da capivara 100px acima do nome
  Widget _buildPhase2() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // Ícone da capivara com slide up, 100px acima do nome
        SlideTransition(
          position: _slideAnimation,
          child: const AnimatedLogo(
            assetPath: 'assets/images/splash_screen/kapiwara_icon.png',
            width: 300,
            height: 350,
          ),
        ),
        const SizedBox(height: 10), // 100px de espaçamento entre ícone e nome
        // Nome "Kapiwara" mantido na posição inferior
        FadeTransition(
          opacity: _nameFadeAnimation,
          child: const AnimatedLogo(
            assetPath: 'assets/images/splash_screen/kapiwara_name.svg',
            width: 250,
            height: 120,
            isSvg: true,
          ),
        ),
        const SizedBox(height: 300), // Espaçamento da parte inferior da tela
      ],
    );
  }
  
  // Fase 3: Tela final com fade in
  Widget _buildPhase3() {
    return Center(
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [            
            // Texto "anauê" em branco
            const Text(
              'anauê',
              style: TextStyle(
                fontFamily: 'DINNext',
                fontSize: 64,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 2.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
} 