// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/screen/setting/setting_screen.dart';
import 'package:japanese_voca/screen/user/controller/user_controller.dart';
import 'package:japanese_voca/tts_controller.dart';

import '../common/admob/banner_ad/global_banner_admob.dart';
import '../model/word.dart';
import 'jlpt_and_kangi/jlpt/controller/jlpt_step_controller.dart';

class WordListenController extends GetxController {
  List<Word> words = [];

  final String chapter;

  // final String level;

  JlptStepController jlptWordController = Get.find<JlptStepController>();
  WordListenController({required this.chapter});

  @override
  void onInit() {
    super.onInit();
    words = jlptWordController.jlptStepRepositroy
        .correctData(jlptWordController.level, chapter);
    update();
  }
}

// ignore: must_be_immutable
class WordListenScreen extends StatelessWidget {
// // MUST
  TtsController ttsController = Get.put(TtsController());

  WordListenController wordListenController = Get.find<WordListenController>();

  WordListenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${wordListenController.chapter} 반복 듣기'),
      ),
      body: SafeArea(
        child: GetBuilder<WordListenController>(builder: (wController) {
          return wController.words.isEmpty
              ? Container()
              : GetBuilder<TtsController>(builder: (tController) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Align(
                          alignment: Alignment.center,
                          child: OutlinedButton(
                            child: Text(
                              tController.isAutoPlay ? "멈추기 " : "자동 듣기",
                              style: const TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              if (tController.isAutoPlay) {
                                ttsController.autuPlayStop();
                              } else {
                                ttsController
                                    .startListenWords(wordListenController);
                              }
                            },
                          ),
                        ),
                      ),
                      const Spacer(),
                      Expanded(
                        flex: 12,
                        child: Row(
                          children: [
                            Expanded(
                              flex: 12,
                              child: PageView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                onPageChanged: ttsController.onPageChange,
                                controller: ttsController.pageController,
                                itemCount: wController.words.length,
                                itemBuilder: (context, index) {
                                  ttsController.newWord = wController
                                      .words[ttsController.currentPageIndex];

                                  String mean = ttsController.newWord!.mean;
                                  String word = ttsController.newWord!.word;
                                  String yomikata =
                                      ttsController.newWord!.yomikata;
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(yomikata,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white)),
                                      Text(
                                        word,
                                        style: Theme.of(context)
                                            .textTheme
                                            .displaySmall
                                            ?.copyWith(
                                              fontSize: 45,
                                              color: Colors.white,
                                            ),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 15),
                                      Text(
                                        mean,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    '${(ttsController.currentPageIndex) + 1} 번째'),
                                Text('총 ${wordListenController.words.length}개')
                              ],
                            ),
                          ),
                          Slider(
                              label:
                                  '챕터 ${(((ttsController.currentPageIndex) / 15)).ceil() + 1}',
                              divisions:
                                  wordListenController.words.length ~/ 15,
                              min: 0,
                              max:
                                  wordListenController.words.length.toDouble() -
                                      1,
                              value: ttsController.currentPageIndex.toDouble(),
                              onChanged: (v) {
                                ttsController.onPageChange(v.toInt());
                              }),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                                onPressed: ttsController.ttsState ==
                                        TtsState.playing
                                    ? null
                                    : () {
                                        if (ttsController.currentPageIndex >
                                            0) {
                                          ttsController.currentPageIndex--;

                                          ttsController.onPageChange(
                                              ttsController.currentPageIndex);
                                        } else {
                                          return;
                                        }
                                      },
                                child: const Text(
                                  '<',
                                  style: TextStyle(
                                    color: AppColors.whiteGrey,
                                  ),
                                )),
                            _buildButtonColumn(
                              Colors.red,
                              Colors.redAccent,
                              Icons.stop,
                              'STOP',
                              ttsController.stop,
                            ),
                            _buildButtonColumn(
                              Colors.green,
                              Colors.greenAccent,
                              Icons.play_arrow,
                              'PLAY',
                              () {
                                if (ttsController.newWord != null) {
                                  ttsController
                                      .japaneseSpeak(ttsController.newWord!);
                                }
                              },
                            ),
                            _buildButtonColumn(
                              Colors.blue,
                              Colors.blueAccent,
                              Icons.pause,
                              'PAUSE',
                              ttsController.pause,
                            ),
                            TextButton(
                              onPressed: ttsController.ttsState ==
                                      TtsState.playing
                                  ? null
                                  : () {
                                      if (ttsController.currentPageIndex <
                                          wordListenController.words.length -
                                              1) {
                                        ttsController.currentPageIndex++;

                                        ttsController.onPageChange(
                                            ttsController.currentPageIndex);
                                      } else {
                                        return;
                                      }
                                    },
                              child: const Text(
                                '>',
                                style: TextStyle(
                                  color: AppColors.whiteGrey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GetBuilder<UserController>(builder: (userController) {
                        return SoundOptionColumn(
                            userController: userController);
                      }),
                      if (ttsController.isAndroid)
                        _getMaxSpeechInputLengthSection(),
                      const Spacer(),
                    ],
                  );
                });
        }),
      ),
      bottomNavigationBar: const GlobalBannerAdmob(),
    );
  }

  Column _buildButtonColumn(Color color, Color splashColor, IconData icon,
      String label, Function func) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
              icon: Icon(icon),
              color: color,
              splashColor: splashColor,
              onPressed: () => func()),
          Container(
            margin: const EdgeInsets.only(top: 8.0),
            child: Text(
              label,
              style: TextStyle(
                  fontSize: 12.0, fontWeight: FontWeight.w400, color: color),
            ),
          )
        ]);
  }

  Widget _getMaxSpeechInputLengthSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          child: Text('Get max speech input length'),
          onPressed: () async {
            ttsController.inputLength =
                await ttsController.flutterTts.getMaxSpeechInputLength;
            // setState(() {});
          },
        ),
        Text("$ttsController.inputLength characters"),
      ],
    );
  }
}

class SoundOptionColumn extends StatelessWidget {
  const SoundOptionColumn({
    super.key,
    required this.userController,
  });

  final UserController userController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SoundSettingSlider(
          activeColor: Colors.redAccent,
          option: '음량',
          value: userController.volumn,
          label: '음량: ${userController.volumn}',
          onChangeEnd: (value) {
            userController.updateSoundValues(SOUND_OPTIONS.VOLUMN, value);
          },
          onChanged: (value) {
            userController.onChangedSoundValues(SOUND_OPTIONS.VOLUMN, value);
          },
        ),
        SoundSettingSlider(
          activeColor: Colors.blueAccent,
          option: '음조',
          value: userController.pitch,
          label: '음조: ${userController.pitch}',
          onChangeEnd: (value) {
            userController.updateSoundValues(SOUND_OPTIONS.PITCH, value);
          },
          onChanged: (value) {
            userController.onChangedSoundValues(SOUND_OPTIONS.PITCH, value);
          },
        ),
        SoundSettingSlider(
          activeColor: Colors.deepPurpleAccent,
          option: '속도',
          value: userController.rate,
          label: '속도: ${userController.rate}',
          onChangeEnd: (value) {
            userController.updateSoundValues(SOUND_OPTIONS.RATE, value);
          },
          onChanged: (value) {
            userController.onChangedSoundValues(SOUND_OPTIONS.RATE, value);
          },
        ),
      ],
    );
  }
}
