import 'package:flutter/material.dart';
import '../widgets/section_title.dart';
import '../widgets/basic_widgets_examples.dart';
import '../widgets/stack_avatar_badge.dart';
import '../widgets/card_listtile_examples.dart';
import '../widgets/snackbar_demo.dart';

class WidgetGalleryScreen extends StatelessWidget {
  const WidgetGalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Widget Gallery')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          SectionTitle('1) Widgets de base'),
          BasicWidgetsExamples(),
          SizedBox(height: 24),

          SectionTitle('2) Stack (avatar + badge)'),
          StackAvatarBadge(),
          SizedBox(height: 24),

          SectionTitle('3) Card & ListTile (conversation item)'),
          CardListTileExamples(),
          SizedBox(height: 24),

          SectionTitle('4) SnackBar (interaction)'),
          SnackBarDemo(),
        ],
      ),
    );
  }
}
