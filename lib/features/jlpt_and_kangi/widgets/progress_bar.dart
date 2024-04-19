import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/features/kangi_test/controller/kangi_test_controller.dart';
import 'package:japanese_voca/features/jlpt_test/controller/jlpt_test_controller.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    Key? key,
    required this.isKangi,
  }) : super(key: key);

  final bool isKangi;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: Responsive.height10 * 3.5,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF3F4768), width: 3),
        borderRadius: BorderRadius.circular(50),
      ),
      child: isKangi ? kangiChild() : jlptChild(),
    );
  }

  GetBuilder<JlptTestController> jlptChild() {
    return GetBuilder<JlptTestController>(
      builder: (controller) {
        return Stack(
          children: [
            LayoutBuilder(
              builder: (context, constraints) => Container(
                width: constraints.maxWidth * controller.animation.value,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF46A0AE), Color(0xFF00FFCB)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20 / 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${(controller.animation.value * 60).round()} sec"),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }

  GetBuilder<KangiTestController> kangiChild() {
    return GetBuilder<KangiTestController>(
      builder: (controller) {
        return Stack(
          children: [
            LayoutBuilder(
              builder: (context, constraints) => Container(
                width: constraints.maxWidth * controller.animation.value,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF46A0AE), Color(0xFF00FFCB)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
            Positioned.fill(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20 / 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${(controller.animation.value * 60).round()} sec"),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
