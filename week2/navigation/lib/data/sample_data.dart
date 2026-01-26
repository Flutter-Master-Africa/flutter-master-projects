import 'models.dart';

const chatItems = [
  ChatItem(
    name: 'Amina',
    message: 'Salut, tu es dispo ?',
    time: '14:32',
    online: true,
  ),
  ChatItem(
    name: 'Ibrahim',
    message: 'Ok, je te rappelle.',
    time: '13:10',
    online: false,
  ),
  ChatItem(name: 'Samira', message: 'Merci !', time: '12:05', online: true),
  ChatItem(
    name: 'Moussa',
    message: 'On se voit demain.',
    time: '11:45',
    online: false,
  ),
  ChatItem(name: 'Fatima', message: 'Bien reçu.', time: '10:20', online: true),
];

const storyItems = [
  StoryItem(name: 'Amina', hasNew: true),
  StoryItem(name: 'Ibrahim', hasNew: false),
  StoryItem(name: 'Samira', hasNew: true),
  StoryItem(name: 'Moussa', hasNew: false),
  StoryItem(name: 'Fatima', hasNew: true),
  StoryItem(name: 'Ali', hasNew: false),
];
