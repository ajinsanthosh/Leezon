import 'package:flutter/material.dart';
import 'package:leezon/provider/chat_provider.dart';
import 'package:leezon/screen/gemini/chat_history_screen.dart';
import 'package:leezon/screen/gemini/widgets/bottom_chat_field.dart';
import 'package:leezon/screen/gemini/widgets/chat_messages.dart';
import 'package:leezon/screen/home/navigation_menu.dart';
import 'package:leezon/utility/utilites.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  // scroll controller
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients &&
          _scrollController.position.maxScrollExtent > 0.0) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, chatProvider, child) {
        if (chatProvider.inChatMessages.isNotEmpty) {
          _scrollToBottom();
        }

        // auto scroll to bottom on new message
        chatProvider.addListener(() {
          if (chatProvider.inChatMessages.isNotEmpty) {
            _scrollToBottom();
          }
        });

        return Scaffold(
          appBar: AppBar(
            leading:  Padding(
              padding: const EdgeInsets.only(top: 10,left: 10),
              child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 27,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  NavigationMenu()),
                );
              },
                        ),
            ),
           // backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            centerTitle: true,
            actions: [
              if (chatProvider.inChatMessages.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 10,),
                  child: IconButton(
                    icon: const Icon(Icons.add,color: Colors.black,size: 30,),
                    onPressed: () async {
                      // show my animated dialog to start new chat
                      showMyAnimatedDialog(
                        context: context,
                        title: 'Start New Chat',
                        content: 'Are you sure you want to start a new chat?',
                        actionText: 'Yes',
                        onActionPressed: (value) async {
                          if (value) {
                            // prepare chat room
                            await chatProvider.prepareChatRoom(
                                isNewChat: true, chatID: '');
                          }
                        },
                      );
                    },
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(top: 10,right: 10),
                child: IconButton(
                  icon: const Icon(Icons.menu,color: Colors.black,size: 30,),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChatHistoryScreen()),
                    );
                  },
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Expanded(
                    child: chatProvider.inChatMessages.isEmpty
                        ? const Center(
                            child: Text('No messages yet'),
                          )
                        : ChatMessages(
                            scrollController: _scrollController,
                            chatProvider: chatProvider,
                          ),
                  ),

                  // input field
                  BottomChatField(
                    chatProvider: chatProvider,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
