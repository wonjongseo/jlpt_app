import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/data_format.dart';

import '../kangi_study_controller.dart';

class KangiStrudyCard extends StatelessWidget {
  const KangiStrudyCard({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final KangiController controller;

  @override
  Widget build(BuildContext context) {
    String japanese = controller.kangis[controller.currentIndex].japan;
    List<int> kangiIndex = getKangiIndex(japanese);
    return Column(
      children: [
        SizedBox(child: controller.undoc),
        SizedBox(child: controller.hundoc),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
          ),
          child: InkWell(
            onTap: () => copyWord(japanese),

            // onTap: () => {
            //   if (ddd()) {getAlertDialog(Text('Got It'), Text('GTT'))}
            // },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(japanese.length, (index) {
                // return Text(
                //   japanese[index],
                //   style: Theme.of(context).textTheme.headline3,
                //   textAlign: TextAlign.center,
                // );
                //    BE ABLE TO CLICK KANGI
                return kangiIndex.contains(index)
                    ? InkWell(
                        onTap: () {
                          print('object');
                        },
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
        SizedBox(child: controller.korea),
      ],
    );
  }
}
