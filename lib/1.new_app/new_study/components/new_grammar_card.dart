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
import 'package:japanese_voca/model/grammar.dart';
import 'package:japanese_voca/model/grammar_step.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/model/word.dart';
import 'package:japanese_voca/repository/my_word_repository.dart';

class NewGrammarCard extends StatefulWidget {
  const NewGrammarCard({super.key, required this.grammar});
  final Grammar grammar;
  @override
  State<NewGrammarCard> createState() => _NewGrammarCardState();
}

class _NewGrammarCardState extends State<NewGrammarCard> {
  bool isMoreExample = false;

  @override
  Widget build(BuildContext context) {
    JlptStepController jlptStudyController = Get.find<JlptStepController>();

    for (int i = 0; i < widget.grammar.examples.length; i++) {
      print(widget.grammar.examples[i]);
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Expanded(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Container(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.grammar.grammar,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          letterSpacing: 1,
                        ),
                      ),

                      const SizedBox(height: 30),
                      Text(
                        '뜻',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.cyan.shade700,
                        ),
                      ),
                      Text(
                        widget.grammar.means,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          // letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 30),

                      Text(
                        '설명',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.cyan.shade700,
                        ),
                      ),
                      Text(
                        widget.grammar.description,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          // letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        '연결 방법',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.cyan.shade700,
                        ),
                      ),
                      Text(
                        widget.grammar.connectionWays,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          // letterSpacing: 1,
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
                      // Flexible(
                      //   child: SingleChildScrollView(
                      //     child: Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         if (widget.grammar.examples!.length < 2)
                      //           ...List.generate(
                      //             widget.grammar.examples!.length,
                      //             (examplesIndex) {
                      //               return NewVocaExcampleCard(
                      //                 example:
                      //                     widget.grammar.examples![examplesIndex],
                      //               );
                      //             },
                      //           )
                      //         else ...[
                      //           ...List.generate(
                      //             2,
                      //             (examplesIndex) {
                      //               return NewVocaExcampleCard(
                      //                 example:
                      //                     widget.grammar.examples![examplesIndex],
                      //               );
                      //             },
                      //           ),
                      //           if (!isMoreExample) ...[
                      //             const SizedBox(height: 10),
                      //             InkWell(
                      //               onTap: () {
                      //                 isMoreExample = true;
                      //                 setState(() {});
                      //               },
                      //               child: Row(
                      //                 crossAxisAlignment:
                      //                     CrossAxisAlignment.center,
                      //                 children: [
                      //                   Text(
                      //                     '예시 더보기',
                      //                     style: TextStyle(
                      //                       fontSize: 16,
                      //                       fontWeight: FontWeight.w600,
                      //                       color: Colors.cyan.shade700,
                      //                     ),
                      //                   ),
                      //                   Icon(
                      //                     Icons.arrow_drop_down,
                      //                     color: Colors.cyan.shade700,
                      //                   )
                      //                 ],
                      //               ),
                      //             ),
                      //           ] else
                      //             ...List.generate(
                      //               widget.grammar.examples!.length - 2,
                      //               (examplesIndex) {
                      //                 return NewVocaExcampleCard(
                      //                   example: widget
                      //                       .grammar.examples![examplesIndex],
                      //                 );
                      //               },
                      //             ),
                      //         ]
                      //       ],
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
