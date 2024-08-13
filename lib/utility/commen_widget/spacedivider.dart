
import 'package:flutter/material.dart';

class SpacedDivider extends StatelessWidget {
  final double spacing;
  final Color dividerColor;
  final double dividerThickness;
  final double indent;
  final double endIndent;

  const SpacedDivider({
    super.key,
    this.spacing = 10.0,
    this.dividerColor = Colors.grey,
    this.dividerThickness = 0.2,
    this.indent = 20.0,
    this.endIndent = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: spacing),
        Divider(
          color: dividerColor,
          thickness: dividerThickness,
          indent: indent,
          endIndent: endIndent,
        ),
        SizedBox(height: spacing),
      ],
    );
  }
}
