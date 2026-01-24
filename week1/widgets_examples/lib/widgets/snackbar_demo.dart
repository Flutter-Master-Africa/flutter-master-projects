import 'package:flutter/material.dart';

class SnackBarDemo extends StatelessWidget {
  const SnackBarDemo({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Action réussie')));
      },
      child: const Text('Afficher SnackBar'),
    );
  }
}
