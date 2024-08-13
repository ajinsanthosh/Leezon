import 'package:flutter/material.dart';

class NavigationProvider with ChangeNotifier {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void setCurrentIndex(int newIndex) {
    _currentIndex = newIndex;
    notifyListeners();
  }
}
