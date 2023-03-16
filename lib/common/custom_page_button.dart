import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomPageButton extends StatelessWidget {
  const CustomPageButton({
    Key? key,
    required this.onTap,
    required this.level,
  }) : super(key: key);

  final VoidCallback onTap;
  final String level;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 500,
        margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                  offset: Offset(0, 1), color: Colors.grey, blurRadius: 0.5),
            ]),
        child: Center(
          child: Text(
            level,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.bold, fontSize: 15),
          ),
        ),
      ),
    );
  }
}
