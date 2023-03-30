import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/book_card.dart';
import 'package:japanese_voca/kangis_data.dart';
import 'package:japanese_voca/screen/kangi/kangi_step/kangi_step_sceen.dart';

final String KANGI_HANGUL_STEP_PATH = '/kangi-hangul-step';

class KangiHangulStepScreen extends StatelessWidget {
  const KangiHangulStepScreen({super.key});

  void goTo(int index, String level) {
    Get.toNamed(KANGI_STEP_PATH, arguments: {'firstHangul': level});
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
              hanguls.length,
              (index) {
                String level = hanguls[index];
                return BookCard(level: level, onTap: () => goTo(index, level));
              },
            ),
          ),
        ),
      ),
    );
  }
}
