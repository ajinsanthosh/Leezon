import 'package:flutter/material.dart';
import 'package:leezon/provider/ImageProvider.dart';
import 'package:leezon/screen/home/navigation_menu.dart';
import 'package:leezon/utility/commen_widget/custom_iconbutton.dart';
import 'package:leezon/utility/pallete.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Texttoimagecreation extends StatelessWidget {
  Texttoimagecreation({super.key});
  final TextEditingController _promtcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.whiteColor,
      appBar: AppBar(
        backgroundColor: Pallete.whiteColor,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10, top: 10),
          child: BorderedIconButton(
            icon: const Icon(Icons.arrow_back),
            size: 40, // Diameter of the circle
            borderColor: Pallete.blackColor,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NavigationMenu()),
              );
            },
            backgroundColor: Pallete.borderColor,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: const Icon(Icons.menu, size: 30, color: Colors.black),
              onPressed: () {
                // Handle menu action
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 40, right: 10, left: 10),
        child: SingleChildScrollView(
          child: Consumer<ImageGenerationProvider>(
            builder: (context, imageProvider, child) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        height: 50,
                        width: 260,
                        child: TextField(
                          controller: _promtcontroller,
                          decoration: InputDecoration(
                            hintText: "What do you want to create?",
                            hintStyle: const TextStyle(
                              color: Pallete.blackColor,
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                            ),
                            filled: true,
                            fillColor: Colors.grey[200],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 238, 238, 238),
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: Color.fromARGB(255, 220, 219, 219),
                                width: 2.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 11),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                color:Pallete.blackColor,
                                offset: Offset(2, 2),
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: TextButton(
                            onPressed: () {
                              final prompt = _promtcontroller.text;
                              Provider.of<ImageGenerationProvider>(context,
                                      listen: false)
                                  .generateImage(prompt);
                            },
                            style: TextButton.styleFrom(),
                            child: const Text(
                              'Generate',
                              style: TextStyle(
                                color: Pallete.whiteColor,
                                fontSize: 18,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 70),
                  if (imageProvider.isLoading)
                    SizedBox(
                      height: 400,
                      width: 400, // Adjust size as needed
                      child: Lottie.asset(
                        'assets/lotti/hand.json',
                        fit: BoxFit.cover,
                      ),
                    )
                  else if (imageProvider.errorMessage.isNotEmpty)
                    SizedBox(
                        height: 400,
                        child: Center(child: Text(imageProvider.errorMessage)))
                  else if (imageProvider.imageData.isNotEmpty)
                    Center(
                      child: Image.memory(
                        imageProvider.imageData,
                        height: 400,
                        fit: BoxFit.cover,
                      ),
                    )
                  else
                    Center(
                      child: Image.asset(
                        'assets/img/dog.png',
                        height: 400,
                        fit: BoxFit.cover,
                      ),
                    ),
                  const SizedBox(height: 50),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: Container(
                      height: 50,
                      width: 370,
                      decoration: BoxDecoration(
                        color: Pallete.blackColor,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color:Pallete.blackColor,
                            offset: Offset(2, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: TextButton(
                        onPressed: () {
                          // Ensure that imageData is not empty
                          if (imageProvider.imageData.isNotEmpty) {
                            Provider.of<ImageGenerationProvider>(context,
                                    listen: false)
                                .saveImage(imageProvider.imageData);
                          } else {
                            print('No image to save');
                          }
                        },
                        style: TextButton.styleFrom(),
                        child: const Text(
                          'Save',
                          style: TextStyle(
                            color: Pallete.whiteColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
