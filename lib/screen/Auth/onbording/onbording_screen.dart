import 'package:flutter/material.dart';
import 'package:leezon/screen/Auth/onbording/components/onbording_content.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  List<Map<String, String>> sliders = [
    {
      "title": "Boost your\nproductivity",
      "imgUrl": "assets/img/200w.gif",
    },
    {
      "title": "Your messages,\nall in one place",
      "imgUrl": "assets/img/200w.gif",
    },
    {
      "title": "Collaborate in\nreal time",
      "imgUrl": "assets/img/200w.gif",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 80.0),
        decoration: const BoxDecoration(
          gradient: kPrimaryBackgroundGradient,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: sliders
                  .map(
                    (i) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.only(right: 15.0),
                      width: 50.0,
                      height: 4.0,
                      decoration: BoxDecoration(
                        color: currentIndex == sliders.indexOf(i)
                            ? kActiveIndicatorColor
                            : kInactiveIndicatorColor,
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 40.0),
            Expanded(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  PageView.builder(
                    controller: _controller,
                    onPageChanged: (index) {
                      setState(() {
                        currentIndex = index;
                      });
                    },
                    itemCount: sliders.length,
                    itemBuilder: (BuildContext context, i) {
                      return Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.contain,
                            image: AssetImage(sliders[i]["imgUrl"]!),
                          ),
                        ),
                      );
                    },
                  ),
                  Positioned(
                    top: 20.0,
                    child: Text(
                      sliders[currentIndex]["title"]!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 38.0,
                        height: 1.30,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Positioned(
                    bottom: 10.0,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.70,
                      child: MaterialButton(
                        elevation: 3.0,
                        highlightElevation: 0.0,
                        color: kButtonColor,
                        onPressed: currentIndex == sliders.length - 1
                            ? () {} // Define what happens when 'GET STARTED' is pressed on the last slide
                            : () {
                                setState(() {
                                  currentIndex++;
                                });
                                _controller.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.linear,
                                );
                              },
                        padding: const EdgeInsets.symmetric(vertical: 23.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: const Text(
                          "GET STARTED",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 20.0,
                          ),
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
    );
  }
}
