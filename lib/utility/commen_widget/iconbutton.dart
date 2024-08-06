import 'package:flutter/material.dart';

class BorderedIconButton extends StatelessWidget {
  final Icon icon;
  final double size;
  final Color borderColor;
  final VoidCallback onPressed;
  final Color backgroundColor;

  const BorderedIconButton({
    Key? key,
    required this.icon,
    this.size = 50.0,
    this.borderColor = Colors.black,
    
    required this.onPressed, required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: borderColor,
              width: 0.5,
            ),
          ),
        ),
        CircleAvatar(
          radius: size / 2 - 2, // Adjust radius to fit within the border
          backgroundColor: const Color.fromARGB(255, 212, 210, 210),
          child: IconButton(
            onPressed: onPressed,
            icon: icon,
            iconSize: size / 2, // Adjust icon size
          ),
        ),
      ],
    );
  }
}
