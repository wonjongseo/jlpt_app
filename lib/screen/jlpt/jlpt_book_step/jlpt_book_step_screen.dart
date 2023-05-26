import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/book_card.dart';
import 'package:japanese_voca/controller/jlpt_word_controller.dart';
import 'package:japanese_voca/controller/kangi_controller.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_calendar_step/jlpt_calendar_step_sceen.dart';

final String BOOK_STEP_PATH = '/book-step';

// ignore: must_be_immutable
class JlptBookStepScreen extends StatelessWidget {
  late JlptWordController jlptWordController;
  late KangiController kangiController;
  final String level;
  final bool isJlpt;

  JlptBookStepScreen({super.key, required this.level, required this.isJlpt}) {
    if (isJlpt) {
      jlptWordController = Get.put(JlptWordController(level: level));
    } else {
      kangiController = Get.put(KangiController(hangul: level));
    }
  }

  void goTo(int index, String chapter) {
    if (isJlpt) {
      Get.toNamed(
        JLPT_CALENDAR_STEP_PATH,
        arguments: {'chapter': chapter, 'isJlpt': isJlpt},
      );
    } else {
      Get.toNamed(
        JLPT_CALENDAR_STEP_PATH,
        arguments: {'chapter': chapter, 'isJlpt': isJlpt},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!isJlpt) {
      return Scaffold(
        appBar: AppBar(
          leading: const BackButton(
            color: Colors.white,
          ),
          title: Text('$level - 단어'),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                kangiController.headTitleCount,
                (index) {
                  String chapter = '$level-${index + 1}';
                  return FadeInLeft(
                    delay: Duration(milliseconds: 200 * index),
                    child: BookCard(
                      level: chapter,
                      onTap: () => goTo(index, chapter),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        title: Text('N$level 단어'),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              jlptWordController.headTitleCount,
              (index) {
                String chapter = '챕터${index + 1}';
                return FadeInLeft(
                  delay: Duration(milliseconds: 200 * index),
                  child: BookCard(
                      level: chapter, onTap: () => goTo(index, chapter)),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
