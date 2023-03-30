import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/screen/kangi/kangi_study/components/kangi_study_buttons.dart';
import 'package:japanese_voca/screen/kangi/kangi_study/components/kangi_study_card.dart';
import 'package:japanese_voca/screen/kangi/kangi_study/kangi_study_controller.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/model/word.dart';
import 'package:japanese_voca/screen/word/word_study/word_controller.dart';

final String KANGI_STUDY_PATH = '/kangi_study';

// ignore: must_be_immutable
class KangiStudyScreen extends StatelessWidget {
  late KangiController kangiController;
  KangiStudyScreen() {
    if (Get.arguments != null && Get.arguments['againTest']) {
      print('Get.arguments["againTest"]: ${Get.arguments['againTest']}');

      kangiController = Get.put(KangiController(isAgainTest: true));
    } else {
      kangiController = Get.put(KangiController());
    }
  }

  // @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(context),
    );
  }

  Column _body(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GetBuilder<KangiController>(builder: (controller) {
          return KangiStrudyCard(controller: controller);
        }),
        const SizedBox(height: 32),
        const KangiStudyButtons(),
      ],
    );
  }

  AppBar _appBar() {
    return AppBar(
      elevation: 0,
      actions: [
        if (kangiController.kangis.length >= 4)
          TextButton(
            onPressed: kangiController.goToTest,
            child: const Text('TEST'),
          ),
        const SizedBox(width: 15),
        IconButton(
            onPressed: () {
              MyWord.saveMyVoca(
                  kangiController.kangis[kangiController.currentIndex]
                      .kangiToWord(),
                  isManualSave: true);
            },
            icon: SvgPicture.asset('assets/svg/save.svg')),
        const SizedBox(width: 15),
      ],
      leading: IconButton(
        onPressed: () async {
          kangiController.kangiStep.unKnownKangis = [];
          Get.back();
        },
        icon: const Icon(Icons.arrow_back_ios),
      ),
      title: GetBuilder<KangiController>(builder: (controller) {
        return Text(
            '${controller.currentIndex + 1} / ${controller.kangis.length}');
      }),
    );
  }
}
