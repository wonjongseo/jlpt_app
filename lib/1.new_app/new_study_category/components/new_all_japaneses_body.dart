import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/1.new_app/new_study_category/components/new_all_grammars_list_card.dart';
import 'package:japanese_voca/1.new_app/new_study_category/components/new_all_japanese_list_card.dart';
import 'package:japanese_voca/1.new_app/new_study_category/new_study_category_screen.dart';
import 'package:japanese_voca/features/jlpt_and_kangi/jlpt/controller/jlpt_step_controller.dart';
import 'package:japanese_voca/features/jlpt_and_kangi/screens/calendar_step_sceen.dart';

class NewAllJapaneseBody extends StatelessWidget {
  const NewAllJapaneseBody({super.key, required this.level});
  final int level;
  @override
  Widget build(BuildContext context) {
    JlptStepController jlptWordController =
        Get.put(JlptStepController(level: level.toString()));
    return ListView.separated(
      itemCount: jlptWordController.headTitleCount,
      separatorBuilder: (context, index) {
        return Container();
      },
      itemBuilder: (context, index) {
        String chapter = '챕터${index + 1}';

        return FadeInLeft(
          delay: Duration(milliseconds: 200 * index),
          child: NewAllJapaneseListCard(
            chapterNumber: index + 1,
            onTap: () {
              Get.toNamed(JLPT_CALENDAR_STEP_PATH,
                  arguments: {'chapter': chapter, 'isJlpt': true});
            },
          ),
        );
      },
    );
  }
}
