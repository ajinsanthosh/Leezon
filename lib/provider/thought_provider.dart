import 'package:flutter/material.dart';

class ThoughtProvider with ChangeNotifier {
  final List<String> _thoughts = [
    "The future belongs to those who code it. Write your own success story, one line at a time.",
    "In the world of tech, every bug is an opportunity to innovate. Debug your doubts and upgrade your dreams.",
    "Your passion for technology is the engine; curiosity is the fuel. Together, they’ll take you beyond the limits of imagination.",
    "In the digital age, the only constant is change. Embrace the unknown, and let your creativity be the algorithm that drives progress.",
    "Every pixel, every line of code, every click—you're not just building technology, you're building the future. Make it extraordinary.",
    "In tech, failure is just a stepping stone to innovation. Keep experimenting, keep pushing boundaries, and let every setback be your setup for success.",
    "The world is your interface, and your skills are the commands. Design a life that's as dynamic and powerful as the technology you create.",
  ];

  String _currentThought = '';

  ThoughtProvider() {
    _loadThought();
  }

  String get currentThought => _currentThought;

  void _loadThought() {
    // Get the current day of the week (0 for Monday, 6 for Sunday)
    final dayOfWeek = DateTime.now().weekday - 1;

    // Select a thought based on the day of the week
    _currentThought = _thoughts[dayOfWeek % _thoughts.length];
    notifyListeners();
  }
}
