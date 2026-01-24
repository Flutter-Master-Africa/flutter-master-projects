class ChatItem {
  final String name;
  final String message;
  final String time;
  final bool online;

  const ChatItem({
    required this.name,
    required this.message,
    required this.time,
    required this.online,
  });
}

class StoryItem {
  final String name;
  final bool hasNew;

  const StoryItem({required this.name, required this.hasNew});
}
