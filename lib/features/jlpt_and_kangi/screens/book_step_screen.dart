import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:japanese_voca/common/commonDialog.dart';
import 'package:japanese_voca/config/theme.dart';
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
  int progrssingIndex = 0;
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

//Chapter5-OutStep-Index
  @override
  void initState() {
    super.initState();
    progrssingIndex = LocalReposotiry.getCurrentProgressing(
        '${widget.categoryEnum.name}-${widget.level}');
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

    return GetBuilder<UserController>(builder: (controller) {
      return CarouselSlider(
        carouselController: carouselController,
        options: CarouselOptions(
          enableInfiniteScroll: false,
          disableCenter: true,
          initialPage: progrssingIndex,
          enlargeCenterPage: true,
          onPageChanged: (index, reason) {
            progrssingIndex = index;
          },
          scrollDirection: Axis.horizontal,
        ),
        items: List.generate(
          len,
          (index) {
            bool isAllAccessable = !(widget.level == '1' && index > 2) ||
                controller.user.isPremieum ||
                controller.user.isTrik;
            return InkWell(
              onLongPress: () {
                if (isAllAccessable) {
                  return;
                }
                userController.changeUserAuth();
              },
              onTap: () {
                if (!isAllAccessable) {
                  CommonDialog.appealDownLoadThePaidVersion();

                  return;
                }
                if (progrssingIndex == index) {
                  LocalReposotiry.putCurrentProgressing(
                      '${widget.categoryEnum.name}-${widget.level}',
                      progrssingIndex);
                  goTo(index, '챕터${index + 1}');
                } else if (progrssingIndex < index) {
                  progrssingIndex++;
                  carouselController.animateToPage(progrssingIndex);
                } else {
                  progrssingIndex--;
                  carouselController.animateToPage(progrssingIndex);
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
                                  fontFamily: AppFonts.gMaretFont,
                                  fontWeight: FontWeight.bold,
                                  fontSize: Responsive.height10 * 2.3,
                                  color: isAllAccessable
                                      ? AppColors.mainBordColor
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          if (!isAllAccessable)
                            const Align(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.lock,
                                size: 100,
                              ),
                            ),
                          if (progrssingIndex == index)
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
    });
  }
}
