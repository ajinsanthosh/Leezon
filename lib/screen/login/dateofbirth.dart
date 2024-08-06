import 'package:flutter/material.dart';
import 'package:leezon/screen/login/username.dart';
import 'package:leezon/utility/commen_widget/iconButton.dart';

class Dateofbirth extends StatelessWidget {
  const Dateofbirth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 100, right: 10, left: 20, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: Color.fromARGB(255, 239, 238, 238),
                  child: Icon(
                    Icons.star,
                    size: 40,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  "When is your birthday?",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BorderedIconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Username()));
                      },
                      borderColor: Colors.white,
                      backgroundColor: Colors.white,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        width: 90,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 25, 25, 25),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Next',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
