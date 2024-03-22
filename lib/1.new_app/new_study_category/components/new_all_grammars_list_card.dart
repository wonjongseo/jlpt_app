import 'package:flutter/material.dart';
import 'package:japanese_voca/model/grammar.dart';

// ignore: must_be_immutable
class NewAllGrammarListCard extends StatelessWidget {
  int? chapterNumber;
  List<Grammar>? newGrammars;
  int? index;
  final VoidCallback onTap;
  NewAllGrammarListCard({
    Key? key,
    this.newGrammars,
    this.chapterNumber,
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
                if (newGrammars == null)
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
                  Flexible(
                    child: Text(
                      newGrammars![index!].grammar,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
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
