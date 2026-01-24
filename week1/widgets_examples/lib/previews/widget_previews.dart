import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';

@Preview(name: 'GALERIE - Widgets', size: Size(390, 900))
Widget previewWidgetsGallery() {
  return MaterialApp(
    themeMode: ThemeMode.light,
    theme: ThemeData(useMaterial3: true),
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(title: const Text('Galerie Widgets')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SectionTitle('Widget Text'),
          _TextExamples(),
          _SectionDivider(),

          _SectionTitle('Widget Row'),
          _RowExamples(),
          _SectionDivider(),

          _SectionTitle('Widget Column'),
          _ColumnExamples(),
          _SectionDivider(),

          _SectionTitle('Widget Container + Padding/Margin'),
          _ContainerExamples(),
          _SectionDivider(),

          _SectionTitle('Align'),
          _AlignExamples(),
          _SectionDivider(),

          _SectionTitle('Expanded / Flexible'),
          _ExpandedExamples(),
          _SectionDivider(),

          _SectionTitle('Stack (avatar + badge)'),
          _StackAvatarBadgeExample(),
          _SectionDivider(),

          _SectionTitle('Card + ListTile (conversation)'),
          _ConversationCardExample(),
          _SectionDivider(),

          _SectionTitle('ListView - Composants réutilisables'),
          _ListViewItemExamples(),
          _SectionDivider(),

          _SectionTitle('SnackBar (interaction)'),
          _SnackBarExamples(),
        ],
      ),
    ),
  );
}

@Preview(name: 'GALERIE', size: Size(390, 900))
Widget previewScreensGallery() {
  return MaterialApp(
    themeMode: ThemeMode.light,
    theme: ThemeData(
      useMaterial3: true,
      cardTheme: const CardThemeData(color: Colors.white),
    ),
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(title: const Text('Galerie')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          _SectionTitle('Écran - Messages (liste chat)'),
          _ScreenFrame(child: _MessagesScreenMock()),
          _SectionDivider(),

          _SectionTitle('Écran - Stories (liste horizontale)'),
          _ScreenFrame(child: _StoriesScreenMock()),
          _SectionDivider(),

          _SectionTitle('Écran - Démo SnackBar'),
          _ScreenFrame(child: _SnackBarScreenMock()),
        ],
      ),
    ),
  );
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}

class _SectionDivider extends StatelessWidget {
  const _SectionDivider();

  @override
  Widget build(BuildContext context) => const Padding(
    padding: EdgeInsets.symmetric(vertical: 16),
    child: Divider(height: 1),
  );
}

/// Cadre pour simuler un écran dans la galerie
class _ScreenFrame extends StatelessWidget {
  final Widget child;
  const _ScreenFrame({required this.child});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 9 / 16,
      child: ClipRRect(
        borderRadius: .circular(16),
        child: DecoratedBox(
          decoration: BoxDecoration(border: .all()),
          child: child,
        ),
      ),
    );
  }
}

class _TextExamples extends StatelessWidget {
  const _TextExamples();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text('Texte simple'),
        SizedBox(height: 8),
        Text(
          'Titre en gras',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text('Texte en italic', style: TextStyle(fontStyle: .italic)),
        SizedBox(height: 8),
        Text(
          'Texte en baré',
          style: TextStyle(decoration: TextDecoration.lineThrough),
        ),
        SizedBox(height: 8),
        Text(
          'Texte souligné, de couleur bleu',
          style: TextStyle(
            decoration: TextDecoration.underline,
            color: Colors.blue,
          ),
        ),
      ],
    );
  }
}

class _RowExamples extends StatelessWidget {
  const _RowExamples();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Row avec espace entre éléments :'),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [Text('Gauche'), Text('Centre'), Text('Droite')],
        ),
        const SizedBox(height: 12),
        const Text('Row avec icône + texte :'),
        const SizedBox(height: 8),
        Row(
          children: const [
            Icon(Icons.info_outline),
            SizedBox(width: 8),
            Text('Information'),
          ],
        ),
      ],
    );
  }
}

class _ColumnExamples extends StatelessWidget {
  const _ColumnExamples();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text('Nom : Ali'),
        SizedBox(height: 6),
        Text('Ville : Niamey'),
        SizedBox(height: 6),
        Text('Statut : En ligne'),
      ],
    );
  }
}

class _ContainerExamples extends StatelessWidget {
  const _ContainerExamples();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade50,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(),
          ),
          child: const Text('Container stylé (padding + radius + border)'),
        ),
        Container(
          color: Colors.grey.shade300,
          child: Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            color: Colors.orange.shade200,
            child: const Text('Marge (extérieur) + Padding (intérieur)'),
          ),
        ),
      ],
    );
  }
}

class _AlignExamples extends StatelessWidget {
  const _AlignExamples();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      color: Colors.grey.shade200,
      child: const Align(
        alignment: Alignment.topRight,
        child: Padding(padding: .all(8), child: Text('Top Right')),
      ),
    );
  }
}

class _ExpandedExamples extends StatelessWidget {
  const _ExpandedExamples();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('3 blocs qui se partagent la largeur :'),
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
        const SizedBox(height: 12),
        const Text('Flexible : largeur proportionnelle (2/1) :'),
        const SizedBox(height: 8),
        Row(
          children: [
            Flexible(
              flex: 2,
              child: Container(height: 40, color: Colors.purple.shade200),
            ),
            Flexible(
              flex: 1,
              child: Container(height: 40, color: Colors.teal.shade200),
            ),
          ],
        ),
      ],
    );
  }
}

