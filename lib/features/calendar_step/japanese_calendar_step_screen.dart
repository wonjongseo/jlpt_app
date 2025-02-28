import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/size.dart';
import 'package:japanese_voca/features/calendar_step/widgets/c_toggle_btn.dart';
import 'package:japanese_voca/features/calendar_step/widgets/check_row_btn.dart';
import 'package:japanese_voca/features/calendar_step/widgets/japanese_list_tile.dart';
import 'package:japanese_voca/features/jlpt_and_kangi/jlpt/controller/jlpt_step_controller.dart';
import 'package:japanese_voca/features/jlpt_and_kangi/screens/top_navigation_btn.dart';
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
      floatingActionButton: jlptStepController.getJlptStep().words.length >= 4
          ? FloatingActionButton(
              onPressed: jlptStepController.goToTest,
              child: Text(
                '퀴즈',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.cyan.shade600,
                ),
              ),
            )
          : null,
      appBar: _appBar(),
      // endDrawer: Drawer(),
      body: _body(),
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
              if (1 == 2) _topActionBtns(controller),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: Responsive.height8),
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
              SizedBox(height: 20)
            ],
          ),
        );
      }),
    );
  }

  Padding _topActionBtns(JlptStepController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Responsive.height16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              CheckRowBtn(
                label: '뜻 가리기',
                value: !controller.isSeeMean,
                onChanged: (v) => controller.toggleSeeMean(v),
              ),
              const SizedBox(width: 20),
              CheckRowBtn(
                label: '읽는 법 가리기',
                value: !controller.isSeeYomikata,
                onChanged: (v) => controller.toggleSeeYomikata(v),
              ),
              const SizedBox(width: 20),
              if (controller.getJlptStep().words.length >= 4)
                Card(
                  shape: const CircleBorder(),
                  child: GestureDetector(
                    onTap: () => jlptStepController.goToTest(),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        '퀴즈!',
                        style: TextStyle(
                          fontSize: Responsive.width12,
                          fontWeight: FontWeight.w600,
                          color: Colors.cyan.shade600,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          CheckRowBtn(
            label: '전체 선택',
            value: controller.isAllSave(),
            onChanged: (v) => controller.toggleAllSave(),
          ),
        ],
      ),
    );
  }
}
