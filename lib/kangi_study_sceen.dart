import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/controller/kangi_controller.dart';
import 'package:japanese_voca/model/kangi_step.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/model/word.dart';
import 'package:japanese_voca/repository/local_repository.dart';

final String KANGI_STUDY_PATH = '/kangi_study';

class KangiStudySceen extends StatefulWidget {
  const KangiStudySceen({super.key});

  @override
  State<KangiStudySceen> createState() => _KangiStudySceenState();
}

class _KangiStudySceenState extends State<KangiStudySceen> {
  late PageController pageController;
  int currentPage = 0;
  KangiController kangiController = Get.find<KangiController>();
  late KangiStep kangiStep;
  bool isAutoSave = LocalReposotiry.getAutoSave();
  @override
  void initState() {
    super.initState();
    pageController = PageController();
    kangiStep = kangiController.getKangiStep();
  }

  @override
  Widget build(BuildContext context) {
    void onPageChanged(int page) {
      currentPage = page;
      setState(() {});
    }

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            SizedBox(
              height: 500,
              child: PageView.builder(
                itemCount: kangiStep.kangis.length,
                onPageChanged: onPageChanged,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      // if (!isAutoSave)
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          onPressed: () {
                            Word currentWord = Word(
                                word: kangiStep.kangis[currentPage].japan,
                                mean: kangiStep.kangis[currentPage].korea,
                                yomikata:
                                    '${kangiStep.kangis[currentPage].undoc} / ${kangiStep.kangis[currentPage].hundoc}',
                                headTitle: '');
                            MyWord.saveToMyVoca(currentWord,
                                isManualSave: true);
                          },
                          icon: const Icon(Icons.save,
                              size: 22, color: Colors.white),
                        ),
                      ),
                      Text(
                        kangiStep.kangis[index].japan,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Text(
                        kangiStep.kangis[index].undoc,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Text(
                        kangiStep.kangis[index].hundoc,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      Text(
                        kangiStep.kangis[index].korea,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      ...List.generate(
                        kangiStep.kangis[index].relatedVoca.length,
                        (index2) => Text(
                          kangiStep.kangis[index].relatedVoca[index2].word,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