class _StackAvatarBadgeExample extends StatelessWidget {
  const _StackAvatarBadgeExample();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        clipBehavior: .none,
        children: [
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              shape: .circle,
              color: Colors.blueGrey.shade400,
            ),
            child: const Center(
              child: Text(
                'A',
                style: TextStyle(fontSize: 40, color: Colors.white),
              ),
            ),
          ),
          Positioned(
            bottom: 2,
            right: 2,
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: .circle,
                color: Colors.green,
                border: Border.all(color: Colors.white, width: 3),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ConversationCardExample extends StatelessWidget {
  const _ConversationCardExample();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blueGrey.shade400,
          child: const Text('M', style: TextStyle(color: Colors.white)),
        ),
        title: const Text('Muhammad', style: TextStyle(color: Colors.white)),
        subtitle: const Text(
          'Salut, tu es disponible ?',
          style: TextStyle(color: Colors.white),
        ),
        trailing: Column(
          mainAxisAlignment: .center,
          children: const [
            Text('14:32', style: TextStyle(fontSize: 12, color: Colors.white)),
            SizedBox(height: 4),
            Icon(Icons.done_all, size: 16, color: Colors.white),
          ],
        ),
      ),
    );
  }
}

class _ListViewItemExamples extends StatelessWidget {
  const _ListViewItemExamples();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: const [
        Text('Item Chat (à répéter dans une ListView verticale) :'),
        SizedBox(height: 8),
        _ChatListItem(
          name: 'Ismael',
          message: 'Tu es dispo ?',
          time: '14:32',
          online: true,
        ),
        SizedBox(height: 16),
        Text('Item Story (à répéter dans une ListView horizontale) :'),
        SizedBox(height: 8),
        _StoryItem(name: 'Amina', hasNew: true),
      ],
    );
  }
}

class _ChatListItem extends StatelessWidget {
  final String name;
  final String message;
  final String time;
  final bool online;

  const _ChatListItem({
    required this.name,
    required this.message,
    required this.time,
    required this.online,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Stack(
          clipBehavior: .none,
          children: [
            CircleAvatar(child: Text(name.characters.first)),
            if (online)
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
        title: Text(name, style: TextStyle(color: Colors.white)),
        subtitle: Text(
          message,
          maxLines: 1,
          overflow: .ellipsis,
          style: TextStyle(color: Colors.white),
        ),
        trailing: Text(
          time,
          style: const TextStyle(fontSize: 12, color: Colors.white),
        ),
      ),
    );
  }
}

class _StoryItem extends StatelessWidget {
  final String name;
  final bool hasNew;

  const _StoryItem({required this.name, required this.hasNew});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 88,
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: hasNew ? Colors.blue : Colors.grey,
                child: CircleAvatar(
                  radius: 27,
                  backgroundColor: Colors.blueGrey.shade200,
                  child: Text(
                    name.characters.first,
                    style: const TextStyle(fontSize: 22, color: Colors.white),
                  ),
                ),
              ),
              if (hasNew)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                    padding: const .all(4),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: .circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Text(
                      '1',
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(name, maxLines: 1, overflow: .ellipsis),
        ],
      ),
    );
  }
}

class _SnackBarExamples extends StatelessWidget {
  const _SnackBarExamples();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return Column(
          crossAxisAlignment: .stretch,
          children: [
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('Action réussie')));
              },
              child: const Text('Afficher SnackBar'),
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Message avec action'),
                    action: SnackBarAction(label: 'Annuler', onPressed: () {}),
                  ),
                );
              },
              child: const Text('SnackBar avec action'),
            ),
          ],
        );
      },
    );
  }
}

class _MessagesScreenMock extends StatelessWidget {
  const _MessagesScreenMock();

  @override
  Widget build(BuildContext context) {
    final items = const [
      ('Amina', 'Salut, tu es dispo ?', '14:32', true),
      ('Ibrahim', 'Ok je te rappelle.', '13:10', false),
      ('Samira', 'Merci !', '12:05', true),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Messages')),
      body: ListView.separated(
        padding: const .all(12),
        itemCount: items.length,
        separatorBuilder: (_, _) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final (name, msg, time, online) = items[index];
          return _ChatListItem(
            name: name,
            message: msg,
            time: time,
            online: online,
          );
        },
      ),
    );
  }
}

class _StoriesScreenMock extends StatelessWidget {
  const _StoriesScreenMock();

  @override
  Widget build(BuildContext context) {
    final stories = const [
      ('Amina', true),
      ('Ibrahim', false),
      ('Samira', true),
      ('Moussa', false),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Stories')),
      body: Padding(
        padding: const .all(12),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            const Text('Stories', style: TextStyle(fontWeight: .bold)),
            const SizedBox(height: 12),
            SizedBox(
              height: 110,
              child: ListView.separated(
                scrollDirection: .horizontal,
                itemCount: stories.length,
                separatorBuilder: (_, _) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final (name, hasNew) = stories[index];
                  return _StoryItem(name: name, hasNew: hasNew);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SnackBarScreenMock extends StatelessWidget {
  const _SnackBarScreenMock();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SnackBar Demo')),
      body: Builder(
        builder: (context) => Center(
          child: ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('SnackBar déclenché')),
              );
            },
            child: const Text('Tester SnackBar'),
          ),
        ),
      ),
    );
  }
}
