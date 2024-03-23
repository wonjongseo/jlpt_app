import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/app_constant.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/common/widget/kangi_text.dart';
import 'package:japanese_voca/model/kangi.dart';
import 'package:japanese_voca/features/setting/services/setting_controller.dart';
import 'package:japanese_voca/common/controller/tts_controller.dart';

import '../../../../config/colors.dart';
import '../../../../config/theme.dart';
import '../../../../model/my_word.dart';

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

  SettingController settingController = Get.find<SettingController>();
  // TtsController ttsController = Get.put(TtsController());

  void moveWord(bool isNext) {
    isShownMean = false;
    isShownYomikata = false;
    if (isNext) {
      currentIndex++;

      if (currentIndex >= widget.kangi.relatedVoca.length) {
        getBacks(1);
        return;
      } else {
        setState(() {});
      }
    } else {
      currentIndex--;
      if (currentIndex < 0) {
        currentIndex = 0;
        return;
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double sizeBoxWidth = size.width < 550 ? 8 : 16;
    double sizeBoxHight = size.width < 550 ? 16 : 32;
    String japanese = widget.kangi.relatedVoca[currentIndex].word;
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.kangi.korea,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: AppColors.scaffoldBackground,
                fontSize: 20,
              ),
            ),
            IconButton(
              onPressed: () {
                MyWord.saveToMyVoca(widget.kangi.relatedVoca[currentIndex]);
              },
              icon: const Icon(Icons.save_alt),
            ),
          ],
        ),
        // 읽는 법
        Container(
            height: 20,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: GetBuilder<TtsController>(
              builder: (ttsController) {
                return ttsController.isPlaying
                    ? const Align(
                        alignment: Alignment.bottomCenter,
                        child: SpinKitWave(
                          size: 20,
                          color: Colors.black,
                        ))
                    : const SizedBox(
                        height: 20,
                      );
              },
            )),
        Text(
          widget.kangi.relatedVoca[currentIndex].yomikata,
          style: TextStyle(
            fontSize: sizeBoxWidth + 8,
            color: isShownYomikata
                ? AppColors.scaffoldBackground
                : Colors.transparent,
            fontWeight: FontWeight.w600,
            fontFamily: AppFonts.japaneseFont,
          ),
        ),

        KangiText(
          japanese: japanese,
          clickTwice: true,
          color: AppColors.scaffoldBackground,
        ),
        SizedBox(height: sizeBoxHight / 2),
        Text(
          widget.kangi.relatedVoca[currentIndex].mean,
          style: TextStyle(
            fontSize: sizeBoxWidth + 8,
            color:
                isShownMean ? AppColors.scaffoldBackground : Colors.transparent,
          ),
        ),
        SizedBox(height: sizeBoxHight * 1.5),
        GetBuilder<TtsController>(builder: (ttsController) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ZoomOut(
                    animate: isShownMean,
                    duration: const Duration(milliseconds: 300),
                    child: SizedBox(
                      width: threeWordButtonWidth,
                      child: ElevatedButton(
                          onPressed: isShownMean || ttsController.disalbe
                              ? null
                              : () async {
                                  setState((() {
                                    isShownMean = !isShownMean;
                                  }));
                                },
                          child: const Text(
                            '의미',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                    ),
                  ),
                  SizedBox(width: sizeBoxWidth),
                  // if (isShownYomikata)
                  ZoomOut(
                    animate: isShownYomikata,
                    duration: const Duration(milliseconds: 300),
                    child: SizedBox(
                      width: threeWordButtonWidth,
                      child: ElevatedButton(
                          onPressed: isShownYomikata || ttsController.disalbe
                              ? null
                              : () async {
                                  setState((() {
                                    isShownYomikata = !isShownYomikata;
                                  }));
                                },
                          child: const Text(
                            '읽는 법',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                    ),
                  )
                ],
              ),
              SizedBox(height: sizeBoxWidth),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: threeWordButtonWidth,
                    child: ElevatedButton(
                        onPressed: ttsController.disalbe || currentIndex == 0
                            ? null
                            : () => moveWord(false),
                        child: const Text(
                          '<',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ),
                  SizedBox(width: sizeBoxWidth),
                  SizedBox(
                    width: threeWordButtonWidth,
                    child: ElevatedButton(
                      onPressed: ttsController.disalbe ||
                              currentIndex == widget.kangi.relatedVoca.length
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
          );
        }),
        SizedBox(height: sizeBoxHight),
      ],
    );
  }
}
