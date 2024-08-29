
import 'package:flutter/material.dart';

const kButtonColor = Color.fromRGBO(137, 133, 133, 1);
const kInactiveIndicatorColor = Color.fromRGBO(82, 82, 82, 1);
const kActiveIndicatorColor = Colors.white;
const kPrimaryBackgroundGradient = LinearGradient(
  colors: [
    Color.fromARGB(255, 0, 0, 0),
    Color.fromARGB(255, 0, 0, 0),
  ],
  stops: [0.25, 0.75],
  begin: Alignment.bottomCenter,
  end: Alignment.topCenter,
);