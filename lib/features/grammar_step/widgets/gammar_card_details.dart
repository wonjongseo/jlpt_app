import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/admob/controller/ad_controller.dart';
import 'package:japanese_voca/common/controller/tts_controller.dart';
import 'package:japanese_voca/features/grammar_step/widgets/grammar_description_card.dart';
import 'package:japanese_voca/features/grammar_step/widgets/grammar_tutorial_screen.dart';
import 'package:japanese_voca/features/grammar_test/components/grammar_example_card.dart';
import 'package:japanese_voca/model/grammar.dart';
import 'package:japanese_voca/user/controller/user_controller.dart';

class GrammarCardDetails extends StatefulWidget {
  const GrammarCardDetails(
      {super.key,
      required this.index,
      required this.grammars,
      required this.pageController});
  final int index;
  final PageController pageController;
  final List<Grammar> grammars;
  @override
  State<GrammarCardDetails> createState() => _GrammarCardDetailsState();
}

class _GrammarCardDetailsState extends State<GrammarCardDetails> {
  UserController userController = Get.find<UserController>();
  TtsController ttsController = Get.find<TtsController>();
  AdController adController = Get.find<AdController>();
  bool isShowMoreExample = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TtsController>(builder: (ttsController) {
      return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: PageView.builder(
                itemCount: widget.grammars.length,
                controller: widget.pageController,
                onPageChanged: (value) {
                  setState(() {
                    isShowMoreExample = false;
                  });
                },
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: double.infinity,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.grammars[index].grammar,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 30,
                                ),
                              ),
                              if (widget.grammars[index].connectionWays
                                  .isNotEmpty) ...[
                                const SizedBox(height: 20),
                                GrammarDescriptionCard(
                                    fontSize: 18,
                                    title: '접속 형태',
                                    content: widget
                                        .grammars[widget.index].connectionWays),
                                const SizedBox(height: 20),
                              ],
                              if (widget
                                  .grammars[widget.index].means.isNotEmpty) ...[
                                GrammarDescriptionCard(
                                    fontSize: 18,
                                    title: '뜻',
                                    content: widget.grammars[index].means),
                                const SizedBox(height: 20),
                              ],
                              if (widget
                                  .grammars[index].description.isNotEmpty) ...[
                                GrammarDescriptionCard(
                                    fontSize: 18,
                                    title: '설명',
                                    content: widget
                                        .grammars[widget.index].description),
                              ],
                              const Divider(),
                              const SizedBox(height: 20),
                              Text(
                                '문법 예제',
                                style: TextStyle(
                                    color: Colors.cyan.shade700,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ...List.generate(
                                      isShowMoreExample
                                          ? widget
                                              .grammars[index].examples.length
                                          : 2, (index) {
                                    return GrammarExampleCard(
                                      index: index,
                                      example: widget.grammars[widget.index]
                                          .examples[index],
                                    );
                                  }),
                                  if (!isShowMoreExample)
                                    TextButton(
                                      onPressed: () {
                                        isShowMoreExample = true;
                                        setState(() {});
                                      },
                                      style: TextButton.styleFrom(
                                        padding: EdgeInsets.zero,
                                        minimumSize: const Size(0, 0),
                                        tapTargetSize:
                                            MaterialTapTargetSize.shrinkWrap,
                                      ),
                                      child: Text(
                                        '예제 더보기...',
                                        style: TextStyle(
                                            color: Colors.cyan.shade700,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              )),
        ),
      );
    });
  }
}
