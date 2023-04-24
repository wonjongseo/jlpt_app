import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/config/constatns.dart';
import 'package:japanese_voca/grammar_example_screen.dart';
import 'package:japanese_voca/model/example.dart';
import 'package:japanese_voca/model/grammar.dart';
import 'package:japanese_voca/screen/grammar/components/example_mean_card.dart';

class GrammarCard extends StatefulWidget {
  GrammarCard({
    super.key,
    this.onPress,
    this.onPressLike,
    required this.grammar,
  });

  VoidCallback? onPress;
  final Grammar grammar;
  VoidCallbackIntent? onPressLike;

  @override
  State<GrammarCard> createState() => _GrammarCardState();
}

class _GrammarCardState extends State<GrammarCard> {
  bool isClick = false;
  bool isClickExample = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: AnimatedSize(
        alignment: const Alignment(0, -1),
        duration: Duration(
            milliseconds: isClickExample == false
                ? 500
                : widget.grammar.examples.length * 120),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          width: double.infinity,
          decoration: cBoxDecoration,
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  isClick = !isClick;
                  isClickExample = false;
                  setState(() {});
                },
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    widget.grammar.grammar,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: isClick,
                child: const Divider(height: 20),
              ),
              Visibility(
                visible: isClick,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.grammar.connectionWays.isNotEmpty)
                      GrammarCardSection(
                          title: '접속 형태',
                          content: widget.grammar.connectionWays),
                    if (widget.grammar.connectionWays.isNotEmpty)
                      const Divider(height: 20),
                    if (widget.grammar.means.isNotEmpty)
                      GrammarCardSection(
                          title: '뜻', content: widget.grammar.means),
                    if (widget.grammar.means.isNotEmpty)
                      const Divider(height: 20),
                    if (widget.grammar.description.isNotEmpty)
                      GrammarCardSection(
                          title: '설명', content: widget.grammar.description),
                    const Divider(height: 20),
                    InkWell(
                      onTap: () {
                        isClickExample = !isClickExample;
                        setState(() {});
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 1,
                                offset: const Offset(1, 1),
                              ),
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 1,
                                offset: const Offset(-1, -1),
                              )
                            ],
                            borderRadius: BorderRadius.circular(10)),
                        // height: 30,
                        width: double.infinity,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            '예제',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Visibility(
                visible: isClickExample,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Divider(height: 20),
                    ...List.generate(widget.grammar.examples.length, (index) {
                      return GrammarExampleCard(
                        example: widget.grammar.examples[index],
                      );
                    })
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GrammarCardSection extends StatelessWidget {
  const GrammarCardSection({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
              text: title,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w600)),
          const TextSpan(text: ' :\n'),
          TextSpan(
            text: content,
            style: TextStyle(color: Colors.black, fontSize: width / 300 + 10),
          )
        ],
      ),
    );
  }
}
