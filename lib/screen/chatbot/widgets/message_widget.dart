import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MessageWidget extends StatelessWidget {
  final String? text;
  final bool isFromUser;
  const MessageWidget(
      {super.key, this.text, required this.isFromUser, });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isFromUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
            child: Container(
          constraints: const BoxConstraints(maxWidth: 700),
          decoration: BoxDecoration(
              color: isFromUser
                  ? const Color.fromARGB(255, 184, 181, 181)
                  : const Color.fromARGB(221, 224, 220, 220),
              borderRadius: BorderRadius.circular(18)),
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          margin: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              if (text case final text?) MarkdownBody(data: text),
            ],
          ),
        ))
      ],
    );
  }
}
