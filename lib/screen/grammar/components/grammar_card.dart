import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/config/constatns.dart';
import 'package:japanese_voca/model/grammer.dart';
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InkWell(
        onTap: () {
          if (!isClick) {
            _height = _height + 50 + widget.grammar.means.length * 50;
          } else {
            _height = 100;
          }

          isClick = !isClick;
          setState(() {});
        },
        child: Container(
          height: _height,
          decoration: cBoxDecoration,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      // tts.speak(widget.voca.voca);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4, left: 8),
                      child: SvgPicture.asset('assets/svg/speaker.svg',
                          height: 20),
                    ),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Text(
                      widget.grammar.grammar,
                      style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 21,
                          overflow: TextOverflow.clip),
                    ),
                  ),
                  if (isClick)
                    Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Center(
                            child: Text(widget.grammar.connectionWays),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Divider(height: 0),
                        ...List.generate(
                          widget.grammar.means.length,
                          (index) => Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Center(
                              child: Text(widget.grammar.means[index]),
                            ),
                          ),
                        ),
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
                          height: 100,
                          width: 100,
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
                      MyWord example = widget.grammar.examples[index];

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