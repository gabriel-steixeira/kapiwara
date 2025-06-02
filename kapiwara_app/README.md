# Kapiwara App

Uma aplicação mobile Flutter moderna usando arquitetura limpa com BLoC e Material Design 3.

## 🏗️ Arquitetura

Este projeto segue os princípios da **Clean Architecture** com **BLoC** para gerenciamento de estado:

```
lib/
├── main.dart                    # Ponto de entrada da aplicação
├── core/                        # Funcionalidades centrais
│   ├── constants/              # Constantes da aplicação
│   ├── errors/                 # Classes de erro/falha
│   ├── network/                # Cliente HTTP (Dio)
│   └── injection/              # Injeção de dependência
├── features/                   # Features da aplicação
│   └── [feature_name]/
│       ├── data/               # Camada de dados
│       │   ├── datasources/    # Fontes de dados (API, local)
│       │   ├── models/         # Modelos de dados
│       │   └── repositories/   # Implementação dos repositórios
│       ├── domain/             # Camada de domínio
│       │   ├── entities/       # Entidades de negócio
│       │   ├── repositories/   # Interfaces dos repositórios
│       │   └── usecases/       # Casos de uso
│       └── presentation/       # Camada de apresentação
│           ├── bloc/           # BLoC (eventos, estados, lógica)
│           ├── pages/          # Páginas/Telas
│           └── widgets/        # Widgets reutilizáveis
└── shared/                     # Recursos compartilhados
    ├── widgets/                # Widgets globais
    └── themes/                 # Temas da aplicação
```

## 🚀 Tecnologias Utilizadas

### Core
- **Flutter** - Framework de desenvolvimento mobile
- **Dart** - Linguagem de programação

### Gerenciamento de Estado
- **flutter_bloc** - Implementação do padrão BLoC
- **bloc** - Biblioteca base do BLoC

### Injeção de Dependência
- **get_it** - Service locator
- **injectable** - Geração automática de código para DI

### Networking
- **dio** - Cliente HTTP
- **json_annotation** - Anotações para serialização JSON

### Programação Funcional
- **dartz** - Either, Option e outras funcionalidades funcionais

### Navegação
- **go_router** - Roteamento declarativo

### Armazenamento Local
- **shared_preferences** - Persistência de dados simples

### Utilitários
- **equatable** - Comparação de objetos

### Desenvolvimento
- **build_runner** - Geração de código
- **json_serializable** - Serialização JSON automática
- **injectable_generator** - Gerador para injeção de dependência

### Testes
- **bloc_test** - Testes para BLoC
- **mocktail** - Mocking para testes

## 🎨 Design System

O projeto utiliza **Material Design 3** com:
- Tema claro e escuro automático
- Cores baseadas em Material You
- Componentes modernos e acessíveis
- Tipografia e espaçamentos consistentes

## 📱 Features Implementadas

### Splash Screen
- ✅ 3 animações sequenciais
- ✅ Fade in do logo "Kapiwara"
- ✅ Slide up do ícone da capivara
- ✅ Tela final com "anauê"
- ✅ Gradientes de cores personalizados
- ✅ Navegação automática

### Language Selection
- ✅ Seleção de idioma (Português/Tupi)
- ✅ Persistência com SharedPreferences
- ✅ Componentes reutilizáveis (LanguageCard, PrimaryButton)
- ✅ Design system consistente
- ✅ Validação e feedback visual
- ✅ Estado de loading

### Home
- ✅ Lista de itens com BLoC
- ✅ Pull-to-refresh
- ✅ Estados de loading, erro e vazio
- ✅ Cards com Material Design
- ✅ Tratamento de erros

## 🛠️ Como Executar

### Pré-requisitos
- Flutter SDK (versão 3.8.0 ou superior)
- Dart SDK
- Android Studio / VS Code
- Emulador ou dispositivo físico

### Instalação

1. **Clone o repositório:**
```bash
git clone <url-do-repositorio>
cd kapiwara_app
```

2. **Instale as dependências:**
```bash
flutter pub get
```

3. **Gere os arquivos de código:**
```bash
dart run build_runner build
```

4. **Execute a aplicação:**
```bash
flutter run
```

## 🧪 Testes

Para executar os testes:

```bash
# Todos os testes
flutter test

# Testes com coverage
flutter test --coverage

# Testes específicos
flutter test test/features/home/
```

## 📝 Comandos Úteis

### Geração de Código
```bash
# Gerar uma vez
dart run build_runner build

# Gerar e observar mudanças
dart run build_runner watch

# Limpar e gerar
dart run build_runner build --delete-conflicting-outputs
```

### Análise de Código
```bash
# Análise estática
flutter analyze

# Formatação
dart format .

# Verificar dependências desatualizadas
flutter pub outdated
```

## 🏛️ Padrões de Código

### BLoC Pattern
- **Events**: Ações do usuário ou sistema
- **States**: Estados da UI
- **Bloc**: Lógica de negócio e transformação de eventos em estados

### Clean Architecture
- **Entities**: Objetos de negócio puros
- **Use Cases**: Casos de uso específicos
- **Repositories**: Interfaces para acesso a dados
- **Data Sources**: Implementações concretas de acesso a dados

### Injeção de Dependência
- Use `@injectable` para classes que devem ser injetadas
- Use `@lazySingleton` para singletons
- Configure no `injection.dart`

## 🔧 Configuração da API

Edite o arquivo `lib/core/constants/app_constants.dart`:

```dart
static const String baseUrl = 'https://sua-api.com';
```

## 📚 Próximos Passos

- [ ] Implementar autenticação
- [ ] Adicionar mais features
- [ ] Implementar cache local
- [ ] Adicionar testes de integração
- [ ] Configurar CI/CD
- [ ] Adicionar analytics
- [ ] Implementar push notifications

## 🤝 Contribuição

1. Faça um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Commit suas mudanças (`git commit -m 'Add some AmazingFeature'`)
4. Push para a branch (`git push origin feature/AmazingFeature`)
5. Abra um Pull Request

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo `LICENSE` para mais detalhes.

---

**Desenvolvido com ❤️ usando Flutter e BLoC**
