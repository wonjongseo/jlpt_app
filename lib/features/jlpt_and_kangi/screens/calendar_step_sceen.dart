import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/admob/banner_ad/global_banner_admob.dart';

import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/config/size.dart';
import 'package:japanese_voca/features/grammar_step/services/grammar_controller.dart';
import 'package:japanese_voca/features/grammar_step/widgets/grammar_card.dart';
import 'package:japanese_voca/features/grammar_test/grammar_test_screen.dart';
import 'package:japanese_voca/features/jlpt_and_kangi/jlpt/controller/jlpt_step_controller.dart';
import 'package:japanese_voca/features/jlpt_and_kangi/kangi/controller/kangi_step_controller.dart';
import 'package:japanese_voca/features/jlpt_and_kangi/widgets/step_selector_button.dart';
import 'package:japanese_voca/features/jlpt_home/screens/jlpt_home_screen.dart';
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
  late CategoryEnum categoryEnum;

  CalendarStepSceen({super.key}) {
    categoryEnum = Get.arguments['categoryEnum'];
  }

  @override
  State<CalendarStepSceen> createState() => _CalendarStepSceenState();
}

class _CalendarStepSceenState extends State<CalendarStepSceen> {
  int currChapNumber = 0;
  UserController userController = Get.find<UserController>();
  // late ScrollController scrollController;
  late PageController pageController;
  List<GlobalKey> gKeys = [];
  late JlptStepController jlptWordController;
  late KangiStepController kangiController;
  late GrammarController grammarController;

