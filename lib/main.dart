import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './providers/projetos_provider.dart';
import './screens/login_screen.dart';
import './screens/tabs_screen.dart';
import './screens/cadastro_screen.dart';

void main() {
  runApp(const VoluntaRiosApp());
}

class VoluntaRiosApp extends StatelessWidget {
  const VoluntaRiosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => ProjetosProvider()),
      ],
      child: MaterialApp(
        // AQUI ESTÁ O SEGREDO DA ABA DO CHROME:
        title: 'VoluntaRIO', 
        
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // Definindo a cor base como o Verde Unidavi para começar
          primaryColor: const Color(0xFF004D40),
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF004D40)),
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.grey[50],
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF004D40),
            foregroundColor: Colors.white,
            centerTitle: true,
            elevation: 2,
          ),
        ),
        // Rotas
        routes: {
          '/': (ctx) => const LoginScreen(),
          '/home': (ctx) => const TabsScreen(),
          '/cadastro': (ctx) => const CadastroScreen(),
        },
      ),
    );
  }
}