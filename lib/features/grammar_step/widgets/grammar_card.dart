import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/config/theme.dart';
import 'package:japanese_voca/features/grammar_step/widgets/gammar_card_details.dart';
import 'package:japanese_voca/model/grammar.dart';

import '../../../common/admob/controller/ad_controller.dart';
import '../../../common/widget/dimentions.dart';

// ignore: must_be_immutable
class GrammarCard extends StatefulWidget {
  GrammarCard({
    super.key,
    this.onPress,
    this.onPressLike,
    required this.grammars,
    required this.index,
  });

  final int index;
  VoidCallback? onPress;
  final List<Grammar> grammars;
  VoidCallbackIntent? onPressLike;

  @override
  State<GrammarCard> createState() => _GrammarCardState();
}

class _GrammarCardState extends State<GrammarCard> {
  late PageController pageController;
  AdController adController = Get.find<AdController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6),
      child: InkWell(
        onTap: () => Get.to(() {
          pageController = PageController(initialPage: widget.index);
          return GrammarCardDetails(
            pageController: pageController,
            grammars: widget.grammars,
            index: widget.index,
          );
        }),
        child: Card(
          child: Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              child: Text(
                widget.grammars[widget.index].grammar,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: AppFonts.japaneseFont,
                  overflow: TextOverflow.ellipsis,
                ),
              )),
        ),
      ),
    );
  }

  // Column newMethod(Size size) {
  //   return Column(
  //     children: [
  //       Text(
  //         widget.grammar.grammar,
  //         textAlign: TextAlign.center,
  //         style: const TextStyle(
  //           fontWeight: FontWeight.bold,
  //           color: AppColors.scaffoldBackground,
  //           fontFamily: AppFonts.japaneseFont,
  //         ),
  //       ),
  //       Visibility(
  //         visible: isClick,
  //         child: Divider(height: Dimentions.height20),
  //       ),
  //       Visibility(
  //         visible: isClick,
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             if (widget.grammar.connectionWays.isNotEmpty)
  //               GrammarDescriptionCard(
  //                   fontSize: size.width / 300 + 11,
  //                   title: '접속 형태',
  //                   content: widget.grammar.connectionWays),
  //             if (widget.grammar.connectionWays.isNotEmpty)
  //               const Divider(height: 20),
  //             if (widget.grammar.means.isNotEmpty)
  //               GrammarDescriptionCard(
  //                   fontSize: size.width / 300 + 12,
  //                   title: '뜻',
  //                   content: widget.grammar.means),
  //             if (widget.grammar.means.isNotEmpty) const Divider(height: 20),
  //             if (widget.grammar.description.isNotEmpty)
  //               GrammarDescriptionCard(
  //                   fontSize: size.width / 300 + 13,
  //                   title: '설명',
  //                   content: widget.grammar.description),
  //             Divider(height: Dimentions.height20),
  //             InkWell(
  //               child: Container(
  //                 decoration: BoxDecoration(
  //                     color: Colors.white,
  //                     boxShadow: [
  //                       BoxShadow(
  //                         color: AppColors.scaffoldBackground.withOpacity(0.3),
  //                         blurRadius: 1,
  //                         offset: const Offset(1, 1),
  //                       ),
  //                       BoxShadow(
  //                         color: AppColors.scaffoldBackground.withOpacity(0.3),
  //                         blurRadius: 1,
  //                         offset: const Offset(-1, -1),
  //                       )
  //                     ],
  //                     borderRadius: BorderRadius.circular(Dimentions.height10)),
  //                 width: double.infinity,
  //                 child: Padding(
  //                   padding: EdgeInsets.all(Dimentions.height30 / 2),
  //                   child: const Text(
  //                     '예제',
  //                     textAlign: TextAlign.center,
  //                     style: TextStyle(
  //                       color: Colors.blue,
  //                       fontWeight: FontWeight.bold,
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //               onTap: () async {
  //                 if (await userController.useHeart()) {
  //                   await Get.bottomSheet(
  //                     backgroundColor: AppColors.scaffoldBackground,
  //                     Padding(
  //                       padding: EdgeInsets.all(Dimentions.height16)
  //                           .copyWith(right: 0),
  //                       child: SizedBox(
  //                         width: double.infinity,
  //                         child: SingleChildScrollView(
  //                           child: Column(
  //                             children: [
  //                               ...List.generate(widget.grammar.examples.length,
  //                                   (index) {
  //                                 return GrammarExampleCard(
  //                                   example: widget.grammar.examples[index],
  //                                 );
  //                               }),
  //                             ],
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   );
  //                   ttsController.stop();
  //                 } else {
  //                   bool result = await askToWatchMovieAndGetHeart(
  //                     title: const Text('하트가 부족해요!!'),
  //                     content: const Text(
  //                         '광고를 시청하고 하트 ${AppConstant.HERAT_COUNT_AD}개를 채우시겠습니까 ?',
  //                         style:
  //                             TextStyle(color: AppColors.scaffoldBackground)),
  //                   );

  //                   if (result) {
  //                     adController.showRewardedInterstitialAd();
  //                     userController.plusHeart(
  //                         plusHeartCount: AppConstant.HERAT_COUNT_AD);
  //                   }
  //                 }
  //               },
  //             )
  //           ],
  //         ),

  //       ),
  //     ],
  //   );
  // }
}
