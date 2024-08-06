
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:leezon/api/key.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class VoiceChatProvider with ChangeNotifier {
  
  List<Map<String, String>> conversations = [];
  late stt.SpeechToText _speech;
  final FlutterTts flutterTts = FlutterTts();
  bool _isListening = false;
  bool _isGenerating = false;
  bool _cancelGeneration = false;
  bool _isSpeaking = false;
  String text = '';

  bool get isListening => _isListening;
  bool get isGenerating => _isGenerating;
  bool get isSpeaking => _isSpeaking;
  String get recognizedText => text;

  VoiceChatProvider() {
    initSpeech();
  }

  Future<void> initSpeech() async {
    _speech = stt.SpeechToText();
    bool initialized = await _speech.initialize(
      onError: (error) => print('Failed to initialize: $error'),
    );
    if (initialized) {
      print('Speech recognition initialized successfully');
      _speech.errorListener = (error) {
        print("Error occurred: $error");
        _isListening = false;
        notifyListeners();
      };
    } else {
      print('Speech recognition failed to initialize');
    }
  }

  Future<void> startListening() async {
    if (_speech.isAvailable) {
      _speech.listen(
        onResult: (result) {
          text = result.recognizedWords;
          notifyListeners();
          print('Recognized words: ${result.recognizedWords}');
        },
      );
      _isListening = true;
      notifyListeners();
    } else {
      print('Speech recognition not available');
    }
  }

  Future<void> stopListening() async {
    await _speech.stop();
    _isListening = false;
    notifyListeners();
    print('Final recognized text: $text');
    if (text.isNotEmpty) {
      await aigenerater(text);
    }
  }

  Future<void> aigenerater(String prompt) async {
    if (_isGenerating) {
      _cancelGeneration = true;
      return;
    }

    _isGenerating = true;
    _cancelGeneration = false;
    notifyListeners();

    final model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: aPIKey,
    );

    String finalResponse = '';
    int attempts = 0;

    while (finalResponse.length < 100 && attempts < 5) {
      if (_cancelGeneration) {
        _isGenerating = false;
        notifyListeners();
        return;
      }

      try {
        final response = await model.generateContent(
          [Content.text(prompt)],
        );
        String? generativeContent = response.text;
        generativeContent =
            generativeContent?.replaceAll(RegExp(r'[^a-zA-Z0-9\s]'), '');

        if (generativeContent != null && generativeContent.isNotEmpty) {
          finalResponse += ' ' + generativeContent;
        }
      } catch (e) {
        print('Error during AI generation: $e');
      }
      attempts++;
    }

    conversations.add({
      'prompt': prompt,
      'response': finalResponse.trim(),
    });

    print('Original Text: $prompt');
    print('AI Response: $finalResponse');
    print(conversations);

    if (finalResponse.trim().isNotEmpty) {
      await speak(finalResponse.trim());
    }

    _isGenerating = false;
    notifyListeners();
  }

  Future<void> speak(String text) async {
    _isSpeaking = true;
    notifyListeners();
    await flutterTts.speak(text);
    await flutterTts.awaitSpeakCompletion(true);
    _isSpeaking = false;
    notifyListeners();
  }

  Future<void> stopSpeaking() async {
    await flutterTts.stop();
    _isSpeaking = false;
    notifyListeners();
  }

  void toggleListening() {
    if (_isListening) {
      stopListening();
    } else {
      startListening();
    }
  }

  @override
  void dispose() {
    _speech.stop();
    flutterTts.stop();
    super.dispose();
  }
}
