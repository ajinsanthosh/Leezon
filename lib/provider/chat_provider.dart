import 'dart:async';
import 'dart:developer';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:leezon/api/key.dart';
import 'package:leezon/utility/constants.dart';
import 'package:leezon/hive/boxes.dart';
import 'package:leezon/hive/chat_history.dart';
import 'package:leezon/model/message.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:uuid/uuid.dart';

class ChatProvider extends ChangeNotifier {
  // list of messages
  final List<Message> _inChatMessages = [];

  // images file list
  List<XFile>? _imagesFileList = [];

   // page controller
  final PageController _pageController = PageController();

  // index of the current screen
 final  int _currentIndex = 0;

  // cuttent chatId
  String _currentChatId = '';

  // initialize generative model
  GenerativeModel? _model;

  // itialize text model
  GenerativeModel? _textModel;

  // initialize vision model
  GenerativeModel? _visionModel;

  // current mode
  String _modelType = 'gemini-pro';

  // loading bool
  bool _isLoading = false;

  // getters
  List<Message> get inChatMessages => _inChatMessages;

  PageController get pageController => _pageController;

  List<XFile>? get imagesFileList => _imagesFileList;

  int get currentIndex => _currentIndex;

  String get currentChatId => _currentChatId;

  GenerativeModel? get model => _model;

  GenerativeModel? get textModel => _textModel;

  GenerativeModel? get visionModel => _visionModel;

  String get modelType => _modelType;

  bool get isLoading => _isLoading;

  // setters

static initHive() async {
 final dir = await path.getApplicationDocumentsDirectory();
 await Hive.initFlutter(dir.path);

  if (!Hive.isAdapterRegistered(1)) {
    Hive.registerAdapter(ChatHistoryAdapter());
  }

  await Hive.openBox<ChatHistory>(Constants.chatHistoryBox);
}

  // set inChatMessages
  Future<void> setInChatMessages({required String chatId}) async {
    // get messages from hive database
    final messagesFromDB = await loadMessagesFromDB(chatId: chatId);

    for (var message in messagesFromDB) {
      if (_inChatMessages.contains(message)) {
        log('message already exists');
        continue;
      }

      _inChatMessages.add(message);
    }
    notifyListeners();
  }

  // load the messages from db
  Future<List<Message>> loadMessagesFromDB({required String chatId}) async {
    // open the box of this chatID
    await Hive.openBox('${Constants.chatMessagesBox}$chatId');

    final messageBox = Hive.box('${Constants.chatMessagesBox}$chatId');

    final newData = messageBox.keys.map((e) {
      final message = messageBox.get(e);
      final messageData = Message.fromMap(Map<String, dynamic>.from(message));

      return messageData;
    }).toList();
    notifyListeners();
    return newData;
  }

  // set file list
  void setImagesFileList({required List<XFile> listValue}) {
    _imagesFileList = listValue;
    notifyListeners();
  }

  // set the current model
  String setCurrentModel({required String newModel}) {
    _modelType = newModel;
    notifyListeners();
    return newModel;
  }

