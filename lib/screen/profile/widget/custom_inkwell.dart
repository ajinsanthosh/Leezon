import 'package:flutter/material.dart';
import 'package:leezon/utility/pallete.dart';

class CustomInkWell extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const CustomInkWell({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            icon,
            color: Pallete.blackColor,
            size: 30,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            text,
            style: const TextStyle(color: Pallete.blackColor, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
