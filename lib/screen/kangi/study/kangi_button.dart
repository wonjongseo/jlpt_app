import 'package:flutter/material.dart';

class KangiButton extends StatelessWidget {
  const KangiButton({
    super.key,
    this.width = 95,
    this.height = 40,
    required this.text,
    required this.onTap,
  });

  final double height;
  final double width;
  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(
          text,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
