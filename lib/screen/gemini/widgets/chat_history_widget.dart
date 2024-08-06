import 'package:flutter/material.dart';
import 'package:leezon/hive/chat_history.dart';
import 'package:leezon/provider/chat_provider.dart';
import 'package:leezon/screen/gemini/chat_screen.dart';
import 'package:leezon/utility/utilites.dart';
import 'package:provider/provider.dart';

class ChatHistoryWidget extends StatelessWidget {
  const ChatHistoryWidget({
    super.key,
    required this.chat,
  });

  final ChatHistory chat;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 248, 246, 246),
      child: ListTile(
        // contentPadding: const EdgeInsets.only(left: 10.0, right: 10.0,b),
        // leading: const CircleAvatar(
        //   radius: 30,
        //   child: Icon(Icons.chat),
        // ),
        title: Text(
          chat.prompt,
          maxLines: 1,style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          chat.response,
          maxLines: 2,
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () async {
          // navigate to chat screen
          final chatProvider = context.read<ChatProvider>();

          // prepare chat room
          await chatProvider.prepareChatRoom(
            isNewChat: false,
            chatID: chat.chatId,
          );

          // Navigate to the chat screen
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const ChatScreen()), // Replace `ChatScreen` with the actual screen you want to navigate to
          );
        },

        onLongPress: () {
          // show my animated dialog to delete the chat
          showMyAnimatedDialog(
            context: context,
            title: 'Delete Chat',
            content: 'Are you sure you want to delete this chat?',
            actionText: 'Delete',
            onActionPressed: (value) async {
              if (value) {
                // delete the chat
                await context
                    .read<ChatProvider>()
                    .deletChatMessages(chatId: chat.chatId);

                // delete the chat history
                await chat.delete();
              }
            },
          );
        },
      ),
    );

  }
}
