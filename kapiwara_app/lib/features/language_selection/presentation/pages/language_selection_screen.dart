import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../shared/themes/app_theme.dart';
import '../../../../shared/widgets/primary_button.dart';
import '../../../name_configuration/presentation/pages/name_configuration_screen.dart';
import '../widgets/kapiwara_header.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  State<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String? selectedLanguage;
  bool isLoading = false;
  
  final List<Map<String, String>> languages = [
    {'name': 'Português', 'code': 'pt'},
    {'name': 'Guarani', 'code': 'Guarani'},
  ];

  @override
  void initState() {
    super.initState();
    _loadSelectedLanguage();
  }

  Future<void> _loadSelectedLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    final savedLanguage = prefs.getString('selected_language');
    if (savedLanguage != null) {
      setState(() {
        selectedLanguage = savedLanguage;
      });
    }
  }

  Future<void> _saveLanguage(String languageCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_language', languageCode);
  }

  void _selectLanguage(String languageCode) {
    setState(() {
      selectedLanguage = languageCode;
    });
  }

  Future<void> _confirmSelection() async {
    if (selectedLanguage == null) return;
    
    setState(() {
      isLoading = true;
    });

    // Salvar idioma selecionado
    await _saveLanguage(selectedLanguage!);
    
    // Simular um pequeno delay para mostrar o loading
    await Future.delayed(const Duration(milliseconds: 800));

    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const NameConfigurationScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.languageScreenBackground,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [                
                // Título com ícone da capivara
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Escolha\nseu idioma',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: 'DINNext',
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.textPrimary,
                          height: 1.2,
                        ),
                      ),
                      // Header com ícone da capivara
                      const KapiwaraHeader(),                  
                    ],
                  ),
                ),
                
                // Card unificado com os dois idiomas - posição relativa -20px
                Transform.translate(
                  offset: const Offset(0, -50),
                  child: Container(
                    width: double.infinity,
                    height: 118,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
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
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          width: 1,
                          color: AppTheme.languageCardBorder,
                        ),
                      ),
                      child: Stack(
                        children: [
                          // Linha divisória
                          Positioned(
                            left: 0,
                            top: 59,
                            child: Container(
                              width: 450,
                              height: 1,
                              color: AppTheme.languageCardBorder,
                            ),
                          ),
                          
                          // Português - Primeira opção
                          Positioned(
                            left: 20,
                            top: 20,
                            child: GestureDetector(
                              onTap: () => _selectLanguage('pt'),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/language_choose_screen/user_talking.svg',
                                    width: 24,
                                    height: 24,
                                    colorFilter: ColorFilter.mode(
                                      AppTheme.textPrimary,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Text(
                                    'Português',
                                    style: TextStyle(
                                      color: AppTheme.textPrimary,
                                      fontSize: 16,
                                      fontFamily: 'DINNext',
                                      fontWeight: FontWeight.w400,
                                      height: 1.25,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          
                          // Radio button Português
                          Positioned(
                            left: 400,
                            top: 20,
                            child: GestureDetector(
                              onTap: () => _selectLanguage('pt'),
                              child: Container(
                                width: 22,
                                height: 22,
                                decoration: BoxDecoration(
                                  color: selectedLanguage == 'pt' 
                                      ? AppTheme.primaryButton 
                                      : Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 1,
                                    color: AppTheme.textPrimary,
                                  ),
                                ),
                                child: selectedLanguage == 'pt'
                                    ? const Icon(
                                        Icons.check,
                                        size: 14,
                                        color: Colors.white,
                                      )
                                    : null,
                              ),
                            ),
                          ),
                          
                          // Guarani - Segunda opção
                          Positioned(
                            left: 20,
                            top: 73,
                            child: GestureDetector(
                              onTap: () => _selectLanguage('Guarani'),
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/language_choose_screen/user_talking.svg',
                                    width: 24,
                                    height: 24,
                                    colorFilter: ColorFilter.mode(
                                      AppTheme.textPrimary,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  const SizedBox(width: 20),
                                  Text(
                                    'Guarani',
                                    style: TextStyle(
                                      color: AppTheme.textPrimary,
                                      fontSize: 16,
                                      fontFamily: 'DINNext',
                                      fontWeight: FontWeight.w400,
                                      height: 1.25,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          
                          // Radio button Guarani
                          Positioned(
                            left: 400,
                            top: 73,
                            child: GestureDetector(
                              onTap: () => _selectLanguage('Guarani'),
                              child: Container(
                                width: 22,
                                height: 22,
                                decoration: BoxDecoration(
                                  color: selectedLanguage == 'Guarani' 
                                      ? AppTheme.primaryButton 
                                      : Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 1,
                                    color: AppTheme.textPrimary,
                                  ),
                                ),
                                child: selectedLanguage == 'Guarani'
                                    ? const Icon(
                                        Icons.check,
                                        size: 14,
                                        color: Colors.white,
                                      )
                                    : null,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                
                // Espaçamento ajustado para compensar o offset
                const SizedBox(height: 20),
                
                // Botão confirmar
                PrimaryButton(
                  text: 'CONFIRMAR',
                  width: double.infinity,
                  onPressed: selectedLanguage != null ? _confirmSelection : null,
                  isLoading: isLoading,
                ),
                
                const SizedBox(height: 40),
                
                // Texto informativo
                SizedBox(
                  width: 450,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        fontFamily: 'DINNext',
                        fontSize: 18,
                        color: AppTheme.textSecondary,
                        height: 1.4,
                      ),
                      children: [
                        const TextSpan(text: 'Novos idiomas indígenas em breve. Nosso\nobjetivo é '),
                        TextSpan(
                          text: 'preservar',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                        const TextSpan(text: ' e '),
                        TextSpan(
                          text: 'valorizar',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.textSecondary,
                          ),
                        ),
                        const TextSpan(text: ' a diversidade\nlinguística do Brasil.'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
} 