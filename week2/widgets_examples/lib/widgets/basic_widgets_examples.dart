import 'package:flutter/material.dart';

class BasicWidgetsExamples extends StatelessWidget {
  const BasicWidgetsExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .stretch,
      children: [
        const Text(
          'Text : affiche du texte.',
          style: TextStyle(fontWeight: .w600),
        ),
        const SizedBox(height: 8),
        const Text('Bonjour Flutter', style: TextStyle(fontSize: 22)),
        const Divider(height: 32),

        const Text(
          'Row : disposition horizontale.',
          style: TextStyle(fontWeight: .w600),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: .spaceBetween,
          children: const [Text('Gauche'), Text('Centre'), Text('Droite')],
        ),
        const Divider(height: 32),

        const Text(
          'Column : disposition verticale.',
          style: TextStyle(fontWeight: .w600),
        ),
        const SizedBox(height: 8),
        Column(
          crossAxisAlignment: .start,
          children: const [
            Text('Nom : Ali'),
            SizedBox(height: 6),
            Text('Ville : Niamey'),
            SizedBox(height: 6),
            Text('Statut : En ligne'),
          ],
        ),
        const Divider(height: 32),

        const Text(
          'Container : bloc stylé (padding, marge, couleur, bordure, radius).',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const .all(12),
          margin: const .only(bottom: 8),
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade50,
            borderRadius: .circular(12),
            border: .all(),
          ),
          child: const Text('Je suis une carte via Container.'),
        ),
        const Divider(height: 32),

        const Text(
          'Align : positionner un widget dans son espace.',
          style: TextStyle(fontWeight: .w600),
        ),
        const SizedBox(height: 8),
        Container(
          height: 80,
          color: Colors.grey.shade200,
          child: const Align(
            alignment: .topRight,
            child: Padding(padding: .all(8), child: Text('Top Right')),
          ),
        ),
        const Divider(height: 32),

        const Text(
          'Expanded : partager l’espace dans un Row/Column.',
          style: TextStyle(fontWeight: .w600),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: Container(height: 40, color: Colors.red.shade200)),
            Expanded(
              child: Container(height: 40, color: Colors.green.shade200),
            ),
            Expanded(child: Container(height: 40, color: Colors.blue.shade200)),
          ],
        ),
      ],
    );
  }
}
