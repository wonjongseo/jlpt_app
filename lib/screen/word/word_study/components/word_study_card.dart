import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:japanese_voca/common/common.dart';

import '../word_controller.dart';

class WordStrudyCard extends StatelessWidget {
  const WordStrudyCard({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final WordController controller;

  @override
  Widget build(BuildContext context) {
    String japanese = controller.words[controller.currentIndex].word;
    List<int> aaa = getKangiIndex(japanese);
    return Column(
      children: [
        SizedBox(child: controller.yomikata),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: InkWell(
            onTap: () => controller.copyWord(),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(japanese.length, (index) {
                return Text(
                  japanese[index],
                  style: Theme.of(context).textTheme.headline3,
                  textAlign: TextAlign.center,
                );
                // BE ABLE TO CLICK KANGI
                // return aaa.contains(index)
                //     ? InkWell(
                //         onTap: () {
                //           print('object');
                //         },
                //         child: Text(
                //           japanese[index],
                //           style: Theme.of(context).textTheme.headline3,
                //           textAlign: TextAlign.center,
                //         ),
                //       )
                //     : Text(
                //         japanese[index],
                //         style: Theme.of(context).textTheme.headline3,
                //         textAlign: TextAlign.center,
                //       );
              }),
            ),
          ),
          // child: InkWell(
          //   onTap: () => controller.copyWord(),
          //   child: Text(
          //     controller.words[controller.currentIndex].word,
          //     style: Theme.of(context).textTheme.headline3,
          //     textAlign: TextAlign.center,
          //   ),
          // ),
        ),
        const SizedBox(height: 15),
        SizedBox(child: controller.mean),
      ],
    );
  }
}