  late String level;
  late String chapter;
  late String category;
  @override
  void initState() {
    super.initState();
    chapter = Get.arguments['chapter'];

    switch (widget.categoryEnum) {
      case CategoryEnum.Japaneses:
        category = '일본어';
        jlptWordController = Get.find<JlptStepController>();
        jlptWordController.setJlptSteps(chapter);

        level = jlptWordController.level;

        gKeys = List.generate(
            jlptWordController.jlptSteps.length, (index) => GlobalKey());
        currChapNumber = LocalReposotiry.getCurrentProgressing(
            '${widget.categoryEnum.name}-$level-$chapter');

        jlptWordController.setStep(currChapNumber);

        pageController = PageController(initialPage: currChapNumber);

        break;

      case CategoryEnum.Kangis:
        category = '한자';
        kangiController = Get.find<KangiStepController>();
        kangiController.setKangiSteps(chapter);

        level = kangiController.level;
        gKeys = List.generate(
            kangiController.kangiSteps.length, (index) => GlobalKey());
        currChapNumber = LocalReposotiry.getCurrentProgressing(
            '${widget.categoryEnum.name}-$level-$chapter');

        kangiController.setStep(currChapNumber);
        pageController = PageController(initialPage: currChapNumber);
        break;
      case CategoryEnum.Grammars:
        category = '문법';
        grammarController = Get.find<GrammarController>();
        level = grammarController.level;
        break;
    }

    if (widget.categoryEnum != CategoryEnum.Grammars) {
      //After Build
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          Scrollable.ensureVisible(gKeys[currChapNumber].currentContext!,
              duration: const Duration(milliseconds: 1500),
              curve: Curves.easeInOut);
        },
      );
    }
  }

  Widget getBody(CategoryEnum categoryEnum) {
    switch (categoryEnum) {
      case CategoryEnum.Japaneses:
        return SafeArea(
          child: GetBuilder<JlptStepController>(builder: (controller) {
            return Center(
              child: Column(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    // controller: scrollController,
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
                                          '${widget.categoryEnum.name}-$level-$chapter',
                                          currChapNumber);
                                      pageController.animateToPage(
                                          currChapNumber,
                                          duration:
                                              const Duration(milliseconds: 300),
                                          curve: Curves.easeIn);

                                      controller.step = currChapNumber;
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
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: Responsive.height16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                Checkbox(
                                  value: !controller.isSeeMean,
                                  onChanged: (v) => controller.toggleSeeMean(v),
                                  checkColor: Colors.cyan.shade600,
                                  fillColor: MaterialStateProperty.resolveWith(
                                      (states) => Colors.white),
                                ),
                                Text(
                                  '뜻 가리기',
                                  style: TextStyle(
                                    fontSize: Responsive.height14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.cyan.shade400,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 20),
                            Column(
                              children: [
                                Checkbox(
                                  value: !controller.isSeeYomikata,
                                  onChanged: (v) =>
                                      controller.toggleSeeYomikata(v),
                                  checkColor: Colors.cyan.shade600,
                                  fillColor: MaterialStateProperty.resolveWith(
                                      (states) => Colors.white),
                                ),
                                Text(
                                  '읽는 법 가리기',
                                  style: TextStyle(
                                    fontSize: Responsive.height14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.cyan.shade400,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 20),
                            if (controller.getJlptStep().words.length >= 4)
                              Card(
                                shape: const CircleBorder(),
                                child: InkWell(
                                  onTap: () => jlptWordController.goToTest(),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      '퀴즈!',
                                      style: TextStyle(
                                        fontSize: Responsive.height14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.cyan.shade600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        Column(
                          children: [
                            Checkbox(
                              value: controller.isAllSave(),
                              onChanged: (v) => controller.toggleAllSave(),
                              checkColor: Colors.cyan.shade600,
                              fillColor: MaterialStateProperty.resolveWith(
                                  (states) => Colors.white),
                            ),
                            Text(
                              '전체 선택',
                              style: TextStyle(
                                fontSize: Responsive.height14,
                                fontWeight: FontWeight.w600,
                                color: Colors.cyan.shade400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: Responsive.height8),
                      child: Container(
                        color: Colors.white,
                        child: PageView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: pageController,
                          itemCount: controller.jlptSteps.length,
                          itemBuilder: (context, subStep) {
                            JlptStep jlptStep =
                                controller.jlptSteps[currChapNumber];

                            return SingleChildScrollView(
                              child: Column(
                                children: List.generate(
                                  jlptStep.words.length,
                                  (index) {
                                    bool isSaved = controller
                                        .isSavedInLocal(jlptStep.words[index]);
                                    return BBBB(
                                        word: jlptStep.words[index],
                                        index: index,
                                        isSaved: isSaved);
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
        );

      case CategoryEnum.Kangis:
        return SafeArea(
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
                                controller.kangiSteps[index].isFinished ??
                                    false,
                            isEnabled: isEnabled,
                          ),
                        );
                      }),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: Responsive.height16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                Checkbox(
                                  value: controller.isHidenMean,
                                  onChanged: (v) => controller.toggleSeeMean(v),
                                  checkColor: Colors.cyan.shade600,
                                  fillColor: MaterialStateProperty.resolveWith(
                                      (states) => Colors.white),
                                ),
                                Text(
                                  '뜻 가리기',
                                  style: TextStyle(
                                    fontSize: Responsive.height14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.cyan.shade400,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 20),
                            Column(
                              children: [
                                Checkbox(
                                  value: controller.isHidenUndoc,
                                  onChanged: (v) =>
                                      controller.toggleSeeUndoc(v),
                                  checkColor: Colors.cyan.shade600,
                                  fillColor: MaterialStateProperty.resolveWith(
                                      (states) => Colors.white),
                                ),
                                Text(
                                  '음독 가리기',
                                  style: TextStyle(
                                    fontSize: Responsive.height14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.cyan.shade400,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 20),
                            Column(
                              children: [
                                Checkbox(
                                  value: controller.isHidenHundoc,
                                  onChanged: (v) =>
                                      controller.toggleSeeHundoc(v),
                                  checkColor: Colors.cyan.shade600,
                                  fillColor: MaterialStateProperty.resolveWith(
                                      (states) => Colors.white),
                                ),
                                Text(
                                  '훈독 가리기',
                                  style: TextStyle(
                                    fontSize: Responsive.height14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.cyan.shade400,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        if (controller.getKangiStep().kangis.length >= 4)
                          Card(
                            shape: const CircleBorder(),
                            child: InkWell(
                              onTap: () => kangiController.goToTest(),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  '퀴즈!',
                                  style: TextStyle(
                                    fontSize: Responsive.height14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.cyan.shade600,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        Column(
                          children: [
                            Checkbox(
                              value: controller.isAllSave(),
                              onChanged: (v) => controller.toggleAllSave(),
                              checkColor: Colors.cyan.shade600,
                              fillColor: MaterialStateProperty.resolveWith(
                                  (states) => Colors.white),
                            ),
                            Text(
                              '전체 선택',
                              style: TextStyle(
                                fontSize: Responsive.height14,
                                fontWeight: FontWeight.w600,
                                color: Colors.cyan.shade400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: Responsive.height8),
                      child: Container(
                        color: Colors.white,
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
                                    bool isSaved = controller.isSavedInLocal(
                                        kangiStep.kangis[index]);
                                    return CCCC(
                                      kangi: kangiStep.kangis[index],
                                      index: index,
                                      isSaved: isSaved,
                                    );
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
        );

      case CategoryEnum.Grammars:
        return GetBuilder<GrammarController>(builder: (controller) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Responsive.height16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Column(
                          children: [
                            Checkbox(
                              value: !controller.isSeeMean,
                              onChanged: (v) => controller.toggleSeeMean(v),
                              checkColor: Colors.cyan.shade600,
                              fillColor: MaterialStateProperty.resolveWith(
                                  (states) => Colors.white),
                            ),
                            Text(
                              '의미 가리기',
                              style: TextStyle(
                                fontSize: Responsive.height14,
                                fontWeight: FontWeight.w600,
                                color: Colors.cyan.shade400,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(width: 20),
                    if (controller.grammers.length >= 4)
                      Card(
                        shape: const CircleBorder(),
                        child: InkWell(
                          onTap: () async {
                            bool result = await askToWatchMovieAndGetHeart(
                              title: const Text('점수를 기록하고 하트를 채워요!'),
                              content: const Text(
                                '테스트 페이지로 넘어가시겠습니까?',
                                style: TextStyle(
                                  color: AppColors.scaffoldBackground,
                                ),
                              ),
                            );
                            if (result) {
                              Get.toNamed(
                                GRAMMAR_TEST_SCREEN,
                                arguments: {
                                  'grammar':
                                      controller.getGrammarStep().grammars,
                                },
                              );
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              '퀴즈!',
                              style: TextStyle(
                                fontSize: Responsive.height14,
                                fontWeight: FontWeight.w600,
                                color: Colors.cyan.shade600,
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
                  padding: EdgeInsets.symmetric(vertical: Responsive.height8),
                  child: Container(
                    color: Colors.white,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: List.generate(
                          controller.getGrammarStep().grammars.length,
                          (index) {
                            return GrammarCard(
                              index: index,
                              grammars: controller.getGrammarStep().grammars,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(appBarHeight),
        child: AppBar(
          title: Text(
            'JLPT N$level $category - $chapter',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Responsive.height16,
            ),
          ),
          actions: const [HeartCount()],
        ),
      ),
      body: SafeArea(child: getBody(widget.categoryEnum)),
      bottomNavigationBar: const GlobalBannerAdmob(),
    );
  }
}

class BBBB extends StatefulWidget {
  const BBBB({
    Key? key,
    required this.isSaved,
    required this.index,
    required this.word,
  }) : super(key: key);
  final bool isSaved;
  final int index;
  final Word word;

  @override
  State<BBBB> createState() => _BBBBState();
}

class _BBBBState extends State<BBBB> {
  UserController userController = Get.find<UserController>();
  JlptStepController controller = Get.find<JlptStepController>();
  bool isWantToSeeMean = false;
  bool isWantToSeeYomikata = false;

  @override
  Widget build(BuildContext context) {
    String mean = widget.word.mean;
    String changedWord = widget.word.word;

    if (widget.word.mean.contains('1.')) {
      mean = '${(widget.word.mean.split('\n')[0]).split('1.')[1]}...';
    }
    if (widget.word.word.contains('·')) {
      changedWord = widget.word.word.split('·')[0];
    }

    return InkWell(
        onTap: () => Get.to(() => JlptStudyScreen(currentIndex: widget.index)),
        child: Container(
          decoration: BoxDecoration(border: Border.all(width: 0.3)),
          child: ListTile(
            isThreeLine: true,
            minLeadingWidth: 80,
            subtitle: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: SizedBox(
                height: 20,
                child: isWantToSeeYomikata || controller.isSeeYomikata
                    ? Text(
                        widget.word.yomikata,
                        style: TextStyle(fontSize: Responsive.height16),
                      )
                    : InkWell(
                        onTap: () {
                          isWantToSeeYomikata = true;
                          setState(() {});
                        },
                        child: Container(
                          height: 15,
                          decoration:
                              BoxDecoration(color: Colors.grey.shade400),
                        ),
                      ),
              ),
            ),
            title: SizedBox(
              height: 20,
              child: isWantToSeeMean || controller.isSeeMean
                  ? Text(
                      mean,
                      style: TextStyle(
                          fontSize: Responsive.height16,
                          overflow: TextOverflow.ellipsis),
                    )
                  : InkWell(
                      onTap: () {
                        isWantToSeeMean = true;
                        setState(() {});
                      },
                      child: Container(
                        height: 15,
                        decoration: BoxDecoration(color: Colors.grey.shade400),
                      ),
                    ),
            ),
            leading: Text(
              changedWord,
              style: TextStyle(
                fontSize: Responsive.height10 * 2,
                fontWeight: FontWeight.w600,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            trailing: IconButton(
                style: IconButton.styleFrom(
                  padding: const EdgeInsets.all(2),
                  minimumSize: const Size(0, 0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                icon: FaIcon(
                  widget.isSaved
                      ? FontAwesomeIcons.solidBookmark
                      : FontAwesomeIcons.bookmark,
                  color: widget.isSaved ? Colors.cyan.shade700 : null,
                  size: 22,
                ),
                onPressed: () => controller.toggleSaveWord(widget.word)),
          ),
        ));
  }
}

class CCCC extends StatefulWidget {
  const CCCC({
    super.key,
    required this.kangi,
    required this.index,
    required this.isSaved,
  });
  final int index;
  final Kangi kangi;
  final bool isSaved;
  @override
  State<CCCC> createState() => _CCCCState();
}

class _CCCCState extends State<CCCC> {
  bool isWantToSeeMean = false;
  bool isWantToSeeUndoc = false;
  bool isWantToSeeHundoc = false;
  UserController userController = Get.find<UserController>();
  KangiStepController controller = Get.find<KangiStepController>();
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
          subtitle: Column(
            children: [
              SizedBox(
                height: 20,
                child: Row(
                  children: [
                    Text(
                      '옴독: ',
                      style: TextStyle(fontSize: Responsive.height14),
                    ),
                    if (isWantToSeeUndoc || !controller.isHidenUndoc)
                      Flexible(
                        child: Text(
                          widget.kangi.undoc,
                          style: TextStyle(
                            fontSize: Responsive.height16,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                    else
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            isWantToSeeUndoc = true;
                            setState(() {});
                          },
                          child: Container(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SizedBox(
                  height: 20,
                  child: Row(
                    children: [
                      Text(
                        '훈독: ',
                        style: TextStyle(fontSize: Responsive.height14),
                      ),
                      if (isWantToSeeHundoc || !controller.isHidenHundoc)
                        Flexible(
                          child: Text(
                            widget.kangi.hundoc,
                            style: TextStyle(
                              fontSize: Responsive.height16,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                      else
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              isWantToSeeHundoc = true;
                              setState(() {});
                            },
                            child: Container(
                              height: 20,
                              color: Colors.grey,
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ],
          ),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: SizedBox(
              height: 20,
              child: isWantToSeeMean || !controller.isHidenMean
                  ? Text(
                      widget.kangi.korea,
                      style: TextStyle(
                        fontSize: Responsive.height16,
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        isWantToSeeMean = true;
                        setState(() {});
                      },
                      child: Container(
                        width: double.infinity,
                        height: 15,
                        color: Colors.grey,
                      ),
                    ),
            ),
          ),
          leading: Text(
            widget.kangi.japan,
            style: TextStyle(
              fontSize: Responsive.height10 * 3,
              color: Colors.black,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          trailing: IconButton(
              style: IconButton.styleFrom(
                padding: const EdgeInsets.all(2),
                minimumSize: const Size(0, 0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              icon: FaIcon(
                widget.isSaved
                    ? FontAwesomeIcons.solidBookmark
                    : FontAwesomeIcons.bookmark,
                color: widget.isSaved ? Colors.cyan.shade700 : null,
                size: 22,
              ),
              onPressed: () => controller.toggleSaveWord(widget.kangi)),
        ),
      ),
    );
  }
}
