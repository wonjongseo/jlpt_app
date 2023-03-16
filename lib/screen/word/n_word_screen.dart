import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/custom_page_button.dart';
import 'package:japanese_voca/data_format.dart';
import 'package:japanese_voca/screen/word/word_sceen.dart';

final String N_WORD_PATH = '/n_word';

class NWordScreen extends StatefulWidget {
  const NWordScreen({super.key});

  @override
  State<NWordScreen> createState() => _WordnState();
}

class _WordnState extends State<NWordScreen> {
  void goTo(int index) {
    Get.to(() => WordSceen(
          title: hiragas[index].toString(),
        ));
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
              (index) => CustomPageButton(
                  onTap: () => goTo(index), level: hiragas[index]),
            ),
          ),
        ),
      ),
    );
  }
}
