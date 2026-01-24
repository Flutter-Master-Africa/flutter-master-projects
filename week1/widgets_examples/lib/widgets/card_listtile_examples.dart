import 'package:flutter/material.dart';

class CardListTileExamples extends StatelessWidget {
  const CardListTileExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blueGrey.shade400,
          child: const Text('I', style: TextStyle(color: Colors.white)),
        ),
        title: const Text('Ibrahim'),
        subtitle: const Text('Salut, tu es disponible ?'),
        trailing: Column(
          mainAxisAlignment: .center,
          children: const [
            Text('09:11', style: TextStyle(fontSize: 12)),
            SizedBox(height: 4),
            Icon(Icons.done_all, size: 16),
          ],
        ),
        onTap: () {},
      ),
    );
  }
}
