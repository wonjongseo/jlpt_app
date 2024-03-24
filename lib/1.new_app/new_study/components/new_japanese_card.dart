import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/1.new_app/models/new_japanese.dart';
import 'package:japanese_voca/1.new_app/models/new_kangi.dart';
import 'package:japanese_voca/1.new_app/new_related_kangi_screen.dart';
import 'package:japanese_voca/1.new_app/new_study/components/new_voca_example_card.dart';
import 'package:japanese_voca/features/jlpt_and_kangi/jlpt/controller/jlpt_step_controller.dart';
import 'package:japanese_voca/features/jlpt_study/jlpt_study_controller.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/model/word.dart';
import 'package:japanese_voca/repository/my_word_repository.dart';

class NewJapaneseCard extends StatefulWidget {
  const NewJapaneseCard({super.key, required this.japanese});
  final Word japanese;
  @override
  State<NewJapaneseCard> createState() => _NewJapaneseCardState();
}

class _NewJapaneseCardState extends State<NewJapaneseCard> {
  bool isMoreExample = false;

  @override
  Widget build(BuildContext context) {
    JlptStepController jlptStudyController = Get.find<JlptStepController>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.japanese.word,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            letterSpacing: 1,
                          ),
                        ),
                        IconButton(
                            style: IconButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: const Size(0, 0),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            onPressed: () {
                              if (!jlptStudyController.isWordSaved) {
                                jlptStudyController.isWordSaved = true;
                                // jlptStudyController.saveCurrentWord();
                              }
                              jlptStudyController.update();
                            },
                            icon: FaIcon(FontAwesomeIcons.solidFloppyDisk))
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '[${(widget.japanese).yomikata}]',
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            // ttsController
                            //     .speak(temp_words[index]['yomikata']);
                          },
                          style: IconButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                            ),
                            minimumSize: const Size(0, 0),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          icon: FaIcon(
                            FontAwesomeIcons.volumeOff,
                            color: Colors.cyan.shade700,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Text(
                      widget.japanese.mean,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        // letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      '연관 한자',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.cyan.shade700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 8),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(3)),
                      ),
                      child: Row(
                        children: List.generate(
                          widget.japanese.word.length,
                          (index2) {
                            if (isKangi(widget.japanese.word[index2])) {
                              // NewKangi kangi = widget.japanese as NewKangi;
                              return Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: InkWell(
                                  onTap: () async {
                                    print('object');
                                    // Get.to(
                                    //   () => NewRelatedKangiScreen(voca: kangi),
                                    // );
                                  },
                                  child: Text(
                                    widget.japanese.word[index2],
                                    style: const TextStyle(
                                      fontSize: 22,
                                      decoration: TextDecoration.underline,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      '예제',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.cyan.shade700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Flexible(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
