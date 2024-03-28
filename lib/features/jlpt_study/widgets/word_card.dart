import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/common/controller/tts_controller.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/common/widget/kangi_text.dart';
import 'package:japanese_voca/features/grammar_test/components/grammar_example_card.dart';
import 'package:japanese_voca/features/jlpt_and_kangi/jlpt/controller/jlpt_step_controller.dart';
import 'package:japanese_voca/features/jlpt_study/jlpt_study_controller.dart';
import 'package:japanese_voca/features/kangi_study/widgets/kangi_card.dart';
import 'package:japanese_voca/model/example.dart';
import 'package:japanese_voca/model/kangi.dart';
import 'package:japanese_voca/model/word.dart';
import 'package:japanese_voca/repository/kangis_step_repository.dart';

// ignore: must_be_immutable
class WordCard extends StatelessWidget {
  WordCard({super.key, required this.word, this.controller});
  JlptStepController? controller;
  final Word word;
  @override
  Widget build(BuildContext context) {
    List<String> temp = [];
    String japanese = word.word;
    KangiStepRepositroy kangiStepRepositroy = KangiStepRepositroy();
    //  = Get.find<JlptStudyController>();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Responsive.width10 * 1.6),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(Responsive.height10 * 0.8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KangiText(japanese: japanese, clickTwice: false),
                  if (controller != null)
                    IconButton(
                      onPressed: () {
                        controller!.toggleSaveWord();
                      },
                      icon: !controller!.isSavedInLocal()
                          ? FaIcon(
                              FontAwesomeIcons.bookmark,
                              color: Colors.cyan.shade700,
                            )
                          : FaIcon(
                              FontAwesomeIcons.solidBookmark,
                              color: Colors.cyan.shade700,
                            ),
                    )
                ],
              ),
              SizedBox(height: Responsive.height10),
              Row(
                children: [
                  Text(
                    '[${word.yomikata}]',
                    style: TextStyle(
                      fontSize: Responsive.height20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(width: Responsive.width10 / 2),
                  if (controller != null)
                    IconButton(
                      onPressed: () {
                        // controller!.speakYomikata();
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.volumeOff,
                        color: Colors.cyan.shade700,
                      ),
                    )
                ],
              ),
              SizedBox(height: Responsive.height10),
              Text(
                word.mean,
                style: TextStyle(
                  fontSize: Responsive.height18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Divider(),
              SizedBox(height: Responsive.height10 * 3),
              RelatedWords(
                japanese: japanese,
                kangiStepRepositroy: kangiStepRepositroy,
                temp: temp,
              ),
              SizedBox(height: Responsive.height10 * 3),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '예제',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Responsive.height10 * 1.8,
                      color: Colors.cyan.shade700,
                    ),
                  ),
                  GrammarExampleCard(
                    example: Example(mean: '天下りがありました', word: '강림이 있었습니다.'),
                    index: 1,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
