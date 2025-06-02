# Language Selection - Kapiwara

## 📱 Visão Geral

A tela de seleção de idioma permite ao usuário escolher entre os idiomas disponíveis no aplicativo Kapiwara. A seleção é persistida localmente usando SharedPreferences. O design utiliza um card unificado com ambos os idiomas em uma única interface.

## 🎨 Design System

### **Cores**
```dart
// Fundo da tela
AppTheme.languageScreenBackground // #FFEDD3

// Card unificado
Color(0xFFFBDEB5)                // #FBDEB5 (fundo do card)
AppTheme.languageCardBorder      // #715848 (borda e sombra)

// Textos
AppTheme.textPrimary             // #444444
AppTheme.textSecondary           // #444444 com 60% opacidade

// Botão primário
AppTheme.primaryButton           // #73C086
AppTheme.primaryButtonShadow     // #347F43
```

### **Tipografia**
- **Título:** DIN Next Bold, 32px
- **Idiomas:** DIN Next Regular, 16px
- **Botão:** DIN Next Bold, 16px
- **Texto informativo:** DIN Next Regular, 14px

### **Dimensões**
- **Card unificado:** 342x118px
- **Ícone capivara:** 150x200px
- **Ícones SVG:** 24x24px
- **Radio buttons:** 22x22px

## 🧩 Componentes

### **Card Unificado**
Design customizado com Stack e Positioned widgets:
- Fundo com cor `#FBDEB5`
- Borda arredondada (25px)
- Sombra inferior sólida
- Linha divisória entre os idiomas
- Dois idiomas em um único card

### **PrimaryButton**
Componente reutilizável para botões primários:
- Sombra inferior customizada
- Estado de loading
- Largura configurável
- Cores do tema

### **KapiwaraHeader**
Widget para exibir o ícone da capivara no header:
- Posicionamento à direita
- Tamanho 150x200px
- Caminho atualizado para nova estrutura

## 💾 Persistência de Dados

A seleção do idioma é salva usando **SharedPreferences**:

```dart
// Salvar idioma
await prefs.setString('selected_language', languageCode);

// Carregar idioma
final savedLanguage = prefs.getString('selected_language');
```

## 🌐 Idiomas Disponíveis

Atualmente suportados:
- **Português** (`pt`)
- **Tupi** (`tupi`)

## 📁 Estrutura de Arquivos

```
lib/features/language_selection/
├── presentation/
│   ├── pages/
│   │   └── language_selection_screen.dart
│   └── widgets/
│       └── kapiwara_header.dart
├── domain/
└── data/

lib/shared/widgets/
└── primary_button.dart

assets/images/
├── language_choose_screen/
│   ├── kapiwara_icon.png
│   └── user_talking.svg
└── splash_screen/
    ├── kapiwara_icon.png
    └── kapiwara_name.svg
```

## 🔄 Fluxo de Navegação

1. **Splash Screen** → **Language Selection**
2. **Language Selection** → **Home Page** (após confirmação)

## 🎯 Funcionalidades

- ✅ Card unificado com dois idiomas
- ✅ Ícones SVG para cada idioma
- ✅ Radio buttons customizados
- ✅ Feedback visual de seleção
- ✅ Persistência da escolha
- ✅ Validação (botão só ativa com seleção)
- ✅ Estado de loading durante salvamento
- ✅ Layout centralizado
- ✅ Design responsivo

## 🚀 Como Usar

A tela é automaticamente exibida após a splash screen:

```dart
// Navegação da splash screen
Navigator.of(context).pushReplacement(
  MaterialPageRoute(builder: (context) => const LanguageSelectionScreen()),
);
```

## 🎨 Assets Utilizados

- `assets/images/language_choose_screen/kapiwara_icon.png` - Ícone da capivara
- `assets/images/language_choose_screen/user_talking.svg` - Ícone do usuário falando
- `assets/images/splash_screen/kapiwara_icon.png` - Ícone da capivara (splash)
- `assets/images/splash_screen/kapiwara_name.svg` - Logo Kapiwara (splash)

## 📱 Responsividade

- Layout centralizado com `MainAxisAlignment.center`
- Card com largura fixa (342px) para consistência
- Componentes flexíveis com espaçamentos adequados
- SafeArea para respeitar notch/status bar
- Padding consistente (24px)

## 🔧 Implementação Técnica

### **Stack Layout**
O card utiliza Stack com Positioned widgets para posicionamento preciso:
- Linha divisória centralizada
- Ícones e textos alinhados
- Radio buttons posicionados à direita

### **Interatividade**
- GestureDetector em toda a área de cada idioma
- Feedback visual imediato na seleção
- Estados visuais claros (selecionado/não selecionado) 