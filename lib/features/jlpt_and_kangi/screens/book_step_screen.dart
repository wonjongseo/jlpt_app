import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/1.new_app/new_study_category/new_study_category_screen.dart';
import 'package:japanese_voca/common/widget/book_card.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/common/widget/heart_count.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/features/jlpt_and_kangi/jlpt/controller/jlpt_step_controller.dart';
import 'package:japanese_voca/features/jlpt_and_kangi/kangi/controller/kangi_step_controller.dart';
import 'package:japanese_voca/features/jlpt_and_kangi/screens/calendar_step_sceen.dart';
import 'package:japanese_voca/repository/local_repository.dart';
import 'package:japanese_voca/user/controller/user_controller.dart';
import 'package:japanese_voca/common/controller/tts_controller.dart';

import '../../../common/admob/banner_ad/global_banner_admob.dart';
import '../../../common/admob/native_ad/native_ad_widget.dart';
import '../../../common/app_constant.dart';

final String BOOK_STEP_PATH = '/book-step';

// ignore: must_be_immutable
class BookStepScreen extends StatefulWidget {
  late JlptStepController jlptWordController;
  late KangiStepController kangiController;

  final String level;
  final CategoryEnum categoryEnum;

  BookStepScreen({super.key, required this.level, required this.categoryEnum}) {
    if (categoryEnum == CategoryEnum.Japaneses) {
      jlptWordController = Get.put(JlptStepController(level: level));
    } else {
      kangiController = Get.put(KangiStepController(level: level));
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
    } else {
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
    print('dis');
    LocalReposotiry.putCurrentProgressing(
        '${widget.categoryEnum.name}-${widget.level}', isProgrssing);
    super.dispose();
  }

  CarouselController buttonCarouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    bool isJapanese = widget.categoryEnum == CategoryEnum.Japaneses;
    return CarouselSlider(
        carouselController: buttonCarouselController,
        options: CarouselOptions(
          height: 400,
          // disableCenter: true,
          enableInfiniteScroll: false,
          initialPage: isProgrssing,
          enlargeCenterPage: true,
          onPageChanged: (index, reason) {
            isProgrssing = index;
          },
          scrollDirection: Axis.horizontal,
        ),
        items: List.generate(
            isJapanese
                ? widget.jlptWordController.headTitleCount
                : widget.kangiController.headTitleCount, (index) {
          return InkWell(
            onTap: () {
              if (isProgrssing == index) {
                LocalReposotiry.putCurrentProgressing(
                    '${widget.categoryEnum.name}-${widget.level}',
                    isProgrssing);
                goTo(index, '챕터${index + 1}');
              } else if (isProgrssing < index) {
                isProgrssing++;
                buttonCarouselController.animateToPage(isProgrssing);
              } else {
                isProgrssing--;
                buttonCarouselController.animateToPage(isProgrssing);
              }
              setState(() {});
            },
            child: Card(
              child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Center(
                          child: Text(
                            'Chapter ${(index + 1)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Responsive.height10 * 3,
                              color: Colors.cyan.shade700,
                            ),
                          ),
                        ),
                        if (isProgrssing == index)
                          Positioned(
                            bottom: 5,
                            right: 5,
                            child: Card(
                              shape: const CircleBorder(),
                              child: Container(
                                height: Responsive.height10 * 3,
                                width: Responsive.height10 * 3,
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
        }));
    return GridView.builder(
      itemCount: isJapanese
          ? widget.jlptWordController.headTitleCount
          : widget.kangiController.headTitleCount,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 5.0,
        mainAxisSpacing: 5.0,
      ),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            isProgrssing = LocalReposotiry.putCurrentProgressing(
                '${widget.categoryEnum.name}-${widget.level}', index);

            goTo(index, '챕터${index + 1}');
            setState(() {});
          },
          child: Card(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Text(
                  ' ${(index + 1)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                if (isProgrssing == index)
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: Container(
                      height: 12,
                      width: 12,
                      decoration: BoxDecoration(
                          color: AppColors.lightGreen,
                          borderRadius: BorderRadius.circular(15)),
                    ),
                  )
              ],
            ),
          )),
        );
      },
    );
  }
}
