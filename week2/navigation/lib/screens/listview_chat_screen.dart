import 'package:flutter/material.dart';
import '../data/sample_data.dart';

class ListViewChatScreen extends StatelessWidget {
  const ListViewChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ListView - Chat (Vertical)')),
      body: ListView.separated(
        padding: const .all(12),
        itemCount: chatItems.length,
        separatorBuilder: (_, _) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final item = chatItems[index];
          return Card(
            child: ListTile(
              leading: Stack(
                clipBehavior: .none,
                children: [
                  CircleAvatar(child: Text(item.name.characters.first)),
                  if (item.online)
                    Positioned(
                      bottom: -1,
                      right: -1,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          shape: .circle,
                          color: Colors.green,
                          border: .all(color: Colors.white, width: 2),
                        ),
                      ),
                    ),
                ],
              ),
              title: Text(item.name),
              subtitle: Text(item.message, maxLines: 1, overflow: .ellipsis),
              trailing: Text(item.time, style: const TextStyle(fontSize: 12)),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Ouvrir conversation avec ${item.name}'),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
