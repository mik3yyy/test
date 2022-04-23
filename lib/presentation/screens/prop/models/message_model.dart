import 'package:kayndrexsphere_mobile/presentation/components/app%20image/app_image.dart';
import 'package:kayndrexsphere_mobile/presentation/screens/prop/models/user_model.dart';

class Message {
  final User sender;
  final String time;
  final String text;
  final bool isOnline;

  Message({
    required this.sender,
    required this.time,
    required this.text,
    required this.isOnline,
  });
}

final User currentUser = User(
  id: 0,
  name: 'Current User',
  imageUrl: AppImage.phoneContactImg1,
);
final User amaricu = User(
  id: 1,
  name: 'Amaricu',
  imageUrl: AppImage.phoneContactImg2,
);
final User johnDoe = User(
  id: 2,
  name: 'John Doe',
  imageUrl: AppImage.phoneContactImg3,
);
final User johnDoe2 = User(
  id: 3,
  name: 'John Doe',
  imageUrl: AppImage.phoneContactImg3,
);
final User johnDoe3 = User(
  id: 4,
  name: 'John Doe',
  imageUrl: AppImage.phoneContactImg3,
);

// EXAMPLE CHATS ON HOME SCREEN
List<Message> chats = [
  Message(
    sender: johnDoe,
    time: '1:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isOnline: false,
  ),
  Message(
    sender: amaricu,
    time: '5:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isOnline: true,
  ),
  Message(
    sender: johnDoe2,
    time: '2:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isOnline: false,
  ),
  Message(
    sender: johnDoe3,
    time: '2:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isOnline: true,
  ),
  Message(
    sender: johnDoe,
    time: '1:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isOnline: false,
  ),
  Message(
    sender: amaricu,
    time: '5:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isOnline: true,
  ),
  Message(
    sender: johnDoe2,
    time: '2:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isOnline: false,
  ),
  Message(
    sender: johnDoe3,
    time: '2:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isOnline: true,
  ),
];

// EXAMPLE MESSAGES IN CHAT SCREEN
List<Message> messages = [
  Message(
    sender: johnDoe,
    time: '1:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isOnline: false,
  ),
  Message(
    sender: currentUser,
    time: '4:30 PM',
    text: 'Just walked my doge. She was super duper cute. The best pupper!!',
    isOnline: true,
  ),
  Message(
    sender: johnDoe,
    time: '1:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isOnline: false,
  ),
  Message(
    sender: johnDoe,
    time: '1:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isOnline: true,
  ),
  Message(
    sender: currentUser,
    time: '2:30 PM',
    text: 'Nice! What kind of food did you eat?',
    isOnline: true,
  ),
  Message(
    sender: johnDoe,
    time: '1:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isOnline: false,
  ),
];
