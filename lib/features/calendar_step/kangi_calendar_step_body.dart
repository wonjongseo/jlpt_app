import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/config/size.dart';
import 'package:japanese_voca/features/calendar_step/grammar_calendar_step_screen.dart';
import 'package:japanese_voca/features/calendar_step/widgets/c_toggle_btn.dart';
import 'package:japanese_voca/features/calendar_step/widgets/check_row_btn.dart';
import 'package:japanese_voca/features/calendar_step/widgets/kangi_list_tile.dart';
import 'package:japanese_voca/features/jlpt_and_kangi/kangi/controller/kangi_step_controller.dart';
import 'package:japanese_voca/features/jlpt_and_kangi/screens/top_navigation_btn.dart';
import 'package:japanese_voca/features/jlpt_and_kangi/widgets/step_selector_button.dart';
import 'package:japanese_voca/model/kangi_step.dart';
import 'package:japanese_voca/user/controller/user_controller.dart';

class KangiCalendarStepScreen extends StatefulWidget {
  const KangiCalendarStepScreen({super.key, required this.chapter});
  final String chapter;
  @override
  State<KangiCalendarStepScreen> createState() =>
      _KangiCalendarStepScreenState();
}

class _KangiCalendarStepScreenState extends State<KangiCalendarStepScreen> {
  late String level;
  late String category;
  int currChapNumber = 0;
  UserController userController = Get.find<UserController>();
  late PageController pageController;
  List<GlobalKey> gKeys = [];
  late KangiStepController kangiController;
  @override
  void initState() {
    category = '한자';
    kangiController = Get.find<KangiStepController>();
    level = kangiController.level;

    kangiController.setKangiSteps(widget.chapter);

    gKeys = List.generate(
        kangiController.kangiSteps.length, (index) => GlobalKey());

    kangiController.pageController =
        PageController(initialPage: kangiController.step);

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        Scrollable.ensureVisible(gKeys[kangiController.step].currentContext!,
            duration: const Duration(milliseconds: 1500),
            curve: Curves.easeInOut);
      },
    );
    super.initState();
  }

  IconButton _bottomSheet() {
    return IconButton(
      onPressed: () {
        Get.bottomSheet(
          Container(
            color: Colors.white,
            child: GetBuilder<KangiStepController>(
              builder: (controller) {
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
                      value: !controller.isHidenMean,
                    ),
                    const SizedBox(height: 10),
                    CToggleBtn(
                      label: '음독 가리기',
                      toggle: controller.toggleSeeUndoc,
                      value: !controller.isHidenUndoc,
                    ),
                    const SizedBox(height: 10),
                    CToggleBtn(
                      label: '훈독 가리기',
                      toggle: controller.toggleSeeHundoc,
                      value: !controller.isHidenHundoc,
                    ),
                    CheckRowBtn(
                      label: '단어 전체 저장',
                      value: controller.isAllSave(),
                      onChanged: (v) => controller.toggleAllSave(),
                    ),
                    const SizedBox(height: 40),
                  ],
                );
              },
            ),
          ),
        );
      },
      icon: const Icon(Icons.menu),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: kangiController.getKangiStep().kangis.length >= 4
          ? FloatingActionButton(
              onPressed: kangiController.goToTest,
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
      body: _body(),
    );
  }

  PreferredSize _appBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(appBarHeight),
      child: AppBar(
        scrolledUnderElevation: 0.0,
        title: Text(
          'JLPT N$level $category - ${widget.chapter}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        actions: [_bottomSheet()],
      ),
    );
  }

  SafeArea _body() {
    return SafeArea(
      child: GetBuilder<KangiStepController>(builder: (controller) {
        return Center(
          child: Column(
            children: [
              TopNavigationBtn(
                stepList: controller.kangiSteps,
                navigationKey: (index) => gKeys[index],
                onTap: (index) {
                  kangiController.changeHeaderPageIndex(index);
                  setState(() {});
                },
                isCurrent: (index) => kangiController.step == index,
                isFinished: (index) => controller.kangiSteps[index].isFinished,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: Responsive.height8),
                  child: Container(
                    color: Colors.white,
                    child: PageView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: kangiController.pageController,
                      itemCount: controller.kangiSteps.length,
                      itemBuilder: (context, subStep) {
                        controller.setStep(subStep);
                        KangiStep kangiStep = controller.getKangiStep();
                        return SingleChildScrollView(
                          child: Column(
                            children: List.generate(
                              kangiStep.kangis.length,
                              (index) {
                                bool isSaved = controller
                                    .isSavedInLocal(kangiStep.kangis[index]);
                                return KangiListTile(
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
              ),
              const SizedBox(height: 20)
            ],
          ),
        );
      }),
    );
  }

  Padding _topActionBtns(KangiStepController controller) {
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
                value: controller.isHidenMean,
                onChanged: (v) => controller.toggleSeeMean(v),
              ),
              SizedBox(width: Responsive.width20),
              CheckRowBtn(
                label: '음독 가리기',
                value: controller.isHidenUndoc,
                onChanged: (v) => controller.toggleSeeUndoc(v),
              ),
              SizedBox(width: Responsive.width20),
              CheckRowBtn(
                label: '훈독 가리기',
                value: controller.isHidenHundoc,
                onChanged: (v) => controller.toggleSeeHundoc(v),
              ),
            ],
          ),
          if (controller.getKangiStep().kangis.length >= 4)
            Card(
              shape: const CircleBorder(),
              child: GestureDetector(
                onTap: () => kangiController.goToTest(),
                child: Padding(
                  padding: EdgeInsets.all(Responsive.width10),
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
