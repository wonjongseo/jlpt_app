import 'package:flutter/material.dart';
import 'package:japanese_voca/config/size.dart';

class CustomAppBar2 extends StatelessWidget {
  const CustomAppBar2(
      {super.key, required this.title, this.leading, this.actions});

  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(appBarHeight),
      child: AppBar(
        title: Text(
          title,
          style: TextStyle(fontSize: appBarTextSize),
        ),
      ),
    );
  }
}
