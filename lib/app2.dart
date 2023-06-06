import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/screen/home/components/welcome_widget.dart';
import 'package:japanese_voca/user_controller2.dart';

class App2 extends StatefulWidget {
  const App2({super.key});

  @override
  State<App2> createState() => _App2State();
}

List<String> jlptLevels = ['N1', 'N2', 'N3', 'N4', 'N5'];

class _App2State extends State<App2> {
  late PageController pageController;
  UserController2 userController2 = Get.find<UserController2>();

  int currentPageIndex = 0;
  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  void pageChange(int page) {
    currentPageIndex = page;
    pageController.jumpToPage(currentPageIndex);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.small(onPressed: () {
        userController2.updateCurrentProgress(TotalProgressType.JLPT, 1, 2626);
      }),
      body: Column(
        children: [
          const WelcomeWidget(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                jlptLevels.length,
                (index) => ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        index == currentPageIndex ? primaryColor : null,
                  ),
                  onPressed: () {
                    pageChange(index);
                  },
                  child: Text(
                    jlptLevels[index],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              controller: pageController,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      Text(
                        index.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'JLPT 단어',
                            style: TextStyle(color: AppColors.whiteGrey),
                          ),
                          Row(
                            children: [
                              Text.rich(
                                TextSpan(
                                  text: userController2
                                      .user.currentKangiScores[index]
                                      .toString(),
                                  children: [
                                    const TextSpan(text: ' / '),
                                    TextSpan(
                                      text: userController2
                                          .user.jlptWordScroes[index]
                                          .toString(),
                                    ),
                                  ],
                                ),
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(width: 10),
                              SizedBox(
                                height: 100,
                                width: 100,
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: defaultPadding * 0.7),
                                  child: AnimatedCircularProgressIndicator(
                                      currentProgressCount: userController2
                                          .user.currentKangiScores[index],
                                      totalProgressCount: userController2
                                          .user.jlptWordScroes[index]),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      if (index < 3)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'JLPT 문법',
                              style: TextStyle(color: AppColors.whiteGrey),
                            ),
                            Row(
                              children: [
                                Text.rich(
                                  TextSpan(
                                    text: userController2
                                        .user.currentGrammarScores[index]
                                        .toString(),
                                    children: [
                                      const TextSpan(text: ' / '),
                                      TextSpan(
                                        text: userController2
                                            .user.grammarScores[index]
                                            .toString(),
                                      ),
                                    ],
                                  ),
                                  style: const TextStyle(color: Colors.white),
                                ),
                                const SizedBox(width: 10),
                                SizedBox(
                                  height: 100,
                                  width: 100,
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: defaultPadding * 0.7),
                                    child: AnimatedCircularProgressIndicator(
                                        currentProgressCount: userController2
                                            .user.currentGrammarScores[index],
                                        totalProgressCount: userController2
                                            .user.grammarScores[index]),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'JLPT 한자',
                            style: TextStyle(color: AppColors.whiteGrey),
                          ),
                          Row(
                            children: [
                              Text.rich(
                                TextSpan(
                                  text: userController2
                                      .user.currentKangiScores[index]
                                      .toString(),
                                  children: [
                                    const TextSpan(text: ' / '),
                                    TextSpan(
                                        text: userController2
                                            .user.kangiScores[index]
                                            .toString()),
                                  ],
                                ),
                                style: TextStyle(color: Colors.white),
                              ),
                              const SizedBox(width: 10),
                              SizedBox(
                                height: 100,
                                width: 100,
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: defaultPadding * 0.7),
                                  child: AnimatedCircularProgressIndicator(
                                    currentProgressCount: userController2
                                        .user.currentKangiScores[index],
                                    totalProgressCount:
                                        userController2.user.kangiScores[index],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

const primaryColor = Color(0xFFFFC107);
const secondaryColor = Color(0xFF242430);
const darkColor = Color(0xFF191923);
const bodyTextColor = Color(0xFF8B8B8D);
const bgColor = Color(0xFF1E1E28);

const defaultPadding = 20.0;
const defaultDuration = Duration(seconds: 1);
TextStyle sectionTitleStyle(context) => Theme.of(context).textTheme.subtitle2!;
const maxWidth = 1440.0;

class AnimatedCircularProgressIndicator extends StatelessWidget {
  const AnimatedCircularProgressIndicator(
      {super.key,
      required this.currentProgressCount,
      required this.totalProgressCount});

  final int currentProgressCount;
  final int totalProgressCount;

  @override
  Widget build(BuildContext context) {
    double percentage = currentProgressCount / totalProgressCount;

    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: percentage),
            duration: defaultDuration,
            builder: (context, double value, child) => Stack(
              fit: StackFit.expand,
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: value,
                  color: primaryColor,
                  backgroundColor: darkColor,
                ),
                Center(
                  child: Text(
                    "${(value * 100).toInt()}%",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // const SizedBox(height: defaultPadding / 2),
        // Text(
        //   label!,
        //   overflow: TextOverflow.ellipsis,
        //   maxLines: 1,
        //   style: sectionTitleStyle(context),
        // ),
      ],
    );
  }
}
