# Splash Screen - Kapiwara

## 📱 Visão Geral

A splash screen do Kapiwara é composta por **3 animações sequenciais** que criam uma experiência de entrada envolvente e culturalmente significativa.

## 🎬 Sequência de Animações

### **Fase 1: Nome "Kapiwara"**
- **Duração:** 2.3 segundos
- **Animação:** Fade in do logo SVG com o nome "Kapiwara"
- **Background:** Gradiente marrom terra (#715848 → #BE7E51)
- **Asset:** `kapiwara_name.svg`

### **Fase 2: Ícone da Capivara**
- **Duração:** 1.8 segundos
- **Animação:** Slide up (de baixo para cima) do ícone da capivara
- **Background:** Mesmo gradiente marrom terra (#715848 → #BE7E51)
- **Asset:** `kapiwara_icon.png`
- **Efeito:** `Curves.easeOutBack` para um movimento mais natural

### **Fase 3: Tela Final**
- **Duração:** 1.5 segundos
- **Animação:** Fade in da composição final
- **Background:** Gradiente verde para vermelho (#73C086 → #E85A5A)
- **Elementos:**
  - Ícone da capivara (menor)
  - Texto "anauê" em branco
  - Indicador de carregamento sutil

## 🎨 Design System

### **Cores**
```dart
// Fases 1 e 2 - Gradiente Marrom Terra
AppTheme.splashBrownTop    // #715848
AppTheme.splashBrownBottom // #BE7E51

// Fase 3 - Gradiente Verde para Vermelho
AppTheme.splashGreenTop  // #73C086
AppTheme.splashRedBottom // #E85A5A
```

### **Tipografia**
- **Fonte:** DIN Next Bold
- **Tamanho:** 36px
- **Cor:** Branco
- **Letter Spacing:** 2.0

### **Dimensões**
- **Logo Nome:** 250x120px
- **Ícone Fase 2:** 300x350px
- **Ícone Fase 3:** Removido (apenas texto "anauê")

## 🔧 Implementação Técnica

### **Controllers de Animação**
- `_fadeController`: Controla fade in/out (800ms)
- `_slideController`: Controla slide up (1000ms)

### **Widgets Utilizados**
- `FadeTransition`: Para efeitos de fade
- `SlideTransition`: Para movimento de baixo para cima
- `AnimatedLogo`: Widget customizado para renderizar SVG/PNG

### **Navegação**
Após completar todas as animações, navega automaticamente para `HomePage` usando `Navigator.pushReplacement`.

## 📁 Estrutura de Arquivos

```
lib/features/splash/
├── presentation/
│   ├── pages/
│   │   └── splash_screen.dart
│   └── widgets/
│       └── animated_logo.dart
├── domain/
└── data/
```

## 🎯 Significado Cultural

- **"anauê"**: Saudação tradicional indígena que significa "olá" ou "paz"
- **Capivara**: Animal símbolo do projeto, representando a conexão com a natureza
- **Cores terra**: Representam a conexão com a terra e tradições ancestrais
- **Verde final**: Simboliza esperança, natureza e sustentabilidade

## 🚀 Como Usar

A splash screen é automaticamente exibida como primeira tela da aplicação:

```dart
// main.dart
home: const SplashScreen(),
```

A transição para a tela principal acontece automaticamente após ~5.6 segundos total.

## ⚡ Performance

- **Assets otimizados**: SVG para vetores, PNG comprimido para raster
- **Animações fluidas**: 60 FPS com controllers nativos do Flutter
- **Memória eficiente**: Dispose automático dos controllers
- **Responsivo**: Adapta-se a diferentes tamanhos de tela 