
import 'package:flutter/material.dart';
import 'package:leezon/provider/voice_provider.dart';
import 'package:provider/provider.dart';
import 'package:leezon/utility/pallete.dart';
import 'package:lottie/lottie.dart';

class Voicechatbot extends StatelessWidget {
  const Voicechatbot({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VoiceChatProvider(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 30,
                color: Colors.black,
              ),
              onPressed: () {
                context.read<VoiceChatProvider>().stopSpeaking();
                Navigator.pop(context);
              },
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: const Icon(Icons.menu, size: 30, color: Colors.black),
                onPressed: () {
                  context.read<VoiceChatProvider>().stopSpeaking();
                  // Add your desired functionality here
                },
              ),
            ),
          ],
        ),
        body: Consumer<VoiceChatProvider>(
          builder: (context, provider, child) {
            return Container(
              padding: const EdgeInsets.only(top: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                  provider.isSpeaking
                      ? Column(
                          children: [
                            SizedBox(
                              height: 350,
                              width: double.infinity,
                              child: LottieBuilder.asset(
                                "assets/lotti/animation.json",
                                repeat: true,
                                fit: BoxFit.fill,
                              ),
                            ),
                            GestureDetector(
                              onTap: () async {
                                if (provider.isSpeaking) {
                                  await provider.stopSpeaking();
                                }
                              },
                              child: Lottie.asset(
                                "assets/lotti/stop.json",
                                height: 130,
                                width: 130,
                                fit: BoxFit.contain,
                                repeat: provider.isListening,
                              ),
                            )
                          ],
                        )
                      : Column(
                          children: [
                            SizedBox(
                              height: 350,
                              width: double.infinity,
                              child: Image.asset(
                                'assets/img/voice.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            GestureDetector(
                              onTap: provider.toggleListening,
                              child: Lottie.asset(
                                "assets/lotti/animation2.json",
                                height: 130,
                                width: 130,
                                fit: BoxFit.contain,
                                repeat: provider.isListening,
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              child: Text(
                                provider.recognizedText,
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
