import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final String message;

  const DetailsScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Produit reçu: $message', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Retour simple : pas de résultat envoyé
                Navigator.pop(context);
              },
              child: const Text('Retour simple (pop)'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                // Retour avec résultat : on renvoie une valeur à Home
                Navigator.pop(context, message);
              },
              child: const Text('Retour avec résultat'),
            ),
          ],
        ),
      ),
    );
  }
}
