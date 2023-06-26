import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/tts_controller.dart';

import '../jlpt_study_controller_temp.dart';

class JlptStudyButtonsTemp extends StatelessWidget {
  const JlptStudyButtonsTemp({
    Key? key,
    required this.wordController,
  }) : super(key: key);

  final JlptStudyControllerTemp wordController;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double buttonWidth = size.width * 0.29;
    return GetBuilder<TtsController>(builder: (ttsController) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ZoomOut(
                animate: wordController.isShownYomikata,
                duration: const Duration(milliseconds: 300),
                child: SizedBox(
                  width: buttonWidth,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      disabledBackgroundColor: Colors.white.withOpacity(0.5),
                    ),
                    onPressed: ttsController.disalbe
                        ? null
                        : () {
                            if (!wordController.isShownYomikata) {
                              wordController.showYomikata();
                            }
                          },
                    child: const Text(
                      '읽는 법',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: buttonWidth,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    disabledBackgroundColor: Colors.white.withOpacity(0.5),
                  ),
                  onPressed: ttsController.disalbe
                      ? null
                      : () async {
                          await wordController.nextWord(false);
                        },
                  child: const Text(
                    '몰라요',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: buttonWidth,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    disabledBackgroundColor: Colors.white.withOpacity(0.5),
                  ),
                  onPressed: !wordController.isShownYomikata &&
                          !wordController.isShownMean
                      ? null
                      : () async {
                          if (wordController.isShownYomikata) {
                            print('asdfasdf');
                            await wordController.speakYomikata();
                          }
                          await Future.delayed(
                              const Duration(microseconds: 100));
                          if (wordController.isShownMean) {
                            print('asdfasdf');
                            await wordController.speakMean();
                          }
                        },
                  child: Text(
                    '듣기',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              // const SizedBox(width: 5),
              SizedBox(
                width: buttonWidth,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    disabledBackgroundColor: Colors.white.withOpacity(0.5),
                  ),
                  onPressed: ttsController.disalbe
                      ? null
                      : () async {
                          await wordController.nextWord(true);
                        },
                  child: const Text(
                    '알아요',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ZoomOut(
                animate: wordController.isShownMean,
                duration: const Duration(milliseconds: 300),
                child: SizedBox(
                  width: buttonWidth,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      disabledBackgroundColor: Colors.white.withOpacity(0.5),
                    ),
                    onPressed: ttsController.disalbe
                        ? null
                        : () {
                            if (!wordController.isShownMean) {
                              wordController.showMean();
                            }
                          },
                    child: const Text(
                      '의미',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      );
    });
  }
}
