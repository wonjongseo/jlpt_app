import 'package:get/get.dart';
import 'package:japanese_voca/ad_controller.dart';
import 'package:japanese_voca/controller/user_controller.dart';
import 'package:japanese_voca/screen/kangi/components/kangi_related_card.dart';
import 'package:japanese_voca/model/kangi.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/repository/kangis_step_repository.dart';
import 'package:flutter/material.dart';
import 'package:japanese_voca/common/common.dart';

class TouchableJapanese extends StatelessWidget {
  const TouchableJapanese({
    Key? key,
    required this.japanese,
    required this.clickTwice,
    required this.fontSize,
    required this.underlineColor,
    this.color = Colors.white,
  }) : super(key: key);
  final Color underlineColor;
  final String japanese;
  final bool clickTwice;
  final double fontSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    KangiStepRepositroy kangiStepRepositroy = KangiStepRepositroy();

    UserController userController = Get.find<UserController>();
    AdController adController = Get.find<AdController>();
    List<int> kangiIndex = getKangiIndex(japanese);
    bool isKataka = isKatakana(japanese);

    if (isKataka) {
      return Text(
        japanese,
        style: Theme.of(context).textTheme.displaySmall?.copyWith(
              fontSize: fontSize,
              color: color,
            ),
        textAlign: TextAlign.center,
      );
    }

    return Wrap(
      children: List.generate(japanese.length, (index) {
        if (kangiIndex.contains(index)) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: fontSize == 0 ? 4 : 0),
            child: InkWell(
              onTap: () async {
                Kangi? kangi = kangiStepRepositroy.getKangi(japanese[index]);

                if (kangi == null) {
                  Get.dialog(
                    AlertDialog(
                      content: Text('한자 ${japanese[index]} 아직 준비 되어 있지 않습니다.'),
                    ),
                  );
                  return;
                }

                if (await userController.useHeart()) {
                  getDialogKangi(kangi, clickTwice: clickTwice);
                } else {
                  bool result = await askToWatchMovieAndGetHeart(
                    title: const Text('하트가 부족해요!!'),
                    content: const Text('광고를 시청하고 하트 3개를 채우시겠습니까 ?'),
                  );

                  if (result) {
                    // AD
                    adController.showRewardedInterstitialAd();
                    userController.plusHeart(plusHeartCount: 3);
                  }
                }
              },
              child: Text(
                japanese[index],
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline,
                    decorationColor: underlineColor,
                    color: color,
                    fontSize: fontSize),
                textAlign: TextAlign.center,
              ),
            ),
          );
        } else {
          return Text(
            japanese[index],
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontSize: fontSize,
                  color: color,
                ),
            textAlign: TextAlign.center,
          );
        }
      }),
    );
  }
}

bool getDialogKangi(Kangi kangi, {clickTwice = false}) {
  if (clickTwice) {
    print('Popup ad');
  }

  Get.dialog(
    AlertDialog(
      titlePadding:
          const EdgeInsets.only(top: 16, bottom: 0, right: 16, left: 16),
      title: Text(
        kangi.japan,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            kangi.korea,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),

          //
          const SizedBox(height: 10),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('음독 : ${kangi.undoc}'),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: Text('훈독 : ${kangi.hundoc}'),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (kangi.relatedVoca.isNotEmpty && !clickTwice)
                ElevatedButton(
                  onPressed: () => Get.back(),
                  child: const Text(
                    '나가기',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              const SizedBox(width: 10),
              if (clickTwice)
                ElevatedButton(
                  onPressed: () => Get.back(),
                  child: const Text(
                    '나가기',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              else
                ElevatedButton(
                  onPressed: () {
                    if (kangi.relatedVoca.isEmpty) {
                      Get.back();
                    } else {
                      int currentIndex = 0;

                      Get.dialog(
                        AlertDialog(
                          contentPadding: EdgeInsets.zero,
                          titlePadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: () => getBacks(2),
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.black,
                                ),
                              ),
                              Text(
                                kangi.korea,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  MyWord.saveToMyVoca(
                                    kangi.relatedVoca[currentIndex],
                                    isManualSave: true,
                                  );
                                },
                                icon: const Icon(
                                  Icons.save,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          content: KangiRelatedCard(
                            kangi: kangi,
                          ),
                        ),
                        transitionCurve: Curves.easeInOut,
                      );
                    }
                  },
                  child: Text(
                    kangi.relatedVoca.isEmpty ? '나가기' : '연관 단어',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          )
        ],
      ),
    ),
  );
  return true;
}