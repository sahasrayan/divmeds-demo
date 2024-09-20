import 'package:flutter/material.dart';
import 'package:divmeds/designs/app_colors.dart';
import 'package:divmeds/features/auth/models/user.model.dart';

class ConversationScreen extends StatelessWidget {
  final User user;

  ConversationScreen({required this.user});

  final List<Message> dummyMessages = [
    Message(senderId: 'alice_smith', receiverId: 'current_user', content: 'Hello, how are you?', timestamp: DateTime.now().subtract(Duration(minutes: 1))),
    Message(senderId: 'current_user', receiverId: 'alice_smith', content: 'I am good, thanks! How about you?', timestamp: DateTime.now().subtract(Duration(minutes: 1))),
    Message(senderId: 'alice_smith', receiverId: 'current_user', content: 'I am doing well, thank you!', timestamp: DateTime.now().subtract(Duration(minutes: 1))),
    Message(senderId: 'bob_johnson', receiverId: 'current_user', content: 'Can we discuss the new project?', timestamp: DateTime.now().subtract(Duration(hours: 1))),
    Message(senderId: 'current_user', receiverId: 'bob_johnson', content: 'Sure, let me know when you are available.', timestamp: DateTime.now().subtract(Duration(hours: 1))),
  ];

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${user.firstName} ${user.lastName}'),
        backgroundColor: AppColors.divMedsColorBlueScaffoldAccent,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: dummyMessages.length,
              itemBuilder: (context, index) {
                final message = dummyMessages[index];
                final isSentByMe = message.senderId != user.userId;
                return Align(
                  alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: isSentByMe ? Colors.blue : Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      message.content,
                      style: TextStyle(color: isSentByMe ? Colors.white : Colors.black),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // Add send message functionality
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String senderId;
  final String receiverId;
  final String content;
  final DateTime timestamp;

  Message({
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.timestamp,
  });
}
