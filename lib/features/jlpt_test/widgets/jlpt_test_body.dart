import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/theme.dart';
import 'package:japanese_voca/features/jlpt_test/controller/jlpt_test_controller.dart';
import 'package:japanese_voca/features/jlpt_test/widgets/jlpt_test_card.dart';
import 'package:japanese_voca/config/colors.dart';

class JlptTestBody extends StatelessWidget {
  const JlptTestBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(JlptTestController());

    return GetBuilder<JlptTestController>(builder: (questionController) {
      return IgnorePointer(
        ignoring: questionController.isDisTouchable,
        child: Stack(
          children: [
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Responsive.height10 / 2),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text.rich(
                      TextSpan(
                        text: "問題 ",
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  fontFamily: AppFonts.japaneseFont,
                                ),
                        children: [
                          TextSpan(
                            text: '${questionController.questionNumber.value}',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .copyWith(
                                  fontFamily: AppFonts.japaneseFont,
                                  color: AppColors.mainBordColor,
                                ),
                          ),
                          TextSpan(
                            text: "/${questionController.questions.length}",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(fontFamily: AppFonts.japaneseFont),
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: Responsive.height20),
                  Expanded(
                    child: PageView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: questionController.pageController,
                      onPageChanged: questionController.updateTheQnNum,
                      itemCount: questionController.questions.length,
                      itemBuilder: (context, index) {
                        return JlptTestCard(
                          question: questionController.questions[index],
                        );
                      },
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );
    });
  }
}
