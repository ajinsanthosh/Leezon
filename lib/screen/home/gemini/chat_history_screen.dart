import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:leezon/hive/boxes.dart';
import 'package:leezon/hive/chat_history.dart';
import 'package:leezon/provider/chat_provider.dart';
import 'package:leezon/screen/home/gemini/chat_screen.dart';
import 'package:leezon/screen/home/gemini/widgets/chat_history_widget.dart';
import 'package:leezon/screen/home/gemini/widgets/empty_history_widget.dart';
import 'package:leezon/utility/commen_widget/custom_iconbutton.dart';
import 'package:leezon/utility/pallete.dart';
import 'package:provider/provider.dart';

class ChatHistoryScreen extends StatefulWidget {
  const ChatHistoryScreen({super.key});

  @override
  State<ChatHistoryScreen> createState() => _ChatHistoryScreenState();
}

class _ChatHistoryScreenState extends State<ChatHistoryScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  //  Navigator.push(
  //             context,
  //             MaterialPageRoute(builder: (context) => const ChatScreen()),
  //           );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10, top: 10),
          child: BorderedIconButton(
            icon: const Icon(Icons.arrow_back),
            size: 40, // Diameter of the circle
            borderColor: Colors.black,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ChatScreen()),
              );
            },
            backgroundColor: Pallete.borderColor,
          ),
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        centerTitle: true,
        title: const Padding(
          padding: EdgeInsets.only(top: 15),
          child: Text('Chat history'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, right: 10, left: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: '  Search',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13),
                    borderSide: const BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                      ),
                      child: Container(
                        color: Colors.black,
                        padding: const EdgeInsets.all(8.0),
                        child: const Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 8.0),
                ),
                onChanged: (value) {
                  // Notify the provider about the search query change
                  Provider.of<ChatProvider>(context, listen: false)
                      .filterChatHistory(value);
                },
              ),
            ),
            Expanded(
              child: ValueListenableBuilder<Box<ChatHistory>>(
                valueListenable: Boxes.getChatHistory().listenable(),
                builder: (context, box, _) {
                  final chatHistory =
                      box.values.toList().cast<ChatHistory>().reversed.toList();
                  final filteredHistory = Provider.of<ChatProvider>(context)
                      .filteredChatHistory(chatHistory, _searchController.text);

                  final groupedHistory = Provider.of<ChatProvider>(context)
                      .getGroupedChatHistory(filteredHistory);

                  return groupedHistory.isEmpty
                      ? const EmptyHistoryWidget()
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            itemCount: groupedHistory.length,
                            itemBuilder: (context, index) {
                              final entry = groupedHistory[index];
                              final category = entry.key;
                              final messages = entry.value;

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (messages.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: Text(
                                        category,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),

                                  // Padding(
                                  //   padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  //   child: Text(
                                  //     'No messages found',
                                  //     style: TextStyle(color: Colors.grey),
                                  //   ),
                                  // )

                                  ...messages.map((chat) {
                                    return ChatHistoryWidget(chat: chat);
                                  }).toList(),
                                ],
                              );
                            },
                          ),
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
