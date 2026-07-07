import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TP4 - Accueil'),
        backgroundColor: Colors.teal,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.teal),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.apps, color: Colors.white, size: 36),
                  SizedBox(height: 8),
                  Text(
                    'Menu de navigation',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            _buildDrawerItem(
              context: context,
              icon: const Icon(Icons.home_outlined, color: Colors.teal),
              itemTitle: 'Accueil',
              route: '/',
            ),
            const Divider(height: 1),
            _buildDrawerItem(
              context: context,
              icon: const Icon(Icons.exposure, color: Colors.teal),
              itemTitle: 'Compteur',
              route: '/counter',
            ),
          ],
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.waving_hand, size: 48, color: Colors.teal),
              const SizedBox(height: 16),
              const Text(
                'Bienvenue sur la page d\'accueil du TP4.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              Text(
                'Ouvrez le menu latéral pour accéder au compteur.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem({
    required BuildContext context,
    required Icon icon,
    required String itemTitle,
    required String route,
  }) {
    return ListTile(
      leading: icon,
      title: Text(
        itemTitle,
        style: const TextStyle(fontSize: 16, color: Colors.teal),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.teal),
      onTap: () {
        Navigator.pop(context);
        if (ModalRoute.of(context)?.settings.name != route) {
          Navigator.pushNamed(context, route);
        }
      },
    );
  }
}
