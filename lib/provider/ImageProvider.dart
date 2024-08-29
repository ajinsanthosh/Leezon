import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:leezon/hive/image_data.dart';

class ImageGenerationProvider with ChangeNotifier {
  bool isLoading = false;
  Uint8List imageData = Uint8List(0);
  String errorMessage = '';
  List<ImageData> savedImages = [];

  bool isSaving = false;
  bool isSaved = false;

  ImageGenerationProvider() {
    loadSavedImages();
  }

  Future<void> generateImage(String prompt) async {
    isLoading = true;
    errorMessage = '';
    notifyListeners();

    const baseUrl = 'https://api.stability.ai';
    final url = Uri.parse(
        '$baseUrl/v1alpha/generation/stable-diffusion-512-v2-1/text-to-image');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              //add ypur secreat key here
              'Bearer sk-e2wShVknbadjfLuFA4iFC22hn80a8SLuGTnPm92DjYrL3f8J',
          'Accept': 'image/png',
        },
        body: jsonEncode({
          'cfg_scale': 15,
          'clip_guidance_preset': 'FAST_BLUE',
          'height': 512,
          'width': 512,
          'samples': 1,
          'steps': 150,
          'seed': 0,
          'style_preset': "3d-model",
          'text_prompts': [
            {
              'text': prompt,
              'weight': 1,
            }
          ],
        }),
      );

      if (response.statusCode == 200) {
        imageData = response.bodyBytes;
      } else {
        errorMessage = 'Failed to generate image';
      }
    } catch (e) {
      errorMessage = 'Failed to generate image';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> saveImage(Uint8List imageData) async {
    if (imageData.isEmpty) return;

    isSaving = true;
    notifyListeners();

    try {
      final box = await Hive.openBox<ImageData>('images');
      final newImage = ImageData(imageData, DateTime.now());
      await box.add(newImage);
      savedImages.add(newImage);
       isSaved = true;

        await Future.delayed(Duration(seconds: 4));
          isSaved = false; 
      notifyListeners();
    } catch (e) {
      print('Error saving image: $e');
    }finally {
      isSaving = false;
      notifyListeners();
    }

  }

  Future<void> loadSavedImages() async {
    try {
      final box = await Hive.openBox<ImageData>('images');
      savedImages = box.values.toList();
      notifyListeners();
    } catch (e) {
      // Handle any errors that occur during loading
      print('Error loading images: $e');
    }
  }

  Future<void> deleteImage(int index) async {
    try {
      final box = await Hive.openBox<ImageData>('images');
      await box.deleteAt(index);
      savedImages.removeAt(index);
      notifyListeners();
    } catch (e) {
      print('Error deleting image: $e');
    }
  }
}
