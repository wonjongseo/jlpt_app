import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/new_app/models/new_japanese.dart';
import 'package:japanese_voca/new_app/models/new_kangi.dart';
import 'package:japanese_voca/new_app/new_related_kangi_screen.dart';
import 'package:japanese_voca/new_app/new_study/components/new_voca_example_card.dart';

class NewStudyCard extends StatefulWidget {
  const NewStudyCard({super.key, required this.japanese});
  final NewJapanese japanese;
  @override
  State<NewStudyCard> createState() => _NewStudyCardState();
}

class _NewStudyCardState extends State<NewStudyCard> {
  bool isMoreExample = false;

  @override
  Widget build(BuildContext context) {
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
                          // temp_words[index]['word'],
                          widget.japanese.word,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            letterSpacing: 1,
                          ),
                        ),
                        const FaIcon(FontAwesomeIcons.bookmark)
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '[${(widget.japanese as NewJapanese).yomikata}]',
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
                          children: [
                            if (widget.japanese.examples.length < 2)
                              ...List.generate(
                                widget.japanese.examples.length,
                                (examplesIndex) {
                                  return NewVocaExcampleCard(
                                    example:
                                        widget.japanese.examples[examplesIndex],
                                  );
                                },
                              )
                            else ...[
                              ...List.generate(
                                2,
                                (examplesIndex) {
                                  return NewVocaExcampleCard(
                                    example:
                                        widget.japanese.examples[examplesIndex],
                                  );
                                },
                              ),
                              if (!isMoreExample) ...[
                                const SizedBox(height: 10),
                                InkWell(
                                  onTap: () {
                                    isMoreExample = true;
                                    setState(() {});
                                  },
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        '예시 더보기',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.cyan.shade700,
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.cyan.shade700,
                                      )
                                    ],
                                  ),
                                ),
                              ] else
                                ...List.generate(
                                  widget.japanese.examples.length - 2,
                                  (examplesIndex) {
                                    return NewVocaExcampleCard(
                                      example: widget
                                          .japanese.examples[examplesIndex],
                                    );
                                  },
                                ),
                            ]
                          ],
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
