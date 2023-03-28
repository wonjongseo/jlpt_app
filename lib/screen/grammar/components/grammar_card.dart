import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/config/constatns.dart';
import 'package:japanese_voca/model/example.dart';
import 'package:japanese_voca/model/grammar.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/screen/grammar/components/example_mean_card.dart';
// import 'package:sqflite/sqflite.dart';

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
  // final FlutterTts tts = FlutterTts();
  // @override
  // void initState() {
  //   super.initState();
  //   setTTS();
  //   tts.setLanguage('en');
  //   tts.setSpeechRate(0.4);
  // }

  // void setTTS() async {
  //   await tts.setSharedInstance(true);
  // }

  bool isClick = false;
  double _height = 100;
  // late WordApiDatasource wordApiDatasource;

  @override
  void initState() {
    super.initState();
    //  wordApiDatasource = WordApiDatasource();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InkWell(
        onTap: () {
          if (!isClick) {
            _height = _height + 150;
          } else {
            _height = 100;
          }

          isClick = !isClick;
          setState(() {});
        },
        child: Container(
          height: _height,
          padding: const EdgeInsets.only(top: 16.0),
          decoration: cBoxDecoration,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      widget.grammar.grammar,
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: width / 200 + 15,
                          overflow: TextOverflow.clip),
                    ),
                  ),
                  if (isClick)
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Center(
                            child: Text(
                              widget.grammar.connectionWays,
                              style: TextStyle(fontSize: width / 300 + 10),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Padding(
                          padding: EdgeInsets.only(right: 32.0, left: 32.0),
                          child: Divider(height: 0),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: Text(
                            widget.grammar.means,
                            style: TextStyle(fontSize: width / 300 + 10),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Padding(
                          padding: EdgeInsets.only(right: 32.0, left: 32.0),
                          child: Divider(height: 0),
                        ),
                        const SizedBox(height: 10),
                        Center(
                          child: Text(
                            widget.grammar.description,
                            style: TextStyle(fontSize: width / 300 + 10),
                          ),
                        )
                      ],
                    )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: IconButton(
                        onPressed: showExample,
                        icon: SvgPicture.asset(
                          'assets/svg/eye.svg',
                          color: Colors.black,
                          height: width / 50 + 20,
                          width: width / 50 + 20,
                        )),
                  )
                ],
              ),
            ],
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

  void showExample() async {
    Get.dialog(
      StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text(
              '예제',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            content: SizedBox(
              height: (widget.grammar.examples.length * 65),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    widget.grammar.examples.length,
                    (index) {
                      Example example = widget.grammar.examples[index];

                      // return Text(example.word);
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
                child: const Text('Back'),
              )
            ],
          );
        },
      ),
    );
  }
}