  // function to set the model based on bool - isTextOnly
  Future<void> setModel({required bool isTextOnly}) async {
    if (isTextOnly) {
      _model = _textModel ??
          GenerativeModel(
              model: setCurrentModel(newModel: 'gemini-1.0-pro'),
              apiKey: getApiKey(),
              generationConfig: GenerationConfig(
                temperature: 0.4,
                topK: 32,
                topP: 1,
                maxOutputTokens: 4096,
              ),
              safetySettings: [
                SafetySetting(HarmCategory.harassment, HarmBlockThreshold.high),
                SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.high),
              ]);
    } else {
      _model = _visionModel ??
          GenerativeModel(
              model: setCurrentModel(newModel: 'gemini-1.5-flash'),
              apiKey: getApiKey(),
              generationConfig: GenerationConfig(
                temperature: 0.4,
                topK: 32,
                topP: 1,
                maxOutputTokens: 4096,
              ),
              safetySettings: [
                SafetySetting(HarmCategory.harassment, HarmBlockThreshold.high),
                SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.high),
              ]);
    }
    notifyListeners();
  }

  String getApiKey() {
    return aPIKey.toString();
  }



  // set current chat id
 
  //  void setCurrentIndex({required int newIndex}) {
  //   _currentIndex = newIndex;
  //   notifyListeners();
  // }

  void setCurrentChatId({required String newChatId}) {
    _currentChatId = newChatId;
    notifyListeners();
  }


 

  // set loading
  void setLoading({required bool value}) {
    _isLoading = value;
    notifyListeners();
  }

  // delete caht
  Future<void> deletChatMessages({required String chatId}) async {
    // 1. check if the box is open
    if (!Hive.isBoxOpen('${Constants.chatMessagesBox}$chatId')) {
      // open the box
      await Hive.openBox('${Constants.chatMessagesBox}$chatId');

      // delete all messages in the box
      await Hive.box('${Constants.chatMessagesBox}$chatId').clear();

      // close the box
      await Hive.box('${Constants.chatMessagesBox}$chatId').close();
    } else {
      // delete all messages in the box
      await Hive.box('${Constants.chatMessagesBox}$chatId').clear();

      // close the box
      await Hive.box('${Constants.chatMessagesBox}$chatId').close();
    }

    // get the current chatId, its its not empty
    // we check if its the same as the chatId
    // if its the same we set it to empty
    if (currentChatId.isNotEmpty) {
      if (currentChatId == chatId) {
        setCurrentChatId(newChatId: '');
        _inChatMessages.clear();
        notifyListeners();
      }
    }
  }

  // prepare chat room
  Future<void> prepareChatRoom({
    required bool isNewChat,
    required String chatID,
  }) async {
    if (!isNewChat) {
      // 1.  load the chat messages from the db
      final chatHistory = await loadMessagesFromDB(chatId: chatID);

      // 2. clear the inChatMessages
      _inChatMessages.clear();

      for (var message in chatHistory) {
        _inChatMessages.add(message);
      }

      // 3. set the current chat id
      setCurrentChatId(newChatId: chatID);
    } else {
      // 1. clear the inChatMessages
      _inChatMessages.clear();

      // 2. set the current chat id
      setCurrentChatId(newChatId: chatID);
    }
  }

  // send message to gemini and get the streamed reposnse
  Future<void> sentMessage({
    required String message,
    required bool isTextOnly,
  }) async {
    // set the model
    await setModel(isTextOnly: isTextOnly);

    // set loading
    setLoading(value: true);

    // get the chatId
    String chatId = getChatId();

    // list of history messahes
    List<Content> history = [];

    // get the chat history
    history = await getHistory(chatId: chatId);

    // get the imagesUrls
    List<String> imagesUrls = getImagesUrls(isTextOnly: isTextOnly);

    // open the messages box
    final messagesBox =
        await Hive.openBox('${Constants.chatMessagesBox}$chatId');

    // get the last user message id
    final userMessageId = messagesBox.keys.length;

    // assistant messageId
    final assistantMessageId = messagesBox.keys.length + 1;

    // user message
    final userMessage = Message(
      messageId: userMessageId.toString(),
      chatId: chatId,
      role: Role.user,
      message: StringBuffer(message),
      imagesUrls: imagesUrls,
      timeSent: DateTime.now(),
    );

    // add this message to the list on inChatMessages
    _inChatMessages.add(userMessage);
    notifyListeners();

    if (currentChatId.isEmpty) {
      setCurrentChatId(newChatId: chatId);
    }

    // send the message to the model and wait for the response
    await sendMessageAndWaitForResponse(
      message: message,
      chatId: chatId,
      isTextOnly: isTextOnly,
      history: history,
      userMessage: userMessage,
      modelMessageId: assistantMessageId.toString(),
      messagesBox: messagesBox,
    );
  }

  // send message to the model and wait for the response
 Future<void> sendMessageAndWaitForResponse({
  required String message,
  required String chatId,
  required bool isTextOnly,
  required List<Content> history,
  required Message userMessage,
  required String modelMessageId,
  required Box messagesBox,
}) async {
  try {
    // Ensure the model is initialized
    if (_model == null) {
      log('Model is not initialized');
      return;
    }

    // Start the chat session - only send history if it's text-only
    final chatSession = _model!.startChat(
      history: history.isEmpty || !isTextOnly ? null : history,
    );

    // Get content
    final content = await getContent(
      message: message,
      isTextOnly: isTextOnly,
    );

    // Assistant message
    final assistantMessage = userMessage.copyWith(
      messageId: modelMessageId,
      role: Role.assistant,
      message: StringBuffer(),
      timeSent: DateTime.now(),
    );

    // Add the assistant message to the list of inChatMessages
    _inChatMessages.add(assistantMessage);
    notifyListeners();

    // Wait for stream response
    chatSession.sendMessageStream(content).asyncMap((event) {
      return event;
    }).listen((event) {
      // Append the received text to the assistant message
      _inChatMessages
          .firstWhere((element) =>
              element.messageId == assistantMessage.messageId &&
              element.role == Role.assistant)
          .message
          .write(event.text);
      log('event: ${event.text}');
      notifyListeners();
    }, onDone: () async {
      log('stream done');
      // Save messages to Hive DB
      await saveMessagesToDB(
        chatID: chatId,
        userMessage: userMessage,
        assistantMessage: assistantMessage,
        messagesBox: messagesBox,
      );
      // Set loading to false
      setLoading(value: false);
    }).onError((error, stackTrace) {
      log('Error streaming message: $error');
      // Set loading to false
      setLoading(value: false);
    });
  } catch (e) {
    log('Error in sendMessageAndWaitForResponse: $e');
    setLoading(value: false);
  }
}

  // save messages to hive db
  Future<void> saveMessagesToDB({
    required String chatID,
    required Message userMessage,
    required Message assistantMessage,
    required Box messagesBox,
  }) async {
    // save the user messages
    await messagesBox.add(userMessage.toMap());

    // save the assistant messages
    await messagesBox.add(assistantMessage.toMap());

    // save chat history with thae same chatId
    // if its already there update it
    // if not create a new one
    final chatHistoryBox = Boxes.getChatHistory();

    final chatHistory = ChatHistory(
      chatId: chatID,
      prompt: userMessage.message.toString(),
      response: assistantMessage.message.toString(),
      imagesUrls: userMessage.imagesUrls,
      timestamp: DateTime.now(),
    );
    await chatHistoryBox.put(chatID, chatHistory);

    // close the box
    await messagesBox.close();
  }

  Future<Content> getContent({
    required String message,
    required bool isTextOnly,
  }) async {
    if (isTextOnly) {
      // generate text from text-only input
      return Content.text(message);
    } else {
      // generate image from text and image input
      final imageFutures = _imagesFileList
          ?.map((imageFile) => imageFile.readAsBytes())
          .toList(growable: false);

      final imageBytes = await Future.wait(imageFutures!);
      final prompt = TextPart(message);
      final imageParts = imageBytes
          .map((bytes) => DataPart('image/jpeg', Uint8List.fromList(bytes)))
          .toList();

      return Content.multi([prompt, ...imageParts]);
    }
  }

  // get y=the imagesUrls
  List<String>  getImagesUrls({
    required bool isTextOnly,
  }) {
    List<String> imagesUrls = [];
    if (!isTextOnly && imagesFileList != null) {
      for (var image in imagesFileList!) {
        imagesUrls.add(image.path);
      }
    }
    return imagesUrls;
  }

  Future<List<Content>> getHistory({required String chatId}) async {
    List<Content> history = [];
    if (currentChatId.isNotEmpty) {
      await setInChatMessages(chatId: chatId);

      for (var message in inChatMessages) {
        if (message.role == Role.user) {
          history.add(Content.text(message.message.toString()));
        } else {
          history.add(Content.model([TextPart(message.message.toString())]));
        }
      }
    }

    return history;
  }

  String getChatId() {
    if (currentChatId.isEmpty) {
      return const Uuid().v4();
    } else {
      return currentChatId;
    }
  }

   List<ChatHistory> filteredChatHistory(
      List<ChatHistory> chatHistory, String query) {
    if (query.isEmpty) {
      return chatHistory;
    }
    return chatHistory
        .where((chat) =>
            chat.prompt.toLowerCase().contains(query.toLowerCase()) 
            // you want to check response add this funtion
           // chat.response.toLowerCase().contains(query.toLowerCase())
           )
        .toList();
  }

  // Method to notify listeners about the search query change
  void filterChatHistory(String query) {
    notifyListeners();
  }

