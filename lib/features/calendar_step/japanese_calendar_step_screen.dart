import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/admob/banner_ad/global_banner_admob.dart';
import 'package:japanese_voca/common/widget/bottom_btn.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/config/size.dart';
import 'package:japanese_voca/features/calendar_step/widgets/c_toggle_btn.dart';
import 'package:japanese_voca/features/calendar_step/widgets/check_row_btn.dart';
import 'package:japanese_voca/features/calendar_step/widgets/japanese_list_tile.dart';
import 'package:japanese_voca/features/jlpt_and_kangi/jlpt/controller/jlpt_step_controller.dart';
import 'package:japanese_voca/features/jlpt_and_kangi/screens/top_navigation_btn.dart';
import 'package:japanese_voca/features/my_voca/components/custom_button.dart';
import 'package:japanese_voca/model/jlpt_step.dart';
import 'package:japanese_voca/user/controller/user_controller.dart';

class JapaneseCalendarStepScreen extends StatefulWidget {
  const JapaneseCalendarStepScreen({super.key, required this.chapter});

  final String chapter;
  @override
  State<JapaneseCalendarStepScreen> createState() =>
      _JapaneseCalendarStepScreenState();
}

class _JapaneseCalendarStepScreenState
    extends State<JapaneseCalendarStepScreen> {
  late String level;
  late String chapter;
  String category = '일본어';
  int currChapNumber = 0;
  UserController userController = Get.find<UserController>();
  late PageController pageController;
  List<GlobalKey> gKeys = [];
  JlptStepController jlptStepController = Get.find<JlptStepController>();

  @override
  void initState() {
    super.initState();
    chapter = widget.chapter;

    category = '일본어';
    jlptStepController = Get.find<JlptStepController>();

    level = jlptStepController.level;
    jlptStepController.setJlptSteps(chapter);

    gKeys = List.generate(
        jlptStepController.jlptSteps.length, (index) => GlobalKey());

    jlptStepController.pageController =
        PageController(initialPage: jlptStepController.currChapNumber);

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Scrollable.ensureVisible(
            gKeys[jlptStepController.currChapNumber].currentContext!,
            duration: const Duration(milliseconds: 1500),
            curve: Curves.easeInOut);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
      bottomNavigationBar: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (jlptStepController.getJlptStep().words.length >= 4)
              BottomBtn(label: '퀴즈!', onTap: jlptStepController.goToTest),
            const GlobalBannerAdmob(),
          ],
        ),
      ),
    );
  }

  PreferredSize _appBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(appBarHeight),
      child: AppBar(
        scrolledUnderElevation: 0.0,
        title: Text(
          'JLPT N$level $category - $chapter',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        actions: [
          _bottomSheet(),
        ],
      ),
    );
  }

  IconButton _bottomSheet() {
    return IconButton(
      onPressed: () {
        Get.bottomSheet(
          Container(
            color: Colors.white,
            child: GetBuilder<JlptStepController>(builder: (controller) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 5),
                    height: 5,
                    width: 120,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  CToggleBtn(
                    label: '의미 가리기',
                    toggle: controller.toggleSeeMean,
                    value: controller.isSeeMean,
                  ),
                  const SizedBox(height: 10),
                  CToggleBtn(
                    label: '읽는 법 가리기',
                    toggle: controller.toggleSeeYomikata,
                    value: controller.isSeeYomikata,
                  ),
                  CheckRowBtn(
                    label: '단어 전체 저장',
                    value: controller.isAllSave(),
                    onChanged: (v) => controller.toggleAllSave(),
                  ),
                  const SizedBox(height: 40),
                ],
              );
            }),
          ),
        );
      },
      icon: const Icon(Icons.menu),
    );
  }

  SafeArea _body() {
    return SafeArea(
      child: GetBuilder<JlptStepController>(builder: (controller) {
        return Center(
          child: Column(
            children: [
              TopNavigationBtn(
                stepList: controller.jlptSteps,
                navigationKey: (index) => gKeys[index],
                onTap: (index) {
                  jlptStepController.changeHeaderPageIndex(index);
                  setState(() {});
                },
                isCurrent: (index) => jlptStepController.step == index,
                isFinished: (index) => controller.jlptSteps[index].isFinished,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Container(
                    color: Colors.white,
                    child: PageView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: jlptStepController.pageController,
                      itemCount: controller.jlptSteps.length,
                      itemBuilder: (context, subStep) {
                        JlptStep jlptStep =
                            controller.jlptSteps[controller.step];

                        return SingleChildScrollView(
                          child: Column(
                            children: List.generate(
                              jlptStep.words.length,
                              (index) {
                                bool isSaved = controller
                                    .isSavedInLocal(jlptStep.words[index]);
                                return JapaneseListTile(
                                  word: jlptStep.words[index],
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
              ),
            ],
          ),
        );
      }),
    );
  }
}
