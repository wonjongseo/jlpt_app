import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:japanese_voca/common/widget/cusomt_button.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class TutorialWordSceen extends StatefulWidget {
  const TutorialWordSceen({super.key});

  @override
  State<TutorialWordSceen> createState() => _TutorialWordSceenState();
}

class _TutorialWordSceenState extends State<TutorialWordSceen> {
  List<TargetFocus> targets = [];
  GlobalKey key1 = GlobalKey();
  GlobalKey key2 = GlobalKey();
  GlobalKey key3 = GlobalKey();
  GlobalKey key4 = GlobalKey();
  GlobalKey key5 = GlobalKey();
  @override
  void initState() {
    super.initState();
    initTutorial();
  }

  void showTutorial() {
    TutorialCoachMark(
      targets: targets,
      onClickTarget: (target) {
        // Get.dialog(AlertDialog(
        //   content: Text('EEE'),
        // ));
      },
      onClickTargetWithTapPosition: (target, tapDetails) {
        print("'onClickTargetWithTapPosition");
      },
      onClickOverlay: (target) {
        print('onClickOverlay');
      },
      onSkip: () {
        print("skip");
      },
      onFinish: () {
        print("finish");
      },
    ).show(context: context);
  }

  void initTutorial() {
    targets.addAll(
      [
        TargetFocus(
          identify: "한자를 클릭하면 [음독, 훈독, 연관 단어] 를 확인 할 수 있습니다.",
          keyTarget: key1,
          contents: [
            TargetContent(
              align: ContentAlign.top,
              child: const Text(
                "한자를 클릭하면 [음독, 훈독, 연관 단어] 를 확인 할 수 있습니다.",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20.0),
              ),
            )
          ],
        ),
        TargetFocus(
          identify: "Target 2",
          keyTarget: key2,
          contents: [
            TargetContent(
              align: ContentAlign.right,
              child: const Text(
                "Target 2",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20.0),
              ),
            )
          ],
        ),
        TargetFocus(
          identify: "Target 3",
          keyTarget: key3,
          contents: [
            TargetContent(
              align: ContentAlign.right,
              child: const Text(
                "Title 3",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20.0),
              ),
            )
          ],
        ),
        TargetFocus(
          identify: "Target 4",
          keyTarget: key4,
          contents: [
            TargetContent(
              align: ContentAlign.right,
              child: const Text(
                "Title 4",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20.0),
              ),
            )
          ],
        ),
        TargetFocus(
          identify: "Target 5",
          keyTarget: key5,
          contents: [
            TargetContent(
              align: ContentAlign.right,
              child: const Text(
                "Title 5",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20.0),
              ),
            )
          ],
        ),
      ],
    );
  }

  bool isShownYomikata = false;
  bool isShownMean = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    showTutorial();
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 14),
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  'TEST',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
          title: FAProgressBar(
            currentValue: 40,
            maxValue: 100,
            displayText: '%',
            size: size.width > 500 ? 35 : 25,
            formatValueFixed: 0,
            backgroundColor: AppColors.darkGrey,
            progressColor: AppColors.lightGreen,
            borderRadius: size.width > 500
                ? BorderRadius.circular(30)
                : BorderRadius.circular(12),
            displayTextStyle: TextStyle(
                color: const Color(0xFFFFFFFF),
                fontSize: size.width > 500 ? 18 : 14),
          )),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.save, size: 22, color: Colors.white),
            ),
          ),
          const Spacer(flex: 1),
          Column(
            children: [
              SizedBox(
                  child: Text('さいきん',
                      style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w700,
                          color: isShownYomikata
                              ? Colors.white
                              : Colors.transparent))),
              //
              Wrap(
                children: [
                  InkWell(
                    // onTap: () => getDialogKangi(japanese[index], context,
                    //     clickTwice: clickTwice),
                    child: Text(
                      key: key1,
                      '食',
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.grey,
                          color: Colors.white,
                          fontSize: 60),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Text(
                    'べる',
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          fontSize: 60,
                          color: Colors.white,
                        ),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
              const SizedBox(height: 15),
              SizedBox(
                  child: Text('최근',
                      style: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w700,
                          color: isShownMean
                              ? Colors.white
                              : Colors.transparent))),
            ],
          ),
          const SizedBox(height: 32),
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (!isShownYomikata)
                    CustomButton(
                      key: key2,
                      text: '의미',
                      onTap: () {
                        if (!isShownMean) {}
                      },
                    ),
                  const SizedBox(width: 16),
                  if (!isShownYomikata)
                    CustomButton(
                      key: key3,
                      text: '읽는 법',
                      onTap: () {
                        if (!isShownYomikata) {
                          // showYomikata();
                        }
                      },
                    ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomButton(
                    key: key4,
                    text: '몰라요',
                    onTap: () {
                      // nextWord(false);
                    },
                  ),
                  const SizedBox(width: 16),
                  CustomButton(
                    key: key5,
                    text: '알아요',
                    onTap: () {
                      // nextWord(true);
                    },
                  ),
                ],
              ),
            ],
          ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}
