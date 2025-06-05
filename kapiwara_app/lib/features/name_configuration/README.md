# Name Configuration - Kapiwara

## 📱 Visão Geral

A tela de configuração de nome permite ao usuário inserir seu nome que será usado no aplicativo Kapiwara. O nome é persistido localmente usando SharedPreferences. O design apresenta personagens índios (menina e menino) junto com o título e um campo de input customizado.

## 🎨 Design System

### **Cores**
```dart
// Fundo da tela
AppTheme.languageScreenBackground // #FFEDD3

// Campo de input
Color(0xFFFBDEB5)                // #FBDEB5 (fundo do campo)
AppTheme.languageCardBorder      // #715848 (borda e sombra)

// Textos
AppTheme.textPrimary             // #444444
AppTheme.textSecondary           // #444444 com 60% opacidade

// Botão primário
AppTheme.primaryButton           // #73C086
AppTheme.primaryButtonShadow     // #347F43
```

### **Tipografia**
- **Título:** DIN Next Bold, 48px
- **Input:** DIN Next Regular, 16px
- **Botão:** DIN Next Bold, 16px
- **Placeholder:** DIN Next Regular, 16px

### **Dimensões**
- **Campo de input:** Largura total, altura auto
- **Personagens índios:** 90x120px cada
- **Ícone SVG:** 20x20px
- **Texto título:** 45% da largura da tela
- **Área dos personagens:** 55% da largura da tela

## 🧩 Componentes

### **Layout Principal**
- **Título:** "Qual o seu nome?" ocupando 45% da largura da tela
- **Personagens:** Menina e menino índio ocupando 55% restante
- **Sobreposição:** Menino sobrepõe 5% da menina
- **Campo de input:** Largura total com ícone de usuário
- **Botão:** PrimaryButton reutilizável

### **Campo de Input Customizado**
Design customizado com:
- Fundo com cor `#FBDEB5`
- Borda arredondada (25px)
- Sombra inferior sólida
- Ícone SVG de usuário como prefixIcon
- Placeholder "Nome"

### **PrimaryButton**
Componente reutilizável para botões primários:
- Sombra inferior customizada
- Estado de loading
- Largura configurável
- Habilitado/desabilitado dinamicamente

### **Personagens Índios**
Stack layout para posicionamento:
- Menina índia posicionada primeiro
- Menino índio sobrepondo 5% da menina
- Altura fixa de 120px
- Largura de 90px cada

## 💾 Persistência de Dados

O nome do usuário é salvo usando **SharedPreferences**:

```dart
// Salvar nome
await prefs.setString('user_name', name);

// Carregar nome
final savedName = prefs.getString('user_name');
```

## 📁 Estrutura de Arquivos

```
lib/features/name_configuration/
├── presentation/
│   ├── pages/
│   │   ├── name_configuration_screen.dart
│   │   └── pages.dart
│   └── widgets/
├── domain/
└── data/

lib/shared/widgets/
└── primary_button.dart

assets/images/config_name_screen/
├── indian_girl.png
├── indian_boy.png
└── account_circle.svg
```

## 🔄 Fluxo de Navegação

1. **Language Selection** → **Name Configuration**
2. **Name Configuration** → **Home Page** (após confirmação)

## 🎯 Funcionalidades

- ✅ Layout responsivo com porcentagens da tela
- ✅ Personagens índios posicionados com Stack
- ✅ Campo de input customizado com ícone
- ✅ Validação em tempo real do input
- ✅ Botão habilitado/desabilitado dinamicamente
- ✅ Persistência do nome digitado
- ✅ Estado de loading durante salvamento
- ✅ Carregamento de nome salvo anteriormente
- ✅ Layout centralizado
- ✅ Design responsivo

## 🚀 Como Usar

A tela é exibida após a seleção de idioma:

```dart
// Navegação da language selection
Navigator.of(context).pushReplacement(
  MaterialPageRoute(builder: (context) => const NameConfigurationScreen()),
);
```

## 🎨 Assets Utilizados

- `assets/images/config_name_screen/indian_girl.png` - Personagem menina índia
- `assets/images/config_name_screen/indian_boy.png` - Personagem menino índio
- `assets/images/config_name_screen/account_circle.svg` - Ícone de usuário para o input

## 📱 Responsividade

- Layout responsivo baseado na largura da tela
- Texto do título: 45% da largura
- Área dos personagens: 55% da largura restante
- SafeArea para respeitar notch/status bar
- Padding consistente (24px)
- MediaQuery para cálculos dinâmicos

## 🔧 Implementação Técnica

### **Layout Responsivo**
```dart
final screenWidth = MediaQuery.of(context).size.width;
final textWidth = screenWidth * 0.45;
```

### **Stack para Personagens**
```dart
Stack(
  clipBehavior: Clip.none,
  children: [
    // Menina índia - posicionada primeiro
    Positioned(left: 20, ...),
    // Menino índio - sobrepondo 5% da menina
    Positioned(left: 65, ...),
  ],
)
```

### **Gerenciamento de Estado**
- TextEditingController para o campo de input
- Listener para atualização dinâmica do botão
- Estado de loading durante operações assíncronas
- Validação em tempo real do input

### **Interatividade**
- Botão habilitado apenas quando há texto válido
- Feedback visual imediato na digitação
- Estados visuais claros (habilitado/desabilitado)
- Loading state durante salvamento 