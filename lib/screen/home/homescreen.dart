import 'package:flutter/material.dart';
import 'package:leezon/screen/home/gemini/chat_screen.dart';
import 'package:leezon/screen/home/text_to_image/mainscreen.dart';
import 'package:leezon/screen/home/voicechatbot/voicechatbot.dart';

class Homescreen extends StatelessWidget {
 const Homescreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: 
      SingleChildScrollView(
        child: Container(
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20, top: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 50,
                    width: 70,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/img/istockphoto.jpg"),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 1,
                  ),
                  const Text(
                    "L",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 7, left: 2),
                    child: Text(
                      "EZON",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                 Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ChatScreen()),
                  );
              },
              child: Container(
                height: 170,
                width: 370,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Stack(
                  alignment:
                      Alignment.center,
                  children: <Widget>[
                    Container(
                      width: 345,
                      height: 135,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 120,
                            width: 150,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/img/home1.png"),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ChatScreen()),
                              );
                            },
                            child: Container(
                              child: const Padding(
                                padding: EdgeInsets.only(top: 25),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "AI",
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      Text(
                                        "How can i assist you",
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.black),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
                 Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  Texttoimagecreation()),
                  );
              },
              child: Container(
                height: 170,
                width: 370,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    Container(
                      width: 345,
                      height: 135,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Container(
                            child: const Padding(
                              padding: EdgeInsets.only(top: 25),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 7, right: 5),
                                      child: Text(
                                        "AI  Image Generator",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 10, top: 5, right: 5),
                                      child: Text(
                                        "Convert your thoughts \n into images",
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.black),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            // padding: const EdgeInsets.only(left: 10),
                            child: Container(
                              // height: 12,
                              //width: 115,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage("assets/img/home2.2.jpg"),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
                 Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Voicechatbot()),
                  );
              },
              child: Container(
                height: 170,
                width: 370,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: Stack(
                  alignment:
                      Alignment.center, // Center the children within the Stack
                  children: <Widget>[
                    Container(
                      width: 345,
                      height: 135,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: 120,
                            width: 150,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/img/giphy.gif"),
                              ),
                            ),
                          ),
                          Container(
                            child: const Padding(
                              padding: EdgeInsets.only(top: 25, left: 5),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Hi  I Am Luna...",
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      "Free to interact!.....",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
