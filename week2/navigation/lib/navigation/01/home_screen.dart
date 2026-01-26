import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'details_screen.dart';

@Preview(size: Size(400, 500))
Widget previewHome01() {
  return const MaterialApp(home: HomeScreen());
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Navigation simple sans données.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DetailsScreen(),
                  ),
                );
              },
              child: const Text('Aller à Details'),
            ),
          ],
        ),
      ),
    );
  }
}
