import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/data_format.dart';

import '../word_controller.dart';

class WordStrudyCard extends StatelessWidget {
  const WordStrudyCard({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final WordStudyController controller;

  @override
  Widget build(BuildContext context) {
    String japanese = controller.words[controller.currentIndex].word;
    List<int> kangiIndex = getKangiIndex(japanese);
    // [0,2]
    return Column(
      children: [
        SizedBox(child: controller.yomikata),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(japanese.length, (index) {
              return kangiIndex.contains(index)
                  ? InkWell(
                      onTap: () =>
                          controller.getKangi(japanese[index], context),
                      child: Text(
                        japanese[index],
                        style: Theme.of(context).textTheme.headline3,
                        textAlign: TextAlign.center,
                      ),
                    )
                  : Text(
                      japanese[index],
                      style: Theme.of(context).textTheme.headline3,
                      textAlign: TextAlign.center,
                    );
            }),
          ),
        ),
        const SizedBox(height: 15),
        SizedBox(child: controller.mean),
      ],
    );
  }
}
