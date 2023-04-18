import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/config/constatns.dart';
import 'package:japanese_voca/model/example.dart';
import 'package:japanese_voca/model/grammar.dart';
import 'package:japanese_voca/screen/grammar/components/example_mean_card.dart';

class GrammarCard extends StatefulWidget {
  GrammarCard(
      {super.key, this.onPress, this.onPressLike, required this.grammar});

  VoidCallback? onPress;
  final Grammar grammar;
  // final Vocabulary voca;
  VoidCallbackIntent? onPressLike;

  @override
  State<GrammarCard> createState() => _GrammarCardState();
}

class _GrammarCardState extends State<GrammarCard> {
  bool isClick = false;
  double _height = 100;

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    Size size = MediaQuery.of(context).size;

    void showExample() async {
      double sizeBoxWidth = size.width < 500 ? 8 : 16;
      double sizeBoxHight = size.width < 500 ? 16 : 32;
      Get.dialog(
        StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(
                '예제',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              content: Container(
                width: size.width < 500 ? null : size.width / 1.5,
                height: size.height < 500 ? null : size.height / 1.5,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(13)),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                      widget.grammar.examples.length,
                      (index) {
                        Example example = widget.grammar.examples[index];

                        return ExampleMeanCard(example: example);
                      },
                    ),
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    Get.back();
                  },
                  child: const Text('나가기'),
                )
              ],
            );
          },
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InkWell(
        onTap: () {
          isClick = !isClick;
          setState(() {});
        },
        child: AnimatedSize(
          alignment: const Alignment(0, -1),
          duration: const Duration(milliseconds: 500),
          child: Container(
            // padding: const EdgeInsets.only(top: 16.0),
            padding: const EdgeInsets.only(top: 16.0, bottom: 16),
            width: double.infinity,

            decoration: cBoxDecoration,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 20),
                    Text(
                      widget.grammar.grammar,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: InkWell(
                          onTap: showExample,
                          child: SvgPicture.asset(
                            'assets/svg/eye.svg',
                            color: Colors.black,
                            height: size.width / 100 + 15,
                            width: size.width / 100 + 15,
                          )),
                    )
                  ],
                ),
                Visibility(
                  visible: isClick,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
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
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // child: Column(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Column(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Center(
            //           child: Text(
            //             widget.grammar.grammar,
            //             style: TextStyle(
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: size.width / 200 + 10,
            //                 overflow: TextOverflow.clip),
            //           ),
            //         ),
            //         if (isClick)
            //           Padding(
            //             padding: const EdgeInsets.symmetric(horizontal: 16.0),
            //             child: Column(
            //               crossAxisAlignment: CrossAxisAlignment.start,
            //               children: [
            //                 if (widget.grammar.connectionWays.isNotEmpty)
            //                   Padding(
            //                     padding: const EdgeInsets.only(top: 24.0),
            //                     child: GrammarCardSection(
            //                         title: '접속 형태',
            //                         content: widget.grammar.connectionWays),
            //                   ),
            //                 if (widget.grammar.connectionWays.isNotEmpty)
            //                   const Divider(height: 20),
            //                 if (widget.grammar.means.isNotEmpty)
            //                   GrammarCardSection(
            //                       title: '뜻', content: widget.grammar.means),
            //                 if (widget.grammar.means.isNotEmpty)
            //                   const Divider(height: 20),
            //                 if (widget.grammar.description.isNotEmpty)
            //                   GrammarCardSection(
            //                       title: '설명',
            //                       content: widget.grammar.description),
            //               ],
            //             ),
            //           )
            //       ],
            //     ),
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.end,
            //       children: [
            //         Padding(
            //           padding: const EdgeInsets.only(right: 8.0),
            //           child: IconButton(
            //               onPressed: showExample,
            //               icon: SvgPicture.asset(
            //                 'assets/svg/eye.svg',
            //                 color: Colors.black,
            //                 height: size.width / 50 + 20,
            //                 width: size.width / 50 + 20,
            //               )),
            //         )
            //       ],
            //     ),
            //   ],
            // ),
          ),
        ),
      ),
    );
  }

  int getExampleIndex(List<String> exampleList, String word) {
    int exampleIndex = exampleList.indexOf(word);
    if (exampleIndex == -1) {
      exampleIndex = exampleList.indexOf('${word}s');
      if (exampleIndex == -1) {
        exampleIndex = exampleList.indexOf('${word}ed');
        if (exampleIndex == -1) {
          exampleIndex = exampleList.indexOf('${word}d');
        }
      }
    }
    return exampleIndex;
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
        text: TextSpan(children: [
      TextSpan(
          text: title,
          style: const TextStyle(
              color: Colors.black, fontWeight: FontWeight.w600)),
      const TextSpan(text: ' :\n'),
      TextSpan(
        text: content,
        style: TextStyle(color: Colors.black, fontSize: width / 300 + 10),
      )
    ]));
  }
}
