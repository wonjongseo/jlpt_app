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
          padding: EdgeInsets.symmetric(
            vertical: Responsive.height11,
            horizontal: Responsive.width14,
          ),
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
              SizedBox(height: Responsive.height15),
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
                            fontSize: Responsive.height18,
                            fontWeight: FontWeight.w800,
                            fontFamily: AppFonts.japaneseFont,
                          ),
                        ),
                        Text(
                          '훈독 :  ${kangi.hundoc}',
                          style: TextStyle(
                            fontSize: Responsive.height18,
                            fontWeight: FontWeight.w800,
                            fontFamily: AppFonts.japaneseFont,
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
                  fontSize: Responsive.height10 * 1.8,
                  color: Colors.cyan.shade700,
                ),
              ),
              Container(
                width: double.infinity,
                height: Responsive.height10 * 5,
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
                            Get.to(
                              () => Scaffold(
                                appBar: AppBar(),
                                body: WordCard(word: kangi.relatedVoca[index2]),
                              ),
                              preventDuplicates: false,
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: Responsive.width16 / 4,
                            ),
                            decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.black, width: 1.5)),
                            ),
                            child: Text(
                              kangi.relatedVoca[index2].word,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontFamily: AppFonts.japaneseFont,
                                fontSize: Responsive.height10 * 2.2,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: Responsive.height10 * 3),
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
                    fontSize: Responsive.height10 * 1.8,
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
