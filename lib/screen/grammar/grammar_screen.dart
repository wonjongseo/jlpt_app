import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/controller/question_controller.dart';
import 'package:japanese_voca/model/grammer.dart';
import 'package:japanese_voca/screen/grammar/components/grammar_card.dart';

const String GRAMMER_PATH = '/grammar';

class GrammerScreen extends StatefulWidget {
  const GrammerScreen({super.key});

  @override
  State<GrammerScreen> createState() => _GrammerScreenState();
}

class _GrammerScreenState extends State<GrammerScreen> {
  // final QuestionController _questionController = Get.put(QuestionController());

  bool isEnglish = true;
  @override
  Widget build(BuildContext context) {
    return _body(context);
  }

  Scaffold _body(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: ListView(
        children: List.generate(
          dummy_grammers.length,
          (index) {
            return GrammarCard(
              grammar: dummy_grammers[index],
            );
          },
        ),
      ),
    );
  }

  AppBar _appBar(BuildContext context) {
    return AppBar(
      foregroundColor: Colors.white,
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        'Day',
        style: const TextStyle(color: Colors.black),
      ),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: [
        if (5 > 3)
          InkWell(
            // onTap:
            onTap: () {
              List<dynamic> knownsList = [];
              if (knownsList.isNotEmpty) {
                Get.dialog(AlertDialog(
                  // title: const Text(''),
                  content: Text(' 가 남아 있습니다. 이어 보시겠습니까 ?'),
                  actions: [
                    TextButton(
                        onPressed: () {
                          for (var e in knownsList) {}
                          ;
                        },
                        child: const Text('진행')),
                    TextButton(onPressed: () {}, child: const Text('취소'))
                  ],
                ));
              } else {}
            },

            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Center(
                child: SvgPicture.asset(
                  'assets/svg/book.svg',
                  height: 30,
                ),
              ),
            ),
          ),
        InkWell(
          onTap: () {
            setState(() {
              isEnglish = !isEnglish;
            });
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Icon(
              Icons.language,
              color: Colors.black,
            ),
          ),
        )
      ],
    );
  }
}
