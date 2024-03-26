import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/1.new_app/new_study/components/search_widget.dart';
import 'package:japanese_voca/1.new_app/new_study/new_grammar_card_screen.dart';
import 'package:japanese_voca/1.new_app/new_study_category/components/new_all_grammars_list_card.dart';
import 'package:japanese_voca/1.new_app/new_study_category/new_study_category_screen.dart';
import 'package:japanese_voca/common/controller/tts_controller.dart';
import 'package:japanese_voca/features/grammar_step/services/grammar_controller.dart';
import 'package:japanese_voca/model/grammar_step.dart';
import 'package:japanese_voca/user/controller/user_controller.dart';

class NewAllGrammarsListScreen extends StatefulWidget {
  const NewAllGrammarsListScreen({super.key});

  @override
  State<NewAllGrammarsListScreen> createState() =>
      _NewAllGrammarsListScreenState();
}

class _NewAllGrammarsListScreenState extends State<NewAllGrammarsListScreen> {
  GrammarController grammarController = Get.find<GrammarController>();
  UserController userController = Get.find<UserController>();
  // TtsController ttsController = Get.put(TtsController());
  late GrammarStep grammarStep;

  Widget _body2(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            const NewSearchWidget(),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                      grammarStep.grammars.length,
                      (index) {
                        return NewAllGrammarListCard(
                          newGrammars: grammarStep.grammars,
                          index: index,
                          onTap: () {
                            Get.to(() => NewGrammarCardScreen());
                          },
                        );
                      },
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    grammarStep = grammarController.getGrammarStep();
    return Scaffold(appBar: AppBar(), body: _body2(context));
  }
}
