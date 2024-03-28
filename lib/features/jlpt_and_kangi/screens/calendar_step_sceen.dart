import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/1.new_app/new_study_category/new_study_category_screen.dart';
import 'package:japanese_voca/common/admob/banner_ad/global_banner_admob.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/features/jlpt_and_kangi/jlpt/controller/jlpt_step_controller.dart';
import 'package:japanese_voca/features/jlpt_and_kangi/kangi/controller/kangi_step_controller.dart';
import 'package:japanese_voca/features/jlpt_study/screens/jlpt_study_sceen.dart';
import 'package:japanese_voca/features/kangi_study/screens/kangi_study_sceen.dart';
import 'package:japanese_voca/model/jlpt_step.dart';
import 'package:japanese_voca/model/kangi.dart';
import 'package:japanese_voca/model/kangi_step.dart';
import 'package:japanese_voca/model/word.dart';
import 'package:japanese_voca/repository/local_repository.dart';
import 'package:japanese_voca/user/controller/user_controller.dart';

import '../../../common/widget/heart_count.dart';

const String JLPT_CALENDAR_STEP_PATH = '/jlpt-calendar-step';

// ignore: must_be_immutable
class CalendarStepSceen extends StatefulWidget {
  late JlptStepController jlptWordController;
  late KangiStepController kangiController;
  late String chapter;
  late String level;

  // late bool isSeenTutorial;
  late CategoryEnum categoryEnum;

  CalendarStepSceen({super.key}) {
    categoryEnum = Get.arguments['categoryEnum'];
    if (categoryEnum == CategoryEnum.Japaneses) {
      jlptWordController = Get.find<JlptStepController>();

      chapter = Get.arguments['chapter'];
      jlptWordController.setJlptSteps(chapter);
      level = jlptWordController.level;
    } else {
      kangiController = Get.find<KangiStepController>();
      chapter = Get.arguments['chapter'];
      kangiController.setKangiSteps(chapter);
      level = kangiController.level;
    }
  }

  @override
  State<CalendarStepSceen> createState() => _CalendarStepSceenState();
}

class _CalendarStepSceenState extends State<CalendarStepSceen> {
  int currChapNumber = 0;
  UserController userController = Get.find<UserController>();
  late ScrollController scrollController;
  late PageController pageController;
  List<GlobalKey> gKeys = [];

