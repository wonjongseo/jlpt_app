import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/screen/grammar/grammar_example_screen.dart';
import 'package:japanese_voca/model/grammar.dart';

import '../../../ad_controller.dart';
import '../../../common/common.dart';
import '../../../controller/user_controller.dart';

// ignore: must_be_immutable
class GrammarCard extends StatefulWidget {
  GrammarCard({
    super.key,
    this.onPress,
    this.onPressLike,
    required this.grammar,
  });

  VoidCallback? onPress;
  final Grammar grammar;
  VoidCallbackIntent? onPressLike;

  @override
  State<GrammarCard> createState() => _GrammarCardState();
}

class _GrammarCardState extends State<GrammarCard> {
  UserController userController = Get.find<UserController>();
  AdController adController = Get.find<AdController>();

  bool isClick = false;

  bool isClickExample = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: AnimatedSize(
        // Down 애니메이션
        alignment: const Alignment(0, -1),
        duration: const Duration(milliseconds: 500),
        child: Container(
          padding: const EdgeInsets.all(16),
          width: size.width * 0.85,
          decoration: BoxDecoration(
            color:
                Get.isDarkMode ? Colors.white.withOpacity(0.1) : Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(1, 1),
              )
            ],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  isClick = !isClick;
                  isClickExample = false;
                  setState(() {});
                },
                child: Text(
                  widget.grammar.grammar,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Visibility(
                visible: isClick,
                child: const Divider(height: 20),
              ),
              Visibility(
                visible: isClick,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.grammar.connectionWays.isNotEmpty)
                      GrammarCardSection(
                          title: '접속 형태',
                          content: widget.grammar.connectionWays),
                    if (widget.grammar.connectionWays.isNotEmpty)
                      const Divider(height: 20),
                    if (widget.grammar.means.isNotEmpty)
                      GrammarCardSection(
                          title: '뜻', content: widget.grammar.means),
                    if (widget.grammar.means.isNotEmpty)
                      const Divider(height: 20),
                    if (widget.grammar.description.isNotEmpty)
                      GrammarCardSection(
                          title: '설명', content: widget.grammar.description),
                    const Divider(height: 20),
                    InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 1,
                                offset: const Offset(1, 1),
                              ),
                              BoxShadow(
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 1,
                                offset: const Offset(-1, -1),
                              )
                            ],
                            borderRadius: BorderRadius.circular(10)),
                        width: double.infinity,
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            '예제',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      onTap: () async {
                        if (await userController.useHeart()) {
                          Get.bottomSheet(
                            backgroundColor: AppColors.scaffoldBackground,
                            persistent: false,
                            Padding(
                              padding:
                                  const EdgeInsets.all(16.0).copyWith(right: 0),
                              child: SizedBox(
                                width: double.infinity,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      ...List.generate(
                                          widget.grammar.examples.length,
                                          (index) {
                                        return GrammarExampleCard(
                                          example:
                                              widget.grammar.examples[index],
                                        );
                                      }),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        } else {
                          bool result = await askToWatchMovieAndGetHeart(
                            title: const Text('하트가 부족해요!!'),
                            content: const Text('광고를 시청하고 하트 3개를 채우시겠습니까 ?'),
                          );

                          if (result) {
                            adController.showRewardedAd();
                            userController.plusHeart(plusHeartCount: 3);
                          }
                        }
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GrammarCardSection extends StatelessWidget {
  const GrammarCardSection({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
              text: title,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w600)),
          const TextSpan(text: ' :\n'),
          TextSpan(
            text: content,
            style: TextStyle(color: Colors.black, fontSize: width / 300 + 10),
          )
        ],
      ),
    );
  }
}