//display messages grouped by

   Map<String, List<ChatHistory>> groupChatHistoryByRelativeTime(List<ChatHistory> chatHistory) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final sevenDaysAgo = today.subtract(const Duration(days: 7));
    final thirtyDaysAgo = today.subtract(const Duration(days: 30));

    final grouped = <String, List<ChatHistory>>{
      'Today': [],
      'Yesterday': [],
      'Previous 7 Days': [],
      'Previous 30 Days': [],
    };

    final monthGroups = <String, List<ChatHistory>>{};

    for (var chat in chatHistory) {
      final chatDate = DateTime(chat.timestamp.year, chat.timestamp.month, chat.timestamp.day);

      if (chatDate.isAtSameMomentAs(today)) {
        grouped['Today']!.add(chat);
      } else if (chatDate.isAtSameMomentAs(yesterday)) {
        grouped['Yesterday']!.add(chat);
      } else if (chatDate.isAfter(sevenDaysAgo) && chatDate.isBefore(today)) {
        grouped['Previous 7 Days']!.add(chat);
      } else if (chatDate.isAfter(thirtyDaysAgo) && chatDate.isBefore(today)) {
        grouped['Previous 30 Days']!.add(chat);
      } else if (chatDate.isBefore(thirtyDaysAgo)) {
        final monthKey = '${chatDate.month}/${chatDate.year}';
        if (!monthGroups.containsKey(monthKey)) {
          monthGroups[monthKey] = [];
        }
        monthGroups[monthKey]!.add(chat);
      }
    }

    // Ensure that the result includes all sections
    final result = <String, List<ChatHistory>>{
      'Today': grouped['Today']!,
      'Yesterday': grouped['Yesterday']!,
      'Previous 7 Days': grouped['Previous 7 Days']!,
      'Previous 30 Days': grouped['Previous 30 Days']!,
    };

    // Sort months in descending order of year and month
    final sortedMonths = monthGroups.keys.toList()
      ..sort((a, b) {
        final dateA = DateTime.parse('01-$a');
        final dateB = DateTime.parse('01-$b');
        return dateB.compareTo(dateA); // Descending order
      });

    for (var month in sortedMonths) {
      result[month] = monthGroups[month]!;
    }

    return result;
  }

  List<MapEntry<String, List<ChatHistory>>> getGroupedChatHistory(List<ChatHistory> chatHistory) {
    final grouped = groupChatHistoryByRelativeTime(chatHistory);
    return grouped.entries.toList();
  }
  

}
