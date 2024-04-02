import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/features/jlpt_and_kangi/kangi/controller/kangi_step_controller.dart';
import 'package:kanji_drawing_animation/kanji_drawing_animation.dart';

import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/theme.dart';
import 'package:japanese_voca/features/jlpt_study/widgets/word_card.dart';
import 'package:japanese_voca/features/kangi_study/controller/kangi_study_controller.dart';
import 'package:japanese_voca/model/kangi.dart';

// ignore: must_be_immutable
class KangiCard extends StatelessWidget {
  KangiCard({
    Key? key,
    required this.kangi,
    this.controller,
  }) : super(key: key);
  final Kangi kangi;
  KangiStepController? controller;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    kangi.japan,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Responsive.height60,
                      color: Colors.black,
                      fontFamily: AppFonts.japaneseFont,
                    ),
                  ),
                  if (controller != null)
                    !controller!.isSavedInLocal(kangi)
                        ? IconButton(
                            onPressed: () {
                              controller!.toggleSaveWord(kangi);
                            },
                            icon: FaIcon(
                              FontAwesomeIcons.bookmark,
                              color: Colors.cyan.shade700,
                            ),
                          )
                        : IconButton(
                            onPressed: () {
                              controller!.toggleSaveWord(kangi);
                            },
                            icon: FaIcon(
                              FontAwesomeIcons.solidBookmark,
                              color: Colors.cyan.shade700,
                            ),
                          )
                ],
              ),
              Text(
                kangi.korea,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Responsive.height25,
                ),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '음독 :  ${kangi.undoc}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Responsive.height18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '훈독 :  ${kangi.hundoc}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Responsive.height18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(),
              const SizedBox(height: 30),
              Text(
                '연관 단어',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.cyan.shade700,
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                decoration: const BoxDecoration(color: Colors.grey),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      kangi.relatedVoca.length,
                      (index2) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: InkWell(
                          onTap: () {
                            print('22222');
                            Get.to(
                              () => Scaffold(
                                appBar: AppBar(),
                                body: WordCard(word: kangi.relatedVoca[index2]),
                              ),
                              preventDuplicates: false,
                            );
                            // Get.to(
                            //   () => Scaffold(
                            //     appBar: AppBar(),
                            //     body: VocaCard(
                            //       word: kangi.relatedVoca[index2],
                            //     ),
                            //   ),
                            // );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                            ),
                            decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.black, width: 2)),
                            ),
                            child: Text(
                              kangi.relatedVoca[index2].word,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              InkWell(
                onTap: () {
                  Get.bottomSheet(SizedBox(
                    width: double.infinity,
                    child: KanjiDrawingAnimation(kangi.japan, speed: 60),
                  ));
                },
                child: Text(
                  '획순 보기',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.cyan.shade700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
