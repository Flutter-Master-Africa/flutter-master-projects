import 'package:flutter/material.dart';
import '../routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Widget _navCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String routeName,
    IconData icon = Icons.arrow_forward,
  }) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => Navigator.pushNamed(context, routeName),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Widgets Cookbook')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _navCard(
              context: context,
              title: 'Widget Gallery',
              subtitle:
                  'Text, Row, Column, Container, Stack, Card, ListTile, SnackBar...',
              routeName: AppRouteNames.gallery,
              icon: Icons.widgets,
            ),
            _navCard(
              context: context,
              title: 'ListView - Chat (Vertical)',
              subtitle: 'Liste verticale type messagerie',
              routeName: AppRouteNames.chat,
              icon: Icons.chat_bubble_outline,
            ),
            _navCard(
              context: context,
              title: 'ListView - Stories (Horizontal)',
              subtitle: 'Liste horizontale type stories',
              routeName: AppRouteNames.stories,
              icon: Icons.view_carousel_outlined,
            ),
          ],
        ),
      ),
    );
  }
}
