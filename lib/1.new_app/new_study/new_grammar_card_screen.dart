import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/1.new_app/new_study/components/new_grammar_card.dart';

import 'package:japanese_voca/common/controller/tts_controller.dart';
import 'package:japanese_voca/1.new_app/new_study/components/new_custom_appbar.dart';
import 'package:japanese_voca/1.new_app/new_study/components/new_japanese_card.dart';
import 'package:japanese_voca/1.new_app/models/new_japanese.dart';
import 'package:japanese_voca/features/grammar_step/services/grammar_controller.dart';
import 'package:japanese_voca/features/jlpt_study/jlpt_study_controller.dart';

class NewGrammarCardScreen extends StatefulWidget {
  const NewGrammarCardScreen({super.key, this.isRelated = false});
  final bool isRelated;
  @override
  State<NewGrammarCardScreen> createState() => _NewGrammarCardScreenState();
}

class _NewGrammarCardScreenState extends State<NewGrammarCardScreen> {
  GrammarController grammarController = Get.find<GrammarController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isRelated ? AppBar() : null,
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(height: 20),
          // CustomAppBar(currentIndex: grammarController.currentIndex),
          // const SizedBox(height: 10),
          // Expanded(
          //   child: PageView.builder(
          //     onPageChanged: grammarController.onPageChanged,
          //     controller: grammarController.pageController,
          //     itemCount: grammarController.grammers.length,
          //     itemBuilder: (context, index) {
          //       return NewGrammarCard(
          //         grammar: grammarController.getGrammarStep().grammars[index],
          //       );
          //     },
          //   ),
          // ),
        ],
      )),
    );
  }
}
