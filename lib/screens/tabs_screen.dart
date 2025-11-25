import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/projetos_provider.dart';
import './lista_projetos_screen.dart';
import './mapa_screen.dart';
import './dashboard_screen.dart';
import './aluno_screens.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [const ListaProjetosScreen(), const MapaScreen()];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProjetosProvider>(context);
    final isAluno = provider.isAluno;
    final corPrincipal = provider.corPrincipal;

    return Scaffold(
      appBar: AppBar(
        title: Text(isAluno ? 'Portal do Acadêmico' : 'Gestão de Projetos'),
        backgroundColor: corPrincipal,
        foregroundColor: Colors.white,
        actions: [
          if (!isAluno)
            IconButton(
              icon: const Icon(Icons.add_circle, size: 30),
              onPressed: () => Navigator.of(context).pushNamed('/cadastro'),
            )
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: corPrincipal,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Projetos'),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Mapa Regional'),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: corPrincipal),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(isAluno ? Icons.school : Icons.business, color: corPrincipal),
              ),
              accountName: Text(provider.nomePerfil),
              accountEmail: Text(isAluno ? "iago.artner@unidavi.edu.br" : "contato@unidavi.edu.br"),
            ),
            if (isAluno) ...[
              ListTile(
                leading: const Icon(Icons.access_time), 
                title: const Text("Minhas Horas (15h)"),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => const MinhasHorasScreen())),
              ),
              ListTile(
                leading: const Icon(Icons.verified), 
                title: const Text("Meus Certificados"),
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (ctx) => const MeusCertificadosScreen())),
              ),
            ] else ...[
              ListTile(
                leading: const Icon(Icons.people), 
                title: const Text("Voluntários Ativos"),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const DashboardScreen())),
              ),
              ListTile(
                leading: const Icon(Icons.bar_chart), 
                title: const Text("Relatórios de Impacto"),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => const DashboardScreen())),
              ),
            ],
            const Divider(),
            ListTile(
              leading: const Icon(Icons.exit_to_app, color: Colors.red),
              title: const Text("Sair"),
              onTap: () => Navigator.of(context).pushReplacementNamed('/'),
            )
          ],
        ),
      ),
    );
  }
}