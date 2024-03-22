import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/1.new_app/new_study_category/components/new_all_grammars_list_card.dart';
import 'package:japanese_voca/1.new_app/new_study_category/new_all_grammars/new_all_grammars_list_screen.dart';
import 'package:japanese_voca/1.new_app/new_study_category/new_study_category_screen.dart';
import 'package:japanese_voca/features/grammar_step/services/grammar_controller.dart';
import 'package:japanese_voca/features/grammar_study/screens/grammar_stury_screen.dart';

class NewAllGrammarsBody extends StatelessWidget {
  const NewAllGrammarsBody({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<GrammarController>(builder: (grammarController) {
      return ListView.separated(
        itemCount: grammarController.grammers.length,
        separatorBuilder: (context, index) {
          return Container();
        },
        itemBuilder: (context, index) {
          String chapter = '챕터${index + 1}';

          return FadeInLeft(
            delay: Duration(milliseconds: 200 * index),
            child: NewAllGrammarListCard(
              chapterNumber: index + 1,
              onTap: () {
                grammarController.setStep(index);
                Get.to(() => NewAllGrammarsListScreen());
                // contoller.goToSturyPage(index, true);
              },
            ),
          );
        },
      );
    });
  }
}
