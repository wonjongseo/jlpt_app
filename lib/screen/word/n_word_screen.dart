import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/custom_page_button.dart';
import 'package:japanese_voca/controller/word_controller.dart';
import 'package:japanese_voca/data_format.dart';
import 'package:japanese_voca/model/step.dart';
import 'package:japanese_voca/model/word.dart';
import 'package:japanese_voca/screen/word/word_sceen.dart';

final String N_WORD_PATH = '/n_word';

class NWordScreen extends StatefulWidget {
  const NWordScreen({super.key});

  @override
  State<NWordScreen> createState() => _WordnState();
}

class _WordnState extends State<NWordScreen> {
  final wordController = Get.find<WordController>();
  List<StepHive> steps = [];
  @override
  void initState() {
    // TODO: implement initState
    steps = wordController.step;
    super.initState();
  }

  void goTo(int index) {
    // List<Word> words = wordController.words[index];

    print('steps: ${steps}');
    print('steps.length: ${steps.length}');

    if (index == 9) {
      Get.to(() => WordSceen(
            title: hiragas[10],
            steps: steps,
          ));
    } else if (index == 10) {
      Get.to(() => WordSceen(
            title: hiragas[9],
            steps: steps,
          ));
    } else {
      Get.to(() => WordSceen(
            title: hiragas[index],
            steps: steps,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              hiragas.length,
              (index) {
                // 부사와 형용사의 정렬이 반되로 되어있기 때문의 조건문
                if (index == 9) {
                  return CustomPageButton(
                    onTap: () => goTo(index),
                    level: hiragas[10],
                  );
                } else if (index == 10) {
                  return CustomPageButton(
                    onTap: () => goTo(index),
                    level: hiragas[9],
                  );
                } else {
                  return CustomPageButton(
                    onTap: () => goTo(index),
                    level: hiragas[index],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
