import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/features/grammar_step/services/grammar_controller.dart';
import 'package:japanese_voca/features/jlpt_and_kangi/jlpt/controller/jlpt_step_controller.dart';
import 'package:japanese_voca/features/jlpt_and_kangi/kangi/controller/kangi_step_controller.dart';
import 'package:japanese_voca/features/jlpt_and_kangi/screens/calendar_step_sceen.dart';
import 'package:japanese_voca/features/jlpt_home/screens/jlpt_home_screen.dart';
import 'package:japanese_voca/repository/local_repository.dart';
import 'package:japanese_voca/user/controller/user_controller.dart';

final String BOOK_STEP_PATH = '/book-step';

// ignore: must_be_immutable
class BookStepScreen extends StatefulWidget {
  late JlptStepController jlptWordController;
  late KangiStepController kangiController;
  late GrammarController grammarController;
  final String level;
  final CategoryEnum categoryEnum;

  BookStepScreen({super.key, required this.level, required this.categoryEnum}) {
    if (categoryEnum == CategoryEnum.Japaneses) {
      jlptWordController = Get.put(JlptStepController(level: level));
    } else if (categoryEnum == CategoryEnum.Kangis) {
      kangiController = Get.put(KangiStepController(level: level));
    } else {
      grammarController = Get.put(GrammarController(level: level));
    }
  }

  @override
  State<BookStepScreen> createState() => _BookStepScreenState();
}

class _BookStepScreenState extends State<BookStepScreen> {
  int isProgrssing = 0;
  UserController userController = Get.find<UserController>();

  void goTo(int index, String chapter) {
    if (widget.categoryEnum == CategoryEnum.Japaneses) {
      Get.toNamed(JLPT_CALENDAR_STEP_PATH,
          arguments: {'chapter': chapter, 'categoryEnum': widget.categoryEnum});
    } else if (widget.categoryEnum == CategoryEnum.Kangis) {
      Get.toNamed(JLPT_CALENDAR_STEP_PATH,
          arguments: {'chapter': chapter, 'categoryEnum': widget.categoryEnum});
    } else {
      widget.grammarController.setStep(index);
      Get.toNamed(JLPT_CALENDAR_STEP_PATH,
          arguments: {'chapter': chapter, 'categoryEnum': widget.categoryEnum});
    }
  }

  @override
  void initState() {
    super.initState();
    isProgrssing = LocalReposotiry.getCurrentProgressing(
        '${widget.categoryEnum.name}-${widget.level}');
  }

  @override
  void dispose() {
    LocalReposotiry.putCurrentProgressing(
        '${widget.categoryEnum.name}-${widget.level}', isProgrssing);
    super.dispose();
  }

  CarouselController carouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    int len = 0;
    switch (widget.categoryEnum) {
      case CategoryEnum.Japaneses:
        len = widget.jlptWordController.headTitleCount;
        break;
      case CategoryEnum.Kangis:
        len = widget.kangiController.headTitleCount;
        break;
      case CategoryEnum.Grammars:
        len = widget.grammarController.grammers.length;
        break;
    }

    return CarouselSlider(
      carouselController: carouselController,
      options: CarouselOptions(
        height: 400,
        enableInfiniteScroll: false,
        initialPage: isProgrssing,
        enlargeCenterPage: true,
        onPageChanged: (index, reason) {
          isProgrssing = index;
        },
        scrollDirection: Axis.horizontal,
      ),
      items: List.generate(
        len,
        (index) {
          bool isAllAccessable = !(widget.level == '1' && index > 2);
          return InkWell(
            onTap: () {
              if (!isAllAccessable) {
                Get.dialog(AlertDialog(
                  shape: Border.all(width: 1, color: AppColors.mainColor),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'JLPT N1을 더 학습하고 싶으시면',
                          children: [
                            TextSpan(
                              text: '\nJLPT 종각앱 Plus',
                              style: TextStyle(
                                color: AppColors.mainColor,
                                fontSize: Responsive.width20,
                              ),
                            ),
                            const TextSpan(
                              text: '를 이용해주세요',
                            )
                          ],
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: Responsive.width18,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      // Image.asset('assets/images/my_avator.jpeg'),
                      SizedBox(height: Responsive.height40),
                      TextButton(
                        onPressed: () async {
                          if (GetPlatform.isIOS) {
                            launchUrl(Uri.parse(
                                'https://apps.apple.com/app/id6450434849'));
                          } else if (GetPlatform.isAndroid) {
                            launchUrl(Uri.parse(
                                'https://play.google.com/store/apps/details?id=com.wonjongseo.jlpt_jonggack_plus'));
                          } else {
                            launchUrl(Uri.parse(
                                'https://apps.apple.com/app/id6450434849'));
                          }
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(0, 0),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: const Text('JLPT 종각 Plus 다운로드 하러가기 →'),
                      )
                    ],
                  ),
                ));
                return;
              }
              if (isProgrssing == index) {
                LocalReposotiry.putCurrentProgressing(
                    '${widget.categoryEnum.name}-${widget.level}',
                    isProgrssing);
                goTo(index, '챕터${index + 1}');
              } else if (isProgrssing < index) {
                isProgrssing++;
                carouselController.animateToPage(isProgrssing);
              } else {
                isProgrssing--;
                carouselController.animateToPage(isProgrssing);
              }
              setState(() {});
            },
            child: Card(
              color: !isAllAccessable ? Colors.grey.shade400 : Colors.white,
              child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Center(
                          child: RichText(
                            text: TextSpan(
                              text: '${widget.categoryEnum.id}\n',
                              children: [
                                TextSpan(
                                  text: 'Chapter ${(index + 1)}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: Responsive.height10 * 3,
                                  ),
                                )
                              ],
                              style: TextStyle(
                                fontFamily: 'GMarket',
                                fontWeight: FontWeight.bold,
                                fontSize: Responsive.height10 * 2.3,
                                color: isAllAccessable
                                    ? AppColors.mainColor
                                    : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        if (!isAllAccessable)
                          Align(
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.lock,
                              size: 100,
                            ),
                          ),
                        if (isProgrssing == index)
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: Card(
                              shape: const CircleBorder(),
                              child: Container(
                                height: Responsive.height10 * 2,
                                width: Responsive.height10 * 2,
                                decoration: BoxDecoration(
                                  color: AppColors.lightGreen,
                                  borderRadius: BorderRadius.circular(
                                    Responsive.height10 * 1.5,
                                  ),
                                ),
                              ),
                            ),
                          )
                      ],
                    ),
                  )),
            ),
          );
        },
      ),
    );
  }
}
