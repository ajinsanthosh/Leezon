import 'package:flutter/material.dart';
import 'package:leezon/screen/chatbot/widgets/message_widget.dart';
import 'package:leezon/service/key.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ChatWidget extends StatefulWidget {
  const ChatWidget({super.key});

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  late final GenerativeModel _model;
  late final ChatSession _chat;
  final ScrollController _scrollController = ScrollController();
  bool _loading = false;

  final TextEditingController _textController = TextEditingController();
  final FocusNode _textfiledFocus = FocusNode();
  final List<({Image? image, String? text, bool fromUser})> _generatedContent =
      [];

  @override
  void initState() {
    _model =GenerativeModel(model: 'gemini-1.5-flash-latest', apiKey: aPIKey);
    _chat = _model.startChat();
    super.initState();
  }

  void _scrollDown() {
    WidgetsBinding.instance
        .addPostFrameCallback((_) => _scrollController.animateTo(
              _scrollController.position.maxScrollExtent,
              duration: const Duration(microseconds: 750),
              curve: Curves.easeInOutCirc,
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
              child: aPIKey?.isNotEmpty ?? false
                  ? ListView.builder(
                      controller: _scrollController,
                      itemCount: _generatedContent.length,
                      itemBuilder: (context, index) {
                        final content = _generatedContent[index];

                        return MessageWidget(
                          isFromUser: content.fromUser,
                          text: content.text,
                        );
                      })
                  : ListView(
                      children: const [Text(' incurrent your gemini API ')],
                    )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onSubmitted: _sendMessage,
                    autofocus: true,
                    focusNode: _textfiledFocus,
                    controller: _textController,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(15.0),
                        hintText: "Enter Something.....",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: const BorderSide(color: Colors.black))),
                  ),
                ),
                const SizedBox.square(
                  dimension: 15,
                ),
                if (!_loading)
                  IconButton(
                      onPressed: () {
                        _sendMessage(_textController.text);
                      },
                      icon: const Icon(
                        Icons.send,
                        color: Colors.black,
                        size: 30,
                      ))
                else
                  const CircularProgressIndicator()
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> _sendMessage(String message) async {
    setState(() {
      _loading = true;
    });

    try {
      _generatedContent.add((image: null, text: message, fromUser: true));
      final response = await _chat.sendMessage(
        Content.text(message),
      );

      final text = response.text;
      _generatedContent.add((image: null, text: text, fromUser: false));

      if (text == null) {
        showError("No Response from gemini");
        return;
      } else {
        setState(() {
          _loading = false;
          _scrollDown();
        });
      }
    } catch (e) {
      showError(e.toString());
      setState(() {
        _loading = false;
      });
    } finally {
      _textController.clear();
      setState(() {
        _loading = false;
        _textfiledFocus.requestFocus();
      });
    }
  }

  Future<dynamic> showError(String message) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Somethig went wrong'),
            content: SingleChildScrollView(
              child: SelectableText(message),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Ok'))
            ],
          );
        });
  }
}