  @override
  void initState() {
    super.initState();
    if (widget.categoryEnum == CategoryEnum.Japaneses) {
      gKeys = List.generate(
          widget.jlptWordController.jlptSteps.length, (index) => GlobalKey());
    } else {
      gKeys = List.generate(
          widget.kangiController.kangiSteps.length, (index) => GlobalKey());
    }

    currChapNumber = LocalReposotiry.getCurrentProgressing(
        '${widget.categoryEnum.name}-${widget.level}-${widget.chapter}');
    pageController = PageController(initialPage: currChapNumber);
    scrollController = ScrollController();

    //After Build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Scrollable.ensureVisible(gKeys[currChapNumber].currentContext!,
          duration: const Duration(milliseconds: 1500),
          curve: Curves.easeInOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.categoryEnum == CategoryEnum.Japaneses) {
      return Scaffold(
        bottomNavigationBar: const GlobalBannerAdmob(),
        appBar: AppBar(
          title: Text(
            'JLPT N${widget.level} 단어 - ${widget.chapter}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Responsive.height10 * 2,
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
                    controller: scrollController,
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

                          if (index == 0) {
                            isEnabled = true;
                          } else {
                            isEnabled = controller.userController
                                    .isUserFake() ||
                                (controller.jlptSteps[index - 1].isFinished ??
                                    false);
                          }

                          return Padding(
                            key: gKeys[index],
                            padding: const EdgeInsets.only(left: 8),
                            child: InkWell(
                              onTap: isEnabled
                                  ? () {
                                      currChapNumber = index;
                                      LocalReposotiry.putCurrentProgressing(
                                          '${widget.categoryEnum.name}-${widget.level}-${widget.chapter}',
                                          currChapNumber);
                                      pageController.animateToPage(
                                          currChapNumber,
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.easeIn);

                                      controller.setStep(index);
                                      setState(() {});
                                    }
                                  : null,
                              child: StepSelectorButton(
                                isCurrent: currChapNumber == index,
                                isFinished:
                                    controller.jlptSteps[index].isFinished ??
                                        false,
                                isEnabled: isEnabled,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Row(
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
                          onTap: () => widget.jlptWordController.goToTest(),
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
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'JLPT N${widget.kangiController.level} 한자 - ${widget.chapter}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Responsive.height10 * 2,
          ),
        ),
        actions: const [HeartCount()],
      ),
      bottomNavigationBar: const GlobalBannerAdmob(),
      body: SafeArea(
        child: GetBuilder<KangiStepController>(builder: (controller) {
          return Center(
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children:
                        List.generate(controller.kangiSteps.length, (index) {
                      bool isEnabled = false;
                      if (index == 0) {
                        isEnabled = true;
                      } else {
                        isEnabled = controller.userController.isUserFake() ||
                            (controller.kangiSteps[index - 1].isFinished ??
                                false);
                      }

                      return InkWell(
                        key: gKeys[index],
                        onTap: () {
                          if (!isEnabled) return;
                          currChapNumber = index;
                          pageController.animateToPage(currChapNumber,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeIn);

                          controller.setStep(index);
                          setState(() {});
                        },
                        child: StepSelectorButton(
                          isCurrent: currChapNumber == index,
                          isFinished:
                              controller.kangiSteps[index].isFinished ?? false,
                          isEnabled: isEnabled,
                        ),
                      );
                    }),
                  ),
                ),
                Row(
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
                          controller.goToTest();
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
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PageView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: pageController,
                      itemCount: controller.kangiSteps.length,
                      itemBuilder: (context, subStep) {
                        controller.setStep(subStep);
                        KangiStep kangiStep = controller.getKangiStep();

                        return SingleChildScrollView(
                          child: Column(
                            children: List.generate(
                              kangiStep.kangis.length,
                              (index) {
                                return CCCC(
                                  kangi: kangiStep.kangis[index],
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
    );
  }
}

class StepSelectorButton extends StatelessWidget {
  const StepSelectorButton({
    super.key,
    required this.isEnabled,
    required this.isFinished,
    required this.isCurrent,
  });

  final bool isCurrent;
  final bool isEnabled;
  final bool isFinished;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: isCurrent
          ? Colors.cyan.shade400
          : isEnabled
              ? Colors.cyan.shade200
              : Colors.grey.shade100,
      elevation: isCurrent ? 3 : 0,
      child: Container(
        width: Responsive.height10 * 8.5, //
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            if (isFinished) ...[
              const Icon(
                Icons.star,
                color: AppColors.primaryColor,
                size: 16,
              ),
            ] else ...[
              FaIcon(
                FontAwesomeIcons.lock,
                color: Colors.grey.shade500,
                size: 16,
              ),
            ]
          ],
        ),
      ),
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
  UserController userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String mean = widget.word.mean;
    String word = widget.word.word;

    if (widget.word.mean.contains('1.')) {
      mean = '${(widget.word.mean.split('\n')[0]).split('1.')[1]}...';
    }
    if (widget.word.word.contains('·')) {
      word = widget.word.word.split('·')[0];
    }
    return InkWell(
        onTap: () => Get.to(() => JlptStudyScreen(currentIndex: widget.index)),
        child: Container(
          decoration: BoxDecoration(border: Border.all(width: 0.3)),
          child: ListTile(
            dense: true,
            isThreeLine: true,
            minLeadingWidth: 100,
            subtitle: Text(
              widget.word.yomikata,
              style: TextStyle(fontSize: Responsive.height14),
            ),
            title: Text(
              mean,
              style: TextStyle(
                  fontSize: Responsive.height14,
                  overflow: TextOverflow.ellipsis),
            ),
            leading: Text(
              word,
              style: TextStyle(
                fontSize: Responsive.height10 * 1.7,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: Text('상세보기'),
            // trailing: IconButton(
            //   style: IconButton.styleFrom(
            //     padding: EdgeInsets.zero,
            //     minimumSize: const Size(0, 0),
            //     tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            //   ),
            //   icon: FaIcon(
            //     controller.isSavedInLocal()
            //         ? FontAwesomeIcons.solidBookmark
            //         : FontAwesomeIcons.bookmark,
            //     color:
            //         controller.isSavedInLocal() ? Colors.cyan.shade700 : null,
            //   ),
            //   onPressed: () {
            //     newMyWord;
            //     if (isWordSaved) {
            //       MyWordRepository.deleteMyWord(newMyWord);
            //       isWordSaved = false;
            //       savedWordCnt--;
            //       // savedWordCount--;ㅕ
            //     } else {
            //       MyWordRepository.saveMyWord(newMyWord);
            //       isWordSaved = true;
            //       savedWordCnt++;
            //       // savedWordCount++;
            //     }
            //     setState(() {});
            //   },
            // ),
          ),
        ));
  }
}

class CCCC extends StatefulWidget {
  const CCCC({
    super.key,
    required this.kangi,
    required this.index,
  });
  final int index;
  final Kangi kangi;

  @override
  State<CCCC> createState() => _CCCCState();
}

class _CCCCState extends State<CCCC> {
  UserController userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => Get.to(() => KangiStudySceen(currentIndex: widget.index)),
        child: Container(
          decoration: BoxDecoration(border: Border.all(width: 0.3)),
          child: ListTile(
            dense: true,
            minLeadingWidth: 50,
            isThreeLine: true,
            subtitle: Text(
              '${widget.kangi.undoc}\n${widget.kangi.hundoc}',
              style: TextStyle(fontSize: Responsive.height14),
            ),
            title: Text(
              // widget.word.mean,
              widget.kangi.korea,
              style: TextStyle(
                  fontSize: Responsive.height14,
                  overflow: TextOverflow.ellipsis),
            ),
            leading: Text(
              widget.kangi.japan,
              style: TextStyle(
                fontSize: Responsive.height10 * 1.7,
                fontWeight: FontWeight.w600,
              ),
            ),
            trailing: Text('상세보기'),
            // trailing: IconButton(
            //   style: IconButton.styleFrom(
            //     padding: EdgeInsets.zero,
            //     minimumSize: const Size(0, 0),
            //     tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            //   ),
            //   icon: FaIcon(
            //     controller.isSavedInLocal()
            //         ? FontAwesomeIcons.solidBookmark
            //         : FontAwesomeIcons.bookmark,
            //     color:
            //         controller.isSavedInLocal() ? Colors.cyan.shade700 : null,
            //   ),
            //   onPressed: () {
            //     newMyWord;
            //     if (isWordSaved) {
            //       MyWordRepository.deleteMyWord(newMyWord);
            //       isWordSaved = false;
            //       savedWordCnt--;
            //       // savedWordCount--;ㅕ
            //     } else {
            //       MyWordRepository.saveMyWord(newMyWord);
            //       isWordSaved = true;
            //       savedWordCnt++;
            //       // savedWordCount++;
            //     }
            //     setState(() {});
            //   },
            // ),
          ),
        ));
  }
}
