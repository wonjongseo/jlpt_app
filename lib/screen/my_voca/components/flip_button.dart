import 'package:flutter/material.dart';

class FlipButton extends StatelessWidget {
  const FlipButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  final String text;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 50,
        width: 120,
        child: ElevatedButton(
          onPressed: onTap,
          child: Text(
            text,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ));
  }
}
