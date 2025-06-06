import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../shared/themes/app_theme.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../../home/presentation/pages/home_screen.dart';

class NameConfigurationScreen extends StatefulWidget {
  const NameConfigurationScreen({super.key});

  @override
  State<NameConfigurationScreen> createState() => _NameConfigurationScreenState();
}

class _NameConfigurationScreenState extends State<NameConfigurationScreen> {
  final TextEditingController _nameController = TextEditingController();
  bool isLoading = false;
  bool _isButtonEnabled = false;
  
  @override
  void initState() {
    super.initState();
    _loadSavedName();
    _nameController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = _nameController.text.trim().isNotEmpty;
    });
  }

  Future<void> _loadSavedName() async {
    final prefs = await SharedPreferences.getInstance();
    final savedName = prefs.getString('user_name');
    if (savedName != null) {
      setState(() {
        _nameController.text = savedName;
        _isButtonEnabled = savedName.trim().isNotEmpty;
      });
    }
  }

  Future<void> _saveName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', name);
  }

  Future<void> _confirmSelection() async {
    if (_nameController.text.trim().isEmpty) return;
    
    setState(() {
      isLoading = true;
    });

    // Salvar nome do usuário
    await _saveName(_nameController.text.trim());
    
    // Simular um pequeno delay para mostrar o loading
    await Future.delayed(const Duration(milliseconds: 800));

    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  void dispose() {
    _nameController.removeListener(_updateButtonState);
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isSmallScreen = screenWidth < 400;
    final textWidth = screenWidth * (isSmallScreen ? 0.5 : 0.45);
    
    return Scaffold(
      backgroundColor: AppTheme.languageScreenBackground,
      body: SafeArea(
        child: Stack(
          children: [
            // Conteúdo principal (texto e campo de input)
            Padding(
              padding: EdgeInsets.all(isSmallScreen ? 24 : 24),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Título com espaço para as imagens
                          Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Texto "Qual o seu nome?" - responsivo
                                SizedBox(
                                  width: textWidth,
                                  child: Text(
                                    'Qual o seu\nnome?',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: 'DINNext',
                                      fontSize: isSmallScreen ? 36 : 36,
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.textPrimary,
                                      height: 1,
                                    ),
                                  ),
                                ),
                                
                                // Espaço reservado para as imagens
                                Expanded(
                                  child: SizedBox(
                                    height: isSmallScreen ? 120 : 120,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          //SizedBox(height: screenHeight * 0.04),
                          
                          // Campo de input responsivo
                          Transform.translate(
                            offset: Offset(0, isSmallScreen ? -10 : -10),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppTheme.languageCardBorder,
                                    blurRadius: 0,
                                    offset: const Offset(0, 4),
                                    spreadRadius: 0,
                                  ),
                                ],
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFBDEB5),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    width: 1,
                                    color: AppTheme.languageCardBorder,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isSmallScreen ? 16 : 20,
                                    vertical: isSmallScreen ? 6 : 16,
                                  ),
                                  child: Row(
                                    children: [
                                      // Ícone de usuário
                                      SvgPicture.asset(
                                        'assets/images/config_name_screen/account_circle.svg',
                                        width: isSmallScreen ? 20 : 24,
                                        height: isSmallScreen ? 20 : 24,
                                        colorFilter: ColorFilter.mode(
                                          AppTheme.textPrimary,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                      SizedBox(width: isSmallScreen ? 12 : 16),
                                      
                                      // Campo de texto
                                      Expanded(
                                        child: TextField(
                                          controller: _nameController,
                                          style: TextStyle(
                                            fontFamily: 'DINNext',
                                            fontSize: isSmallScreen ? 16 : 16,
                                            fontWeight: FontWeight.w400,
                                            color: AppTheme.textPrimary,
                                          ),
                                          decoration: InputDecoration(
                                            hintText: 'Digite seu nome',
                                            hintStyle: TextStyle(
                                              fontFamily: 'DINNext',
                                              fontSize: isSmallScreen ? 16 : 16,
                                              fontWeight: FontWeight.w400,
                                              color: AppTheme.textPrimary.withOpacity(0.6),
                                            ),
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.zero,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          
                          SizedBox(height: screenHeight * 0.04),
                          
                          // Botão confirmar
                          PrimaryButton(
                            text: 'CONFIRMAR',
                            width: double.infinity,
                            onPressed: _isButtonEnabled ? _confirmSelection : null,
                            isLoading: isLoading,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            
            // Container das imagens - na frente apenas delas
            Positioned(
              top: screenHeight * 0.25,
              right: isSmallScreen ? 24 : 24,
              width: screenWidth * 0.5,
              height: 180,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Menina índia - primeira posição
                  Positioned(
                    right: isSmallScreen ? 60 : 90,
                    top: -10,
                    child: Image.asset(
                      'assets/images/config_name_screen/indian_girl.png',
                      width: isSmallScreen ? 120 : 120,
                      height: isSmallScreen ? 240 : 240,
                      fit: BoxFit.contain,
                    ),
                  ),
                  
                  // Menino índio - sobrepondo 5% da menina
                  Positioned(
                    right: 0,
                    top: -10,
                    child: Image.asset(
                      'assets/images/config_name_screen/indian_boy.png',
                      width: isSmallScreen ? 120 : 120,
                      height: isSmallScreen ? 240 : 240,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
} 