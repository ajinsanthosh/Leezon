import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:leezon/service/key.dart';
import 'package:lottie/lottie.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:leezon/pallete.dart';

class Voicechatbot extends StatefulWidget {
  const Voicechatbot({super.key});

  @override
  _VoicechatbotState createState() => _VoicechatbotState();
}

class _VoicechatbotState extends State<Voicechatbot> {
  List<Map<String, String>> conversations = [];
  late stt.SpeechToText _speech;
  final FlutterTts flutterTts = FlutterTts();
  bool _isListening = false;
  bool _isGenerating = false;
  bool _cancelGeneration = false;
  bool _showLottie = false;
  String text = '';

  @override
  void initState() {
    super.initState();
    initSpeech();
  }

  Future<void> aigenerater(String prompt) async {
    if (_isGenerating) {
      // Set the flag to cancel the ongoing generation
      _cancelGeneration = true;
      return;
    }
    setState(() {
      _isGenerating = true;
      _cancelGeneration = false;
    });

    final model = GenerativeModel(
      model: 'gemini-1.5-flash-latest',
      apiKey: aPIKey,
    );

    String finalResponse = '';
    int attempts = 0;

    while (finalResponse.length < 100 && attempts < 5) {
      if (_cancelGeneration) {
        setState(() {
          _isGenerating = false;
        });
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

    // Print the original text (prompt)
    print('Original Text: $prompt');

    // Print the response
    print('AI Response: $finalResponse');

    print(conversations);

    if (finalResponse.trim().isNotEmpty) {
      await speak(finalResponse.trim());
    }

    setState(() {
      _isGenerating = false;
      _showLottie = true; // Show Lottie animation after AI generates response
    });
  }

  Future<void> speak(String text) async {
    await flutterTts.speak(text);
  }

  void initSpeech() async {
    _speech = stt.SpeechToText();
    bool initialized = await _speech.initialize(
      onError: (error) => print('Failed to initialize: $error'),
    );
    if (initialized) {
      print('Speech recognition initialized successfully');
      _speech.errorListener = (error) {
        print("Error occurred: $error");
        setState(() {
          _isListening = false;
        });
      };
    } else {
      print('Speech recognition failed to initialize');
    }
  }

  Future<void> startListening() async {
    if (_speech.isAvailable) {
      _speech.listen(
        onResult: (result) {
          setState(() {
            text = result.recognizedWords;
          });
          print('Recognized words: ${result.recognizedWords}');
        },
      );
      setState(() {
        _isListening = true;
      });
    } else {
      print('Speech recognition not available');
    }
  }

  Future<void> stopListening() async {
    await _speech.stop();
    setState(() {
      _isListening = false;
    });
    print('Final recognized text: $text');
    if (text.isNotEmpty) {
      await aigenerater(text);
    }
  }

  void _toggleListening() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.menu),
              ),
            ),
            const SizedBox(height: 40),
            const SizedBox(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Every journey',
                    style: TextStyle(
                      color: Pallete.blackColor,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'needs a guide',
                    style: TextStyle(
                      color: Pallete.blackColor,
                      fontSize: 27,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
            _showLottie
                ? SizedBox(
                    height: 350,
                    width: double.infinity,
                    child: LottieBuilder.asset(
                      "assets/lotti/animation.json",
                      repeat: true,
                      fit: BoxFit.fill,
                    ),
                  )
                : SizedBox(
                    height: 350,
                    width: double.infinity,
                    child: Image.asset(
                      'assets/img/voice.png',
                      fit: BoxFit
                          .cover, // Adjust the fit based on your image requirements
                    ),
                  ),
            GestureDetector(
              onTap: _toggleListening,
              child: Lottie.asset(
                "assets/lotti/animation2.json",
                height: 130,
                width: 130,
                fit: BoxFit.contain,
                repeat: _isListening,
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              child: Text(
                text,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
