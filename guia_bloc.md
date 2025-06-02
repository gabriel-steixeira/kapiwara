# 🧠 O que é o BLoC?
BLoC é uma arquitetura baseada em streams e eventos que ajuda a separar a lógica de negócios da interface de usuário em aplicativos Flutter. Ela foi criada por desenvolvedores do Google e segue os princípios da programação reativa.

## 🔧 Conceitos principais
1. Event (Evento)
Representa ações do usuário ou do sistema (ex: clicar num botão, carregar dados).

Ex: LoginButtonPressed, FetchUserData, etc.

2. State (Estado)
Representa o que a UI deve mostrar em determinado momento.

Ex: LoginInitial, LoginLoading, LoginSuccess, LoginFailure.

3. Bloc
Um componente que recebe eventos, executa lógica de negócios e emite estados.

Usa Streams (com StreamController ou stream/sink) para escutar eventos e emitir novos estados.

## 🔄 Fluxo da arquitetura
UI envia um Event para o Bloc.

O Bloc executa a lógica (ex: chama API, faz cálculos).

O Bloc emite um novo State.

A UI escuta os estados e se reconstrói conforme necessário.

## ✅ Vantagens do BLoC
Separação clara entre lógica e UI.

Facilita testes unitários e manutenção.

Baseado em Streams e programação reativa.

## ❗Dica para Flutter moderno
Hoje, muitos projetos usam o pacote flutter_bloc, que fornece integrações com widgets como BlocProvider, BlocBuilder e BlocListener, tornando a implementação mais fácil e segura.