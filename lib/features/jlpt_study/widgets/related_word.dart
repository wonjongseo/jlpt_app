import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/common/controller/tts_controller.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/theme.dart';
import 'package:japanese_voca/features/kangi_study/widgets/kangi_card.dart';
import 'package:japanese_voca/model/kangi.dart';
import 'package:japanese_voca/repository/kangis_step_repository.dart';
import 'package:japanese_voca/config/colors.dart';

class RelatedWords extends StatelessWidget {
  const RelatedWords({
    super.key,
    required this.japanese,
    required this.kangiStepRepositroy,
    required this.temp,
  });

  final String japanese;
  final KangiStepRepositroy kangiStepRepositroy;
  final List<String> temp;

  @override
  Widget build(BuildContext context) {
    TtsController ttsController = Get.find<TtsController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '연관 한자',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Responsive.height10 * 1.8,
            color: AppColors.mainBordColor,
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: Responsive.height16 / 4),
          decoration: const BoxDecoration(color: Colors.grey),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(japanese.length, (index) {
                List<int> kangiIndex =
                    getKangiIndex(japanese, kangiStepRepositroy);

                if (kangiIndex.contains(index)) {
                  if (!temp.contains(japanese[index])) {
                    temp.add(japanese[index]);
                    Kangi kangi =
                        kangiStepRepositroy.getKangi(japanese[index])!;
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Responsive.width16 / 2),
                      child: InkWell(
                        onTap: () {
                          ttsController.stop();
                          Get.to(
                            preventDuplicates: false,
                            () => Scaffold(
                              appBar: AppBar(),
                              body: KangiCard(kangi: kangi),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Responsive.width16 / 4),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                      color: Colors.grey.shade800, width: 1.5),
                                ),
                              ),
                              child: Text(
                                japanese[index],
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontFamily: AppFonts.japaneseFont,
                                  fontSize: Responsive.height10 * 2.2,
                                ),
                              ),
                            ),
                            Text(kangi.korea)
                          ],
                        ),
                      ),
                    );
                  }
                }

                return const SizedBox();
              }),
            ),
          ),
        ),
      ],
    );
  }
}
