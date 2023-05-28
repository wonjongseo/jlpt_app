// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/model/Question.dart';

class GrammarQuizCard extends StatefulWidget {
  GrammarQuizCard(
      {Key? key,
      required this.questionIndex,
      required this.question,
      this.onChanged,
      required this.size,
      this.isCorrect = false,
      this.isSubmitted = false})
      : super(key: key);

  final int questionIndex;
  final Size size;
  final Question question;
  Function(int)? onChanged;

  final bool isCorrect;
  final bool isSubmitted;

  @override
  State<GrammarQuizCard> createState() => _GrammarQuizCardState();
}

class _GrammarQuizCardState extends State<GrammarQuizCard> {
  String selectedAnswer = '';

  @override
  Widget build(BuildContext context) {
    String question = widget.question.question.word;
    return Padding(
      padding: const EdgeInsets.only(right: 16, bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // [제출] 버튼을 눌렀을 시
              if (widget.isSubmitted)
                Stack(
                  children: [
                    // 문제를 맞춤
                    if (widget.isCorrect)
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.red, width: 3),
                        ),
                      )
                    // 문제를 틀림.
                    else
                      SvgPicture.asset(
                        'assets/svg/incorrect-icon.svg',
                        height: 25,
                        width: 25,
                      ),
                    // 1. OR 2.
                    questionNumberText(),
                  ],
                )
              else
                // 1. OR 2.
                questionNumberText(),
              // 문법 문제
              Expanded(
                child: InkWell(
                  onTap: () => copyWord(question),
                  child: Text(
                    question,
                    style: TextStyle(
                      // color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: widget.size.width > 500 ? 20 : 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // 제출 되었으면 정답 공개.
          if (widget.isSubmitted)
            Padding(
              padding:
                  const EdgeInsets.only(left: 20, bottom: 8, right: 10, top: 8),
              child: Text(widget.question.question.yomikata),
            ),

          // 사지선다 버튼.
          Column(
            children: List.generate(
              widget.question.options.length,
              (index2) {
                String value =
                    '${index2 + 1}.  ${widget.question.options[index2].mean}';

                if (widget.isSubmitted) {
                  late Color color;

                  if (widget.isCorrect) {
                    // 맞으면 버튼 파란색
                    color = Colors.blue;
                  } else {
                    // 틀리면 버튼 빨간색 변경
                    color = Colors.red;
                  }
                  // 문제의 정답 보기.
                  if (widget.question.answer == index2) {
                    return ListTile(
                      visualDensity: const VisualDensity(
                        horizontal: VisualDensity.minimumDensity,
                        vertical: VisualDensity.minimumDensity,
                      ),
                      title: Text(
                        value,
                        // style: const TextStyle(color: Colors.white),
                      ),
                      leading: Radio<String>(
                        groupValue: value,
                        value: value,
                        activeColor: color,
                        focusColor: color,
                        onChanged: (String? value) {
                          if (widget.onChanged != null) {
                            widget.onChanged!(index2);
                            setState(() {
                              selectedAnswer = value!;
                            });
                          }
                        },
                      ),
                    );
                  } else {
                    // 문제의 정답 보기 외.
                    // 없애면 안됨.
                    return ListTile(
                      title: Text(
                        value,
                        // style: const TextStyle(color: Colors.white)
                      ),
                      leading: Radio<String>(
                        groupValue: '',
                        value: value,
                        onChanged: (String? value) {
                          if (widget.onChanged != null) {
                            widget.onChanged!(index2);
                            setState(() {
                              selectedAnswer = value!;
                            });
                          }
                        },
                      ),
                    );
                  }
                } else {
                  // 제출 되기 전
                  return ListTile(
                    title: Text(
                      value,
                      // style: const TextStyle(color: Colors.white)
                    ),
                    leading: Radio<String>(
                      groupValue: selectedAnswer,
                      value: value,
                      activeColor: Colors.black,
                      focusColor: Colors.black,
                      onChanged: (String? value) {
                        if (widget.isSubmitted == false) {
                          widget.onChanged!(index2);
                          setState(() {
                            selectedAnswer = value!;
                          });
                        }
                      },
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding questionNumberText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        '${widget.questionIndex + 1}. ',
        style: const TextStyle(fontSize: 25
            //, color: Colors.white
            ),
      ),
    );
  }
}
