import 'package:flutter/material.dart';
import 'package:japanese_voca/new_app/models/new_voca_example.dart';

class NewVocaExcampleCard extends StatefulWidget {
  const NewVocaExcampleCard({
    Key? key,
    required this.example,
  }) : super(key: key);

  final NewVocaExample example;

  @override
  State<NewVocaExcampleCard> createState() => _NewVocaExcampleCardState();
}

class _NewVocaExcampleCardState extends State<NewVocaExcampleCard> {
  bool isClicked = false;
  // final List<Map<String, dynamic>> temp_words;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
            onPressed: () {
              isClicked = !isClicked;
              setState(() {});
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(0, 0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              '・ ${widget.example.example}',
              style: TextStyle(
                color: Colors.grey.shade800,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 1,
              ),
            ),
          ),
          if (isClicked) ...[
            Padding(
              padding: const EdgeInsets.only(
                top: 5,
              ),
              child: Text(
                widget.example.yomikata,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5, bottom: 10),
              child: Text(
                widget.example.mean,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
