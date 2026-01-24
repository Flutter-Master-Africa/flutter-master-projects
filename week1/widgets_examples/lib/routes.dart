import 'package:flutter/material.dart';
import 'screens/widget_gallery_screen.dart';
import 'screens/listview_chat_screen.dart';
import 'screens/listview_stories_screen.dart';

class AppRouteNames {
  static const gallery = '/gallery';
  static const chat = '/listview-chat';
  static const stories = '/listview-stories';
}

final Map<String, WidgetBuilder> appRoutes = {
  AppRouteNames.gallery: (_) => const WidgetGalleryScreen(),
  AppRouteNames.chat: (_) => const ListViewChatScreen(),
  AppRouteNames.stories: (_) => const ListViewStoriesScreen(),
};
