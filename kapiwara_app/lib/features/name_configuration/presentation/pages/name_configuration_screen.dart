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
    final textWidth = screenWidth * 0.45;
    
    return Scaffold(
      backgroundColor: AppTheme.languageScreenBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Título com personagens índios
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Texto "Qual o seu nome?" - 45% da tela
                      SizedBox(
                        width: textWidth,
                        child: Text(
                          'Qual o seu\nnome?',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontFamily: 'DINNext',
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textPrimary,
                            height: 1,
                          ),
                        ),
                      ),
                      
                      // Container para as imagens - 55% restante
                      Expanded(
                        child: SizedBox(
                          height: 120,
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              // Menina índia - posicionada primeiro
                              Positioned(
                                left: -80,
                                top: -120,
                                child: Image.asset(
                                  'assets/images/config_name_screen/indian_girl.png',
                                  width: 240,
                                  height: 300,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              
                              // Menino índio - sobrepondo 5% da menina
                              Positioned(
                                left: 10,
                                top: -120,
                                child: Image.asset(
                                  'assets/images/config_name_screen/indian_boy.png',
                                  width: 240,
                                  height: 300,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Campo de input sobrepondo 5% da seção acima
                Transform.translate(
                  offset: const Offset(0, -10),
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
                      child: TextField(
                        controller: _nameController,
                        style: TextStyle(
                          color: AppTheme.textPrimary,
                          fontSize: 16,
                          fontFamily: 'DINNext',
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Nome',
                          hintStyle: TextStyle(
                            color: AppTheme.textSecondary,
                            fontSize: 16,
                            fontFamily: 'DINNext',
                            fontWeight: FontWeight.w400,
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12),
                            child: SvgPicture.asset(
                              'assets/images/config_name_screen/account_circle.svg',
                              width: 20,
                              height: 20,
                              colorFilter: ColorFilter.mode(
                                AppTheme.textPrimary,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                
                // Espaçamento ajustado para compensar o offset
                const SizedBox(height: 40),
                
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
        ),
      ),
    );
  }
} 