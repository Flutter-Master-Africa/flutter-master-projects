import 'package:flutter/material.dart';
import '../data/sample_data.dart';

class ListViewStoriesScreen extends StatelessWidget {
  const ListViewStoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ListView - Stories (Horizontal)')),
      body: Padding(
        padding: const .all(12),
        child: Column(
          crossAxisAlignment: .stretch,
          children: [
            const Text(
              'Stories',
              style: TextStyle(fontSize: 18, fontWeight: .bold),
            ),
            const SizedBox(height: 12),

            SizedBox(
              height: 110,
              child: ListView.separated(
                scrollDirection: .horizontal,
                itemCount: storyItems.length,
                separatorBuilder: (_, _) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final story = storyItems[index];
                  return Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 34,
                            backgroundColor: story.hasNew
                                ? Colors.blue
                                : Colors.grey,
                            child: CircleAvatar(
                              radius: 31,
                              backgroundColor: Colors.blueGrey.shade200,
                              child: Text(
                                story.name.characters.first,
                                style: const TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          if (story.hasNew)
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Container(
                                padding: const .all(4),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: .circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
                                ),
                                child: const Text(
                                  '1',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      SizedBox(
                        width: 72,
                        child: Text(
                          story.name,
                          textAlign: .center,
                          maxLines: 1,
                          overflow: .ellipsis,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),

            const SizedBox(height: 24),
            const Text(
              'Astuce : une ListView horizontale doit souvent être placée dans un SizedBox(height: ...)',
            ),
          ],
        ),
      ),
    );
  }
}
