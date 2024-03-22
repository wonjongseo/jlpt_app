import 'package:flutter/material.dart';
import 'package:japanese_voca/model/word.dart';

// ignore: must_be_immutable
class NewAllJapaneseListCard extends StatelessWidget {
  int? chapterNumber;
  List<Word>? newJapaneses;
  int? index;
  final VoidCallback onTap;
  NewAllJapaneseListCard({
    Key? key,
    this.chapterNumber,
    this.newJapaneses,
    this.index,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: InkWell(
        onTap: onTap,
        child: Card(
          color: Colors.white,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (newJapaneses == null)
                  RichText(
                      text: TextSpan(
                    text: 'Chapter $chapterNumber  ',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    children: const [
                      TextSpan(
                        text: ' (0 /30)',
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                    ],
                  ))
                else
                  Text(
                    newJapaneses![index!].word,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                const Icon(
                  Icons.arrow_forward_ios_sharp,
                  size: 13,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
