import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/common/widget/kangi_text.dart';
import 'package:japanese_voca/model/kangi.dart';

class KangiRelatedCard extends StatefulWidget {
  const KangiRelatedCard({super.key, required this.kangi});

  final Kangi kangi;

  @override
  State<KangiRelatedCard> createState() => _KangiRelatedCardState();
}

class _KangiRelatedCardState extends State<KangiRelatedCard> {
  int currentIndex = 0;
  bool isShownYomikata = false;
  bool isShownMean = false;
  int count = 0;

  void moveWord(bool isNext) {
    isShownMean = false;
    isShownYomikata = false;
    if (isNext) {
      currentIndex++;

      if (currentIndex >= widget.kangi.relatedVoca.length) {
        getBacks(2);
        return;
      } else {
        setState(
          () {},
        );
      }
    } else {
      currentIndex--;
      if (currentIndex < 0) {
        currentIndex = 0;
        return;
      }
      setState(
        () {},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print('count: ${count}');

    Size size = MediaQuery.of(context).size;
    double sizeBoxWidth = size.width < 500 ? 8 : 16;
    double sizeBoxHight = size.width < 500 ? 16 : 32;
    String japanese = widget.kangi.relatedVoca[currentIndex].word;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: sizeBoxHight),
        Text(
          widget.kangi.relatedVoca[currentIndex].yomikata,
          style: TextStyle(
            fontSize: sizeBoxWidth + 8,
            color: isShownYomikata ? Colors.black : Colors.transparent,
          ),
        ),
        KangiText(
          japanese: japanese,
          clickTwice: true,
          color: Colors.black,
        ),
        SizedBox(height: sizeBoxHight / 2),
        Text(
          widget.kangi.relatedVoca[currentIndex].mean,
          style: TextStyle(
            fontSize: sizeBoxWidth + 8,
            color: isShownMean ? Colors.black : Colors.transparent,
          ),
        ),
        SizedBox(height: sizeBoxHight * 2),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isShownMean)
                  ZoomOut(
                    animate: isShownMean,
                    duration: const Duration(milliseconds: 300),
                    child: SizedBox(
                      width: 100,
                      child: ElevatedButton(
                          onPressed: () => setState((() {
                                isShownMean = !isShownMean;
                              })),
                          child: const Text(
                            '의미',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                    ),
                  )
                else
                  SizedBox(
                    width: 100,
                    child: ElevatedButton(
                        onPressed: () => setState((() {
                              isShownMean = !isShownMean;
                            })),
                        child: const Text(
                          '의미',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ),
                SizedBox(width: sizeBoxWidth),
                if (isShownYomikata)
                  ZoomOut(
                    animate: isShownYomikata,
                    duration: const Duration(milliseconds: 300),
                    child: SizedBox(
                      width: 100,
                      child: ElevatedButton(
                          onPressed: () => setState((() {
                                isShownYomikata = !isShownYomikata;
                              })),
                          child: const Text(
                            '읽는 법',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                    ),
                  )
                else
                  SizedBox(
                    width: 100,
                    child: ElevatedButton(
                        onPressed: () => setState((() {
                              isShownYomikata = !isShownYomikata;
                            })),
                        child: const Text(
                          '읽는 법',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ),
              ],
            ),
            SizedBox(height: sizeBoxWidth),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                      onPressed:
                          currentIndex == 0 ? null : () => moveWord(false),
                      child: const Text(
                        '<',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                ),
                SizedBox(width: sizeBoxWidth),
                SizedBox(
                  width: 100,
                  child: ElevatedButton(
                    onPressed: currentIndex == widget.kangi.relatedVoca.length
                        ? null
                        : () => moveWord(true),
                    child: currentIndex == widget.kangi.relatedVoca.length - 1
                        ? const Text(
                            '나가기',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.redAccent),
                          )
                        : const Text(
                            '>',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: sizeBoxHight * 2),
      ],
    );
  }
}
