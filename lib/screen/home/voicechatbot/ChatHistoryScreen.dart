// lib/screen/chat_history_screen.dart
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:leezon/provider/voice_provider.dart';
import 'package:leezon/utility/constants.dart';
import 'package:provider/provider.dart';
import 'package:leezon/hive/conversation.dart'; // Import the Conversation model

class ChatHistoryScreen extends StatelessWidget {
  const ChatHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
   final provider = Provider.of<VoiceChatProvider>(context);
    final box = Hive.box<Conversation>(Constants.voiceHistoryBox);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat History'),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ValueListenableBuilder<Box<Conversation>>(
        valueListenable: box.listenable(),
        builder: (context, box, _) {
          final conversations = box.values.toList().cast<Conversation>();

          return ListView.builder(
            itemCount: conversations.length,
            itemBuilder: (context, index) {
              final conversation = conversations[index];
              return ListTile(
                title: Text(conversation.prompt),
                subtitle: Text(conversation.response),
                trailing: Text(conversation.date.toLocal().toString()),
              );
            },
          );
        },
      ),
    );
  }
}
