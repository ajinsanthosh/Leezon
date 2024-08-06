import 'package:flutter/material.dart';
import 'package:leezon/hive/image_data.dart';
import 'package:leezon/provider/ImageProvider.dart';
import 'package:leezon/screen/home/navigation_menu.dart';
import 'package:leezon/utility/commen_widget/arrowwidget.dart';
import 'package:leezon/utility/utilites.dart';
import 'package:provider/provider.dart';

class ScreenLibrary extends StatefulWidget {
  const ScreenLibrary({super.key});

  @override
  State<ScreenLibrary> createState() => _ScreenLibraryState();
}

class _ScreenLibraryState extends State<ScreenLibrary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Center(child: Text('Saved Images')),
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 20,left: 10,right: 10),
          child: Consumer<ImageGenerationProvider>(
            builder: (context, imageProvider, child) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
                itemCount: imageProvider.savedImages.length,
                itemBuilder: (context, index) {
                  final imageData = imageProvider.savedImages[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ImageDetailScreen(imageData: imageData),
                        ),
                      );
                    },
                    onLongPress: () {
                      showMyAnimatedDialog(
                        context: context,
                        title: 'Delete Image',
                        content: 'Are you sure you want to delete this image?',
                        actionText: 'Delete',
                        onActionPressed: (isConfirmed) {
                          if (isConfirmed) {
                            imageProvider.deleteImage(index);
                          }
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: Image.memory(imageData.imageData,
                                fit: BoxFit.cover),
                          ),
                          // Text('Created on: ${imageData.creationDate}'),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class ImageDetailScreen extends StatelessWidget {
  final ImageData imageData;

  const ImageDetailScreen({required this.imageData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
       leading: Padding(
          padding: const EdgeInsets.only(left: 10, top: 10),
          child: BorderedIconButton(
            icon: const Icon(Icons.arrow_back),
            size: 40, // Diameter of the circle
            borderColor: Colors.black,

            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>  NavigationMenu(),
                ),
              );
            },
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.memory(imageData.imageData),
              Text('Created on: ${imageData.creationDate}'),
            ],
          ),
        ),
      ),
    );
  }
}

