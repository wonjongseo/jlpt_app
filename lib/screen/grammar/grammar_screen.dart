import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/controller/grammar_controller.dart';
import 'package:japanese_voca/screen/grammar/grammar_quiz_screen.dart';
import 'package:japanese_voca/model/grammar_step.dart';
import 'package:japanese_voca/screen/grammar/components/grammar_card.dart';

const String GRAMMER_PATH = '/grammar';

class GrammerScreen extends StatefulWidget {
  const GrammerScreen({super.key});

  @override
  State<GrammerScreen> createState() => _GrammerScreenState();
}

class _GrammerScreenState extends State<GrammerScreen> {
  GrammarController grammarController = Get.find<GrammarController>();

  late GrammarStep grammarStep;
  bool isEnglish = true;

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    grammarStep = grammarController.getGrammarStep();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
      appBar: _appBar(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: const BackButton(color: Colors.white),
      actions: [
        TextButton(
          onPressed: () async {
            Get.toNamed(GRAMMAR_QUIZ_SCREEN, arguments: {
              'grammar': grammarStep.grammars,
            });
          },
          child: const Text(
            'TEST',
            style: TextStyle(color: Colors.white),
          ),
        ),
        const SizedBox(width: 15),
      ],
    );
  }

  Widget _body(BuildContext context) {
    return ListView(
      children: List.generate(
        grammarStep.grammars.length,
        (index) {
          return GrammarCard(
            grammar: grammarStep.grammars[index],
          );
        },
      ),
    );
  }
}
