
import 'package:flutter/material.dart';

class BorderedIconButton extends StatelessWidget {
  final Icon icon;
  final double size;
  final Color backgroundColor;
  final VoidCallback onPressed;

  const BorderedIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.backgroundColor,
    required this.size, required Color borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: size,
          height: size,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            // Remove the border by not including Border.all
          ),
        ),
        CircleAvatar(
          radius: 30, // Adjust radius to fit within the circle
          backgroundColor: backgroundColor, // Use the provided background color
          child: IconButton(
            onPressed: onPressed,
            icon: icon,
            iconSize: 25, // Adjust icon size
          ),
        ),
      ],
    );
  }
}
