import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/theme.dart';
import 'package:japanese_voca/features/jlpt_study/screens/jlpt_study_sceen.dart';
import 'package:japanese_voca/features/jlpt_study/widgets/word_card.dart';
import 'package:japanese_voca/model/kangi.dart';

class KangiCard extends StatelessWidget {
  const KangiCard({
    super.key,
    required this.kangi,
  });
  final Kangi kangi;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                kangi.japan,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Dimentions.height60,
                  color: Colors.black,
                  fontFamily: AppFonts.japaneseFont,
                ),
              ),

              Text(
                kangi.korea,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Dimentions.height25,
                ),
              ),
              const SizedBox(height: 10),
              // TextButton(
              //   onPressed: () {
              //     kangiStudyController.clickRelatedKangi();
              //   },
              //   child: Text(
              //     kangi.japan,
              //     style: TextStyle(
              //       fontWeight: FontWeight.bold,
              //       fontSize: Dimentions.height60,
              //       color: Colors.black,
              //       decoration: TextDecoration.underline,
              //       fontFamily: AppFonts.japaneseFont,
              //       decorationColor: Colors.grey,
              //     ),
              //   ),
              // ),
              // const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '음독 :  ${kangi.undoc}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Dimentions.height18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '훈독 :  ${kangi.hundoc}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Dimentions.height18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(),
              const SizedBox(height: 30),
              Text(
                '연관 단어',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.cyan.shade700,
                ),
              ),
              Container(
                width: double.infinity,
                height: 50,
                decoration: const BoxDecoration(color: Colors.grey),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      kangi.relatedVoca.length,
                      (index2) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: InkWell(
                          onTap: () {
                            print('22222');
                            Get.to(
                              () => Scaffold(
                                appBar: AppBar(),
                                body: WordCard(word: kangi.relatedVoca[index2]),
                              ),
                              preventDuplicates: false,
                            );
                            // Get.to(
                            //   () => Scaffold(
                            //     appBar: AppBar(),
                            //     body: VocaCard(
                            //       word: kangi.relatedVoca[index2],
                            //     ),
                            //   ),
                            // );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 4,
                            ),
                            decoration: const BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.black, width: 2)),
                            ),
                            child: Text(
                              kangi.relatedVoca[index2].word,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
