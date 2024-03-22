import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/common/widget/kangi_text.dart';
import 'package:japanese_voca/features/jlpt_study/jlpt_study_controller.dart';
import 'package:japanese_voca/features/kangi_study/widgets/kangi_card.dart';
import 'package:japanese_voca/model/kangi.dart';
import 'package:japanese_voca/model/word.dart';
import 'package:japanese_voca/repository/kangis_step_repository.dart';

// ignore: must_be_immutable
class WordCard extends StatelessWidget {
  WordCard({super.key, required this.word, this.controller});
  JlptStudyController? controller;
  final Word word;
  @override
  Widget build(BuildContext context) {
    List<String> temp = [];
    String japanese = word.word;
    KangiStepRepositroy kangiStepRepositroy = KangiStepRepositroy();
    //  = Get.find<JlptStudyController>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  KangiText(japanese: japanese, clickTwice: false),
                  if (controller != null)
                    !controller!.isSavedInLocal()
                        ? IconButton(
                            onPressed: () {
                              controller!.toggleSaveWord();
                            },
                            icon: FaIcon(
                              FontAwesomeIcons.bookmark,
                              color: Colors.cyan.shade700,
                            ),
                          )
                        : IconButton(
                            onPressed: () {
                              controller!.toggleSaveWord();
                            },
                            icon: FaIcon(
                              FontAwesomeIcons.solidBookmark,
                              color: Colors.cyan.shade700,
                            ),
                          )
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    '[${word.yomikata}]',
                    style: TextStyle(
                      fontSize: Dimentions.height20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(width: 5),
                  if (controller != null)
                    IconButton(
                      onPressed: () {
                        controller!.speakYomikata();
                      },
                      icon: FaIcon(
                        FontAwesomeIcons.volumeOff,
                        color: Colors.cyan.shade700,
                      ),
                    )
                ],
              ),
              const SizedBox(height: 10),
              Text(
                word.mean,
                style: TextStyle(
                  fontSize: Dimentions.height18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Divider(),
              const SizedBox(height: 30),
              Text(
                '연관 단어',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.cyan.shade700,
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
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
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: InkWell(
                            onTap: () {
                              Kangi? kangi =
                                  kangiStepRepositroy.getKangi(japanese[index]);
                              if (kangi != null) {
                                Get.to(
                                  preventDuplicates: false,
                                  () => Scaffold(
                                    appBar: AppBar(),
                                    body: KangiCard(kangi: kangi!),
                                  ),
                                );
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              decoration: const BoxDecoration(
                                // color: Colors.red,
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.black, width: 2)),
                              ),
                              child: Text(
                                japanese[index],
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 24,
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
          ),
        ),
      ),
    );
  }
}
