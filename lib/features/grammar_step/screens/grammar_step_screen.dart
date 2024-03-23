import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/admob/banner_ad/global_banner_admob.dart';
import 'package:japanese_voca/features/grammar_step/services/grammar_controller.dart';
import 'package:japanese_voca/repository/local_repository.dart';

// ignore: must_be_immutable
class GrammarStepSceen extends StatelessWidget {
  GrammarStepSceen({super.key, required this.level});

  final String level;

  @override
  Widget build(BuildContext context) {
    Get.put(GrammarController(level: level));

    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      bottomNavigationBar: const GlobalBannerAdmob(),
      body: _body(width, context),
    );
  }

  GetBuilder<GrammarController> _body(double width, BuildContext context) {
    return GetBuilder<GrammarController>(
      builder: (controller) {
        return ListView.builder(
          itemCount: controller.grammers.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                controller.goToSturyPage(index);
              },
              child: Container(
                height: 50,
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  color: Colors.transparent,
                ),
                child: Text(
                  'Chapter${(controller.grammers[index].step + 1)}. (${controller.grammers[index].scores.toString()} / ${controller.grammers[index].grammars.length})',
                ),
              ),
            );
          },
        );
      },
    );
  }
}
