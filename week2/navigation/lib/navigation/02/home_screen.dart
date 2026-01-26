import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'details_screen.dart';

@Preview(size: Size(400, 500))
Widget previewHome() {
  return const MaterialApp(home: HomeScreen());
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? backResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              backResult == null
                  ? 'Aucun résultat pour le moment.'
                  : 'Résultat : $backResult',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                // Étape 1: navigation simple (push)
                // Ensuite on fera: passage de données + retour de données

                final result = await Navigator.push<String>(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DetailsScreen(message: 'Produit #12'),
                  ),
                );

                if (!mounted) return;
                setState(() {
                  backResult = result ?? 'Annulé / aucun résultat';
                });
              },
              child: const Text('Aller à Details'),
            ),
          ],
        ),
      ),
    );
  }
}
