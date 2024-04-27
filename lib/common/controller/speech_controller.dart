import 'package:avatar_glow/avatar_glow.dart';
import 'package:change_app_package_name/file_utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/controller/tts_controller.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/config/theme.dart';
import 'package:japanese_voca/model/example.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechBodyWidget extends StatefulWidget {
  const SpeechBodyWidget({super.key, required this.example});

  final Example example;
  @override
  State<SpeechBodyWidget> createState() => _SpeechBodyWidgetState();
}

class _SpeechBodyWidgetState extends State<SpeechBodyWidget> {
  SpeechToText speechToText = SpeechToText();
  var text = "";
  var isListening = false;
  void resetText() {
    setState(() {
      text = "";
    });
  }

  List<int> wrongWordIndex = [];

  @override
  Widget build(BuildContext context) {
    String replacedExWord = widget.example.word.replaceAll('。', '');
    replacedExWord = replacedExWord.replaceAll('、', '');
    replacedExWord = replacedExWord.replaceAll('，', '');
    replacedExWord = replacedExWord.replaceAll('〜', '');

    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Spacer(flex: 1),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Text(
                    replacedExWord,
                    style: TextStyle(
                      fontSize: Responsive.height20,
                      fontWeight: FontWeight.bold,
                      fontFamily: AppFonts.japaneseFont,
                    ),
                  ),
                  Wrap(
                    children: List.generate(
                      text.length,
                      (index) => Text(
                        text[index],
                        style: TextStyle(
                          fontSize: Responsive.height20,
                          color: wrongWordIndex.contains(index)
                              ? Colors.red
                              : Colors.black,
                          fontWeight: FontWeight.w600,
                          fontFamily: AppFonts.japaneseFont,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30), // スペースを追加
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      '듣기',
                    ),
                    SizedBox(height: Responsive.height10 / 2),
                    GetBuilder<TtsController>(builder: (controlelr) {
                      return AvatarGlow(
                        animate: controlelr.isPlaying,
                        duration: const Duration(milliseconds: 2000),
                        glowColor: const Color.fromARGB(255, 47, 38, 38),
                        child: GestureDetector(
                          onTap: () {
                            controlelr.speak(widget.example.word);
                          },
                          onTapUp: (details) {
                            setState(() {
                              isListening = false;
                            });
                            speechToText.stop();
                          },
                          child: CircleAvatar(
                            backgroundColor: const Color(0xff2C2C2C),
                            radius: Responsive.height10 * 3.5,
                            child: FaIcon(
                              controlelr.isPlaying
                                  ? FontAwesomeIcons.volumeLow
                                  : FontAwesomeIcons.volumeOff,
                              color: Colors.white,
                              size: Responsive.height10 * 2.6,
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      '눌러서 말하기',
                    ),
                    SizedBox(height: Responsive.height10 / 2),
                    AvatarGlow(
                      animate: isListening,
                      duration: const Duration(milliseconds: 2000),
                      glowColor: const Color(0xff2C2C2C),
                      child: GestureDetector(
                        onTapDown: (details) async {
                          resetText();
                          if (!isListening) {
                            wrongWordIndex.clear();
                            var available = await speechToText.initialize();
                            if (available) {
                              setState(() {
                                isListening = true;
                                speechToText.listen(
                                  onResult: (result) {
                                    setState(() {
                                      text = result.recognizedWords;
                                    });

                                    if (replacedExWord == text) {
                                      wrongWordIndex.clear();
                                    }
                                    setState(() {});
                                  },
                                  localeId: 'ja_JP', // 日本語の設定
                                );
                              });
                            }
                          }
                        },
                        onTapUp: (details) {
                          setState(() {
                            isListening = false;
                          });
                          speechToText.stop();
                          for (int i = 0; i < text.length; i++) {
                            if (text[i] != replacedExWord[i]) {
                              wrongWordIndex.add(i);
                            }
                          }
                        },
                        child: CircleAvatar(
                          backgroundColor: Color(0xff2C2C2C),
                          radius: Responsive.height10 * 3.5,
                          child: Icon(
                            isListening ? Icons.mic : Icons.mic_none,
                            color: Colors.white,
                            size: Responsive.height10 * 2.6,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
