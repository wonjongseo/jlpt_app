import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/admob/banner_ad/global_banner_admob.dart';
import 'package:japanese_voca/common/widget/calendar_card.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/features/jlpt_and_kangi/jlpt/controller/jlpt_step_controller.dart';
import 'package:japanese_voca/features/jlpt_and_kangi/kangi/controller/kangi_step_controller.dart';
import 'package:japanese_voca/features/jlpt_study/jlpt_study_controller.dart';
import 'package:japanese_voca/features/jlpt_study/screens/jlpt_study_sceen.dart';
import 'package:japanese_voca/model/jlpt_step.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/model/word.dart';
import 'package:japanese_voca/repository/my_word_repository.dart';
import 'package:japanese_voca/user/controller/user_controller.dart';

import '../../../common/widget/heart_count.dart';

const String JLPT_CALENDAR_STEP_PATH = '/jlpt-calendar-step';

// ignore: must_be_immutable
class CalendarStepSceen extends StatefulWidget {
  late JlptStepController jlptWordController;
  late KangiStepController kangiController;
  late String chapter;

  // late bool isSeenTutorial;
  late bool isJlpt;

  CalendarStepSceen({super.key}) {
    isJlpt = Get.arguments['isJlpt'];
    if (isJlpt) {
      jlptWordController = Get.find<JlptStepController>();
      chapter = Get.arguments['chapter'];
      jlptWordController.setJlptSteps(chapter);
    } else {
      kangiController = Get.find<KangiStepController>();
      chapter = Get.arguments['chapter'];
      kangiController.setKangiSteps(chapter);
    }
  }

  @override
  State<CalendarStepSceen> createState() => _CalendarStepSceenState();
}

class _CalendarStepSceenState extends State<CalendarStepSceen> {
  int currChapNumber = 0;
  UserController userController = Get.find<UserController>();

