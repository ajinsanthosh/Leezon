import 'package:flutter/material.dart';
import 'package:leezon/utility/pallete.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          backgroundColor: Pallete.blackColor,
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: const TextStyle(color:Pallete.whiteColor, fontSize: 18),
        ),
      ),
    );
  }
}
