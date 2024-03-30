import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/common/controller/tts_controller.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/features/kangi_study/widgets/kangi_card.dart';
import 'package:japanese_voca/model/kangi.dart';
import 'package:japanese_voca/repository/kangis_step_repository.dart';

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
          '연관 단어',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Responsive.height10 * 1.8,
            color: Colors.cyan.shade700,
          ),
        ),
        Container(
          width: double.infinity,
          height: Responsive.height10 * 5,
          decoration: const BoxDecoration(color: Colors.grey),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(japanese.length, (index) {
              List<int> kangiIndex =
                  getKangiIndex(japanese, kangiStepRepositroy);
              if (kangiIndex.contains(index)) {
                if (!temp.contains(japanese[index])) {
                  temp.add(japanese[index]);
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.width16 / 2,
                    ),
                    child: InkWell(
                      onTap: () {
                        Kangi? kangi =
                            kangiStepRepositroy.getKangi(japanese[index]);
                        if (kangi != null) {
                          ttsController.stop();
                          Get.to(
                            preventDuplicates: false,
                            () => Scaffold(
                              appBar: AppBar(),
                              body: KangiCard(kangi: kangi),
                            ),
                          );
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Responsive.width16 / 4,
                        ),
                        decoration: const BoxDecoration(
                          border: Border(
                              bottom:
                                  BorderSide(color: Colors.black, width: 2)),
                        ),
                        child: Text(
                          japanese[index],
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: Responsive.height10 * 2.4,
                          ),
                        ),
                      ),
                    ),
                  );
                }
              }

              return const SizedBox();
            }),
          ),
        ),
      ],
    );
  }
}
