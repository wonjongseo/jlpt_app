import 'package:get/get.dart';
import 'package:japanese_voca/common/admob/controller/ad_controller.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/config/theme.dart';
import 'package:japanese_voca/features/jlpt_and_kangi/widgets/kangi_related_card.dart';
import 'package:japanese_voca/model/kangi.dart';
import 'package:japanese_voca/repository/kangis_step_repository.dart';
import 'package:flutter/material.dart';
import 'package:japanese_voca/common/common.dart';

import '../../user/controller/user_controller.dart';
import '../app_constant.dart';

// ignore: must_be_immutable
class TouchableJapanese extends StatelessWidget {
  TouchableJapanese({
    Key? key,
    required this.japanese,
    required this.clickTwice,
    required this.fontSize,
    required this.underlineColor,
    this.color = Colors.white,
  }) : super(key: key);
  final Color underlineColor;
  final String japanese;
  final bool clickTwice;
  final double fontSize;
  final Color color;
  UserController userController = Get.find<UserController>();
  bool getDialogKangi(Kangi kangi, {clickTwice = false}) {
    Get.dialog(
      AlertDialog(
        titlePadding:
            const EdgeInsets.only(top: 16, bottom: 0, right: 16, left: 16),
        title: Text(
          kangi.japan,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: AppColors.scaffoldBackground,
            fontFamily: AppFonts.japaneseFont,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              kangi.korea,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20,
                color: AppColors.scaffoldBackground,
              ),
            ),

            //
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '음독 : ${kangi.undoc}',
                style: const TextStyle(
                  color: AppColors.scaffoldBackground,
                  fontFamily: AppFonts.japaneseFont,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '훈독 : ${kangi.hundoc}',
                style: const TextStyle(
                  color: AppColors.scaffoldBackground,
                  fontFamily: AppFonts.japaneseFont,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (kangi.relatedVoca.isNotEmpty && !clickTwice)
                  ElevatedButton(
                    onPressed: () => Get.back(),
                    child: const Text(
                      '나가기',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                const SizedBox(width: 10),
                if (clickTwice)
                  ElevatedButton(
                    onPressed: () => Get.back(),
                    child: const Text(
                      '나가기',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                else
                  ElevatedButton(
                    onPressed: () {
                      if (kangi.relatedVoca.isEmpty) {
                        Get.back();
                      } else {
                        Get.dialog(
                          AlertDialog(content: KangiRelatedCard(kangi: kangi)),
                        );
                      }
                    },
                    child: Text(
                      kangi.relatedVoca.isEmpty ? '나가기' : '연관 단어',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
            )
          ],
        ),
      ),
    );
    return true;
  }

  @override
  Widget build(BuildContext context) {
    KangiStepRepositroy kangiStepRepositroy = KangiStepRepositroy();

    AdController adController = Get.find<AdController>();
    List<int> kangiIndex = getKangiIndex(japanese, kangiStepRepositroy);
    bool isKataka = isKatakana(japanese);

    if (isKataka) {
      return Text(
        japanese,
        style: Theme.of(context).textTheme.displaySmall?.copyWith(
              fontSize: fontSize,
              color: color,
            ),
        textAlign: TextAlign.center,
      );
    }

    return Wrap(
      children: List.generate(japanese.length, (index) {
        if (kangiIndex.contains(index)) {
          // 일본어 중 한자
          return InkWell(
            onTap: () async {
              Kangi? kangi = kangiStepRepositroy.getKangi(japanese[index]);

              if (kangi == null) {
                Get.dialog(
                  AlertDialog(
                    content: Text(
                      '한자 ${japanese[index]} 아직 준비 되어 있지 않습니다.',
                      style: const TextStyle(
                        color: AppColors.scaffoldBackground,
                      ),
                    ),
                  ),
                );
                return;
              }
              getDialogKangi(kangi, clickTwice: clickTwice);
            },
            child: Text(
              japanese[index],
              style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    decorationColor: underlineColor,
                    color: color,
                    fontSize: fontSize,
                    fontFamily: AppFonts.japaneseFont,
                  ),
              textAlign: TextAlign.center,
            ),
          );
        } else {
          // 일본어 중 하라가나
          return Text(
            japanese[index],
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontSize: fontSize,
                  color: color,
                  fontFamily: AppFonts.japaneseFont,
                ),
            textAlign: TextAlign.center,
          );
        }
      }),
    );
  }
}
