import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/config/constatns.dart';
import 'package:japanese_voca/grammar_example_screen.dart';
import 'package:japanese_voca/model/grammar.dart';
import 'package:japanese_voca/screen/grammar/components/grammar_card.dart';

class App2 extends StatefulWidget {
  const App2({super.key});

  @override
  State<App2> createState() => _App2State();
}

class _App2State extends State<App2> {
  late Grammar grammar;

  String selectedAnswer = '';
  bool isClick = false;
  bool isClick2 = false;
  bool isClick3 = false;
  bool isClick4 = false;
  bool isClick5 = false;
  bool isFinishAnimated = false;
  bool isClickExample = false;

  var height = 200.0;
  @override
  void initState() {
    grammar = Grammar.fromMap(
      {
        "id": 4,
        "grammar": "といえども",
        "means": "~라고 해요",
        "description": "いくら ~ といえども 형태로 자주 사용되며 , 아무리 ~ 라고 해도 (역접) 의 의미이다",
        "connectionWays": "보통형 접속",
        "examples": [
          {
            "word": "いくら生きるためといえども、人の物を盗むのは良くない。",
            "mean": "아무리 살기 위해서라도 남의 물건을 훔치는 것은 좋지 않다.",
            "answer": "といえども"
          },
          {
            "word": "いくら安いといえども、偽物であれば欲しいとは思わない。",
            "mean": "아무리 싸다고 해도 가짜라면 갖고 싶지 않다.",
            "answer": "といえども"
          },
          {
            "word": "未成年といえども、罪を犯したのであれば償うべきだ。",
            "mean": "미성년자라도 죄를 지었으면 속죄해야 한다.",
            "answer": "といえども"
          },
          {
            "word": "プロのギタリストといえども、ミスをすることはあり得る。",
            "mean": "프로 기타리스트라고 해도 실수를 할 수는 있다.",
            "answer": "といえども"
          },
          {
            "word": "たった10円といえども、粗末にしてはならない。",
            "mean": "단돈 10엔이라고 해도 소홀히 해서는 안 된다.",
            "answer": "といえども"
          },
          {
            "word": "会社の社長といえども、簡単には社員を首にすることはできない。",
            "mean": "회사 사장이라고 해도 쉽게 직원을 해고할 수는 없다.",
            "answer": "といえども"
          },
          {
            "word": "彼は大学を中退したといえども、今では大企業の社長として立派に働いている。",
            "mean": "그는 대학을 중퇴했지만 지금은 대기업 사장으로 훌륭하게 일하고 있다.",
            "answer": "といえども"
          },
          {
            "word": "会社を作ったといえども、まだ社員が二人だけなので、会社と言えるかどうか。",
            "mean": "회사를 만들었다지만 아직 직원이 두 명뿐이니 회사라고 할 수 있을까?",
            "answer": "といえども"
          },
          {
            "word": "外国人といえども、日本に住んでいるのだから、日本の法律は守らなければならない。",
            "mean": "외국인이라고 해도 일본에 살고 있으니 일본의 법률은 지켜야 한다.",
            "answer": "といえども"
          }
        ]
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: Scaffold(
          body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isClick = !isClick;
                      isClickExample = false;
                    });
                  },
                  child: AnimatedSize(
                    alignment: const Alignment(0, -1),
                    curve: Curves.easeIn,
                    duration: const Duration(milliseconds: 500),
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: cBoxDecoration,
                      width: double.infinity,
                      child: Column(
                        children: [
                          const Text(
                            'widget.grammar.grammar widget.grammar.grammarwidget.grammar.grammarwidget.grammar.grammarwidget.grammar.grammarwidget.grammar.grammarwidget.grammar.grammar',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.clip,
                            ),
                          ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     //Spacer(flex: 1),
                          //     const SizedBox(width: 20),

                          //     //Spacer(flex: 1),
                          //     Padding(
                          //       padding:
                          //           const EdgeInsets.symmetric(horizontal: 8.0),
                          //       child: InkWell(
                          //           onTap: () {
                          //             Get.to(() => GrammarExampleScreen(
                          //                 grammar: grammar));
                          //           },
                          //           child: SvgPicture.asset(
                          //             'assets/svg/eye.svg',
                          //             color: Colors.black,
                          //             height: 20,
                          //             width: 20,
                          //           )),
                          //     )
                          //   ],
                          // ),
                          Visibility(
                            visible: isClick,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const GrammarCardSection(
                                    title: '접속 형태',
                                    content:
                                        'widget.grammar.connectionWayswidget.grammar.connectionWayswidget.grammar.connectionWayswidget.grammar.connectionWayswidget.grammar.connectionWays'),
                                const Divider(height: 20),
                                const GrammarCardSection(
                                    title: '뜻',
                                    content: 'widget.grammar.means'),
                                const Divider(height: 20),
                                const GrammarCardSection(
                                    title: '설명',
                                    content: 'widget.grammar.description'),
                                const Divider(height: 20),
                                InkWell(
                                  onTap: () {
                                    isClickExample = !isClickExample;
                                    setState(() {});
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0)
                                        .copyWith(left: 0),
                                    child: const Text(
                                      '예제',
                                      style: TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w600,
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
                              children: List.generate(grammar.examples.length,
                                  (index) {
                                return GrammarExampleCard(
                                  example: grammar.examples[index],
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isClick2 = !isClick2;
                    });
                  },
                  child: AnimatedSize(
                    curve: Curves.easeIn,
                    duration: const Duration(milliseconds: 500),
                    child: Container(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 16),
                      decoration: cBoxDecoration,
                      width: double.infinity,
                      child: Column(
                        children: [
                          const Center(
                            child: Text(
                              'widget.grammar.grammar',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Visibility(
                                  visible: isClick2,
                                  child: GrammarCardSection(
                                      title: '접속 형태',
                                      content:
                                          'widget.grammar.connectionWayswidget.grammar.connectionWayswidget.grammar.connectionWayswidget.grammar.connectionWayswidget.grammar.connectionWays'),
                                ),
                                Visibility(
                                    visible: isClick2,
                                    child: Divider(height: 20)),
                                Visibility(
                                  visible: isClick2,
                                  child: GrammarCardSection(
                                      title: '뜻',
                                      content: 'widget.grammar.means'),
                                ),
                                Visibility(
                                    visible: isClick2,
                                    child: Divider(height: 20)),
                                Visibility(
                                  visible: isClick2,
                                  child: GrammarCardSection(
                                      title: '설명',
                                      content: 'widget.grammar.description'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isClick3 = !isClick3;
                    });
                  },
                  child: AnimatedSize(
                    curve: Curves.easeIn,
                    duration: const Duration(milliseconds: 500),
                    child: Container(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 16),
                      decoration: cBoxDecoration,
                      width: double.infinity,
                      child: Column(
                        children: [
                          const Center(
                            child: Text(
                              'widget.grammar.grammar',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: isClick3,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  GrammarCardSection(
                                      title: '접속 형태',
                                      content:
                                          'widget.grammar.connectionWayswidget.grammar.connectionWayswidget.grammar.connectionWayswidget.grammar.connectionWayswidget.grammar.connectionWays'),
                                  Divider(height: 20),
                                  GrammarCardSection(
                                      title: '뜻',
                                      content: 'widget.grammar.means'),
                                  Divider(height: 20),
                                  GrammarCardSection(
                                      title: '설명',
                                      content: 'widget.grammar.description'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isClick4 = !isClick4;
                    });
                  },
                  child: AnimatedSize(
                    curve: Curves.easeIn,
                    duration: const Duration(milliseconds: 500),
                    child: Container(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 16),
                      decoration: cBoxDecoration,
                      width: double.infinity,
                      child: Column(
                        children: [
                          const Center(
                            child: Text(
                              'widget.grammar.grammar',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: isClick4,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  GrammarCardSection(
                                      title: '접속 형태',
                                      content:
                                          'widget.grammar.connectionWayswidget.grammar.connectionWayswidget.grammar.connectionWayswidget.grammar.connectionWayswidget.grammar.connectionWays'),
                                  Divider(height: 20),
                                  GrammarCardSection(
                                      title: '뜻',
                                      content: 'widget.grammar.means'),
                                  Divider(height: 20),
                                  GrammarCardSection(
                                      title: '설명',
                                      content: 'widget.grammar.description'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: InkWell(
                  onTap: () {
                    setState(() {
                      isClick5 = !isClick5;
                    });
                  },
                  child: AnimatedSize(
                    curve: Curves.easeIn,
                    duration: const Duration(milliseconds: 500),
                    child: Container(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 16),
                      decoration: cBoxDecoration,
                      width: double.infinity,
                      child: Column(
                        children: [
                          const Center(
                            child: Text(
                              'widget.grammar.grammar',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                          ),
                          Visibility(
                            visible: isClick5,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  GrammarCardSection(
                                      title: '접속 형태',
                                      content:
                                          'widget.grammar.connectionWayswidget.grammar.connectionWayswidget.grammar.connectionWayswidget.grammar.connectionWayswidget.grammar.connectionWays'),
                                  Divider(height: 20),
                                  GrammarCardSection(
                                      title: '뜻',
                                      content: 'widget.grammar.means'),
                                  Divider(height: 20),
                                  GrammarCardSection(
                                      title: '설명',
                                      content: 'widget.grammar.description'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 200,
                child: Column(
                  children: [
                    Expanded(
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          const Text('1'),
                          Radio<String>(
                            groupValue: selectedAnswer,
                            visualDensity: VisualDensity.compact,
                            materialTapTargetSize: MaterialTapTargetSize.padded,
                            value: '1',
                            onChanged: (String? value) {
                              setState(() {
                                selectedAnswer = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          const Text('2'),
                          Radio<String>(
                            groupValue: selectedAnswer,
                            visualDensity: VisualDensity.compact,
                            materialTapTargetSize: MaterialTapTargetSize.padded,
                            value: '2',
                            onChanged: (String? value) {
                              setState(() {
                                selectedAnswer = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          const Text('3'),
                          Radio<String>(
                            groupValue: selectedAnswer,
                            visualDensity: VisualDensity.compact,
                            materialTapTargetSize: MaterialTapTargetSize.padded,
                            value: '3',
                            onChanged: (String? value) {
                              setState(() {
                                selectedAnswer = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          const Text('4'),
                          Radio<String>(
                            groupValue: selectedAnswer,
                            visualDensity: VisualDensity.compact,
                            materialTapTargetSize: MaterialTapTargetSize.padded,
                            value: '4',
                            onChanged: (String? value) {
                              setState(() {
                                selectedAnswer = value!;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
