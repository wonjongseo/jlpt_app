import 'package:flutter/material.dart';
import 'package:japanese_voca/model/example.dart';
import 'package:japanese_voca/model/my_word.dart';

class ExampleMeanCard extends StatefulWidget {
  ExampleMeanCard({
    Key? key,
    required this.example,
  }) : super(key: key);

  // final WordApiDatasource wordApiDatasource = WordApiDatasource();
  final Example example;

  @override
  State<ExampleMeanCard> createState() => _ExampleMeanCardState();
}

class _ExampleMeanCardState extends State<ExampleMeanCard> {
  bool isClick = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
          style: TextButton.styleFrom(padding: EdgeInsets.zero),
          onPressed: () async {
            setState(() {
              isClick = true;
            });
          },
          child: Text(widget.example.word),
        ),
        const SizedBox(height: 5),
        if (isClick) Text(widget.example.mean),
        // Text(widget.example.mean),
        const SizedBox(height: 30),
      ],
    );
  }
}
