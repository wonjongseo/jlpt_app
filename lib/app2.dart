import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:japanese_voca/config/constatns.dart';
import 'package:japanese_voca/screen/grammar/components/grammar_card.dart';

class App2 extends StatefulWidget {
  const App2({super.key});

  @override
  State<App2> createState() => _App2State();
}

class _App2State extends State<App2> {
  String selectedAnswer = '';
  bool isClick = false;
  bool isClick2 = false;
  bool isClick3 = false;
  bool isClick4 = false;
  bool isClick5 = false;
  bool isFinishAnimated = false;
  var height = 200.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
                    });
                  },
                  child: AnimatedSize(
                    alignment: const Alignment(0, -1),
                    curve: Curves.easeIn,
                    duration: const Duration(milliseconds: 500),
                    child: Container(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 16),
                      decoration: cBoxDecoration,
                      width: double.infinity,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //Spacer(flex: 1),
                              const SizedBox(width: 20),
                              Text(
                                'widget.grammar.grammar',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                              //Spacer(flex: 1),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: InkWell(
                                    onTap: () {},
                                    child: SvgPicture.asset(
                                      'assets/svg/eye.svg',
                                      color: Colors.black,
                                      height: 20,
                                      width: 20,
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
