import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/data_format.dart';
import 'package:japanese_voca/screen/word/word_sceen.dart';

final String N_WORD_PATH = '/n_word';

class NWordScreen extends StatelessWidget {
  const NWordScreen({super.key});

  void goTo(int index, String level) {
    Get.toNamed(WORD_STEP_PATH, arguments: {'headTitle': level});
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
                String level = '';
                if (index == 9) {
                  level = hiragas[10];
                } else if (index == 10) {
                  level = hiragas[9];
                } else {
                  level = hiragas[index];
                }
                return InkWell(
                  onTap: () => goTo(index, level),
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 32.0),
                        child: SvgPicture.asset(
                          'assets/svg/hiragana_book.svg',
                          height: 180,
                        ),
                      ),
                      Text(
                        level,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