  late PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: currChapNumber);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isJlpt) {
      return Scaffold(
        bottomNavigationBar: const GlobalBannerAdmob(),
        appBar: AppBar(
          title: Text(
            'JLPT N${widget.jlptWordController.level} 단어 - ${widget.chapter}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Responsive.height14,
            ),
          ),
          actions: const [HeartCount()],
        ),
        body: SafeArea(
          child: GetBuilder<JlptStepController>(builder: (controller) {
            return Center(
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        controller.jlptSteps.length,
                        (index) {
                          bool isEnabled = false;

                          if (index == 0) {
                            isEnabled = true;
                          } else {
                            isEnabled = controller.userController
                                    .isUserFake() ||
                                (controller.jlptSteps[index - 1].isFinished ??
                                    false);
                          }

                          return Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: InkWell(
                              onTap: () {
                                if (!isEnabled) return;
                                currChapNumber = index;
                                pageController.animateToPage(currChapNumber,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeIn);

                                controller.setStep(index);
                                print(
                                    'controller.getJlptStep() : ${controller.getJlptStep()}');
                                ;
                                setState(() {});
                              },
                              child: Card(
                                color: isEnabled
                                    ? Colors.cyan.shade400
                                    : Colors.grey.shade300,
                                child: Container(
                                  width: Responsive.height10 * 8.5, //
                                  height: Responsive.height10 * 4.5,
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                    child: controller
                                                .jlptSteps[index].isFinished ??
                                            false
                                        ? const Icon(
                                            Icons.star,
                                            color: AppColors.primaryColor,
                                          )
                                        : isEnabled
                                            ? const FaIcon(
                                                FontAwesomeIcons.lockOpen,
                                                size: 16,
                                              )
                                            : FaIcon(
                                                FontAwesomeIcons.lock,
                                                color: Colors.grey.shade500,
                                                size: 16,
                                              ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    // color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '다음 단계 자물쇠 풀기→',
                          style: TextStyle(
                            fontSize: Responsive.height14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Card(
                          shape: const CircleBorder(),
                          child: InkWell(
                            onTap: () {
                              JlptStudyController jlptStudyController =
                                  Get.find<JlptStudyController>();

                              jlptStudyController.goToTest();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                '퀴즈!',
                                style: TextStyle(
                                  fontSize: Responsive.height14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: PageView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: pageController,
                        itemCount: controller.jlptSteps.length,
                        itemBuilder: (context, subStep) {
                          controller.setStep(subStep);
                          JlptStep jlptStep = controller.getJlptStep();
                          Get.put(JlptStudyController());
                          // bool isSaved =

                          return SingleChildScrollView(
                            child: Column(
                              children: List.generate(
                                jlptStep.words.length,
                                (index) {
                                  return BBBB(
                                    word: jlptStep.words[index],
                                    index: index,
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
        ),
        // body: Padding(
        //   padding: EdgeInsets.all(Responsive.height16 / 2),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.center,
        //     children: [
        //       Expanded(
        //         child: GetBuilder<JlptStepController>(builder: (controller) {
        //           return ListView.builder(
        //             itemCount: controller.jlptSteps.length,
        //             itemBuilder: (context, subStep) {
        //               if (subStep == 0) {
        //                 return CalendarCard(
        //                   isAabled: true,
        //                   jlptStep: controller.jlptSteps[subStep],
        //                   onTap: () {
        //                     controller.setStep(subStep);
        //                     Get.toNamed(JLPT_STUDY_PATH);
        //                   },
        //                 );
        //               }

        //               return CalendarCard(
        //                 isAabled: controller.userController.isUserFake() ||
        //                     (controller.jlptSteps[subStep - 1].isFinished ??
        //                         false),
        //                 jlptStep: controller.jlptSteps[subStep],
        //                 onTap: () {
        //                   // 무료버전일 경우.
        //                   if (!controller.restrictN1SubStep(subStep)) {
        //                     controller.goToStudyPage(subStep);
        //                   }
        //                 },
        //               );
        //             },
        //           );
        //         }),
        //       ),
        //     ],
        //   ),
        // ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'JLPT N${widget.kangiController.level} 한자 - ${widget.chapter}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: const [HeartCount()],
      ),
      bottomNavigationBar: const GlobalBannerAdmob(),
      body: GetBuilder<KangiStepController>(builder: (controller) {
        return ListView.builder(
          itemCount: controller.kangiSteps.length,
          itemBuilder: (context, subStep) {
            if (subStep == 0) {
              return KangiCalendarCard(
                isAabled: true,
                kangiStep: controller.kangiSteps[subStep],
                onTap: () => widget.kangiController.goToStudyPage(subStep),
              );
            }
            return KangiCalendarCard(
              isAabled: controller.kangiSteps[subStep - 1].isFinished ?? false,
              kangiStep: controller.kangiSteps[subStep],
              onTap: () {
                if (!widget.kangiController.restrictN1SubStep(subStep)) {
                  widget.kangiController.goToStudyPage(subStep);
                }
              },
            );
          },
        );
        // return GridView.builder(
        //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        //     crossAxisCount: 2,
        //     crossAxisSpacing: 10.0,
        //     mainAxisSpacing: 5.0,
        //   ),
        //   itemCount: controller.kangiSteps.length,
        //   itemBuilder: (context, subStep) {
        //     if (subStep == 0) {
        //       return KangiCalendarCard(
        //         isAabled: true,
        //         kangiStep: controller.kangiSteps[subStep],
        //         onTap: () => kangiController.goToStudyPage(subStep),
        //       );
        //     }
        //     return KangiCalendarCard(
        //       isAabled: controller.kangiSteps[subStep - 1].isFinished ?? false,
        //       kangiStep: controller.kangiSteps[subStep],
        //       onTap: () {
        //         if (!kangiController.restrictN1SubStep(subStep)) {
        //           kangiController.goToStudyPage(subStep);
        //         }
        //       },
        //     );
        //   },
        // );
      }),
    );
  }
}

class BBBB extends StatefulWidget {
  const BBBB({
    super.key,
    required this.word,
    required this.index,
  });
  final int index;
  final Word word;

  @override
  State<BBBB> createState() => _BBBBState();
}

class _BBBBState extends State<BBBB> {
  bool isWordSaved = false;
  late MyWord newMyWord;
  int savedWordCnt = 0;
  UserController userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    newMyWord = MyWord.wordToMyWord(widget.word);
    newMyWord.createdAt = DateTime.now();
    isWordSaved = MyWordRepository.savedInMyWordInLocal(newMyWord);
  }

  @override
  void dispose() {
    super.dispose();
    // userController.updateCountWordOfUser(false, savedWordCnt);
  }

  @override
  Widget build(BuildContext context) {
    String mean = widget.word.mean;

    if (widget.word.mean.contains('1.')) {
      mean = '${(widget.word.mean.split('\n')[0]).split('1.')[1]}...';
    }
    return InkWell(
      onTap: () => Get.to(() => JlptStudyScreen(currentIndex: widget.index)),
      child: Container(
        decoration: BoxDecoration(border: Border.all(width: 0.3)),
        child: ListTile(
          dense: true,
          // isThreeLine: true,
          minLeadingWidth: 100,
          subtitle: Text(
            widget.word.yomikata,
            style: TextStyle(fontSize: Responsive.height14),
          ),
          title: Text(
            // widget.word.mean,
            mean,
            style: TextStyle(
                fontSize: Responsive.height14, overflow: TextOverflow.ellipsis),
          ),
          leading: Text(
            widget.word.word,
            style: TextStyle(
              fontSize: Responsive.height10 * 1.7,
              fontWeight: FontWeight.w600,
            ),
          ),
          trailing: IconButton(
            style: IconButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(0, 0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            icon: FaIcon(
              isWordSaved
                  ? FontAwesomeIcons.solidBookmark
                  : FontAwesomeIcons.bookmark,
              color: isWordSaved ? Colors.cyan.shade700 : null,
            ),
            onPressed: () {
              newMyWord;
              if (isWordSaved) {
                MyWordRepository.deleteMyWord(newMyWord);
                isWordSaved = false;
                savedWordCnt--;
                // savedWordCount--;ㅕ
              } else {
                MyWordRepository.saveMyWord(newMyWord);
                isWordSaved = true;
                savedWordCnt++;
                // savedWordCount++;
              }
              setState(() {});
            },
          ),
        ),
      ),
    );
  }
}
