import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/config/colors.dart';

import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/model/example.dart';
import 'package:japanese_voca/common/controller/tts_controller.dart';
import 'package:japanese_voca/repository/kangis_step_repository.dart';

import '../../../config/theme.dart';

class GrammarExampleCard extends StatefulWidget {
  const GrammarExampleCard({
    super.key,
    required this.examples,
    required this.index,
  });
  // final Example example;
  final List<Example> examples;
  final int index;
  @override
  State<GrammarExampleCard> createState() => _GrammarExampleCardState();
}

class _GrammarExampleCardState extends State<GrammarExampleCard> {
  KangiStepRepositroy kangiStepRepositroy = KangiStepRepositroy();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: Responsive.height16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Html(
                      style: {
                        "*": Style(
                          margin: Margins.zero,
                          fontFamily: AppFonts.japaneseFont,
                          fontSize: FontSize(Responsive.height17),
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                        "span": Style(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      },
                      data:
                          '${widget.index + 1}. ${widget.examples[widget.index].word}',
                    ),
                    Text(
                      widget.examples[widget.index].mean,
                      style: TextStyle(
                        fontSize: Responsive.height16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          GetBuilder<TtsController>(
            builder: (ttsController) {
              return IconButton(
                style: IconButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(20, 20),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {
                  String grammar = widget.examples[widget.index].word;
                  grammar = grammar.replaceAll('<span class=\"bold\">', '');
                  grammar = grammar.replaceAll('</span>', '');
                  ttsController.speak(grammar);
                },
                icon: FaIcon(
                  ttsController.isPlaying
                      ? FontAwesomeIcons.volumeLow
                      : FontAwesomeIcons.volumeOff,
                  color: AppColors.mainBordColor,
                  size: Responsive.height10 * 2.6,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// class GrammarDetailScreen extends StatefulWidget {
//   const GrammarDetailScreen({
//     super.key,
//     // required this.index,
//     required this.examples,
//   });

//   // final int index;
//   final List<Example> examples;

//   @override
//   State<GrammarDetailScreen> createState() => _GrammarDetailScreenState();
// }

// class _GrammarDetailScreenState extends State<GrammarDetailScreen> {
//   late PageController pageController;
//   int currentIndex = 0;
//   KangiStepRepositroy kangiStepRepositroy = KangiStepRepositroy();

//   @override
//   void initState() {
//     super.initState();
//     // currentIndex = widget.index;
//     pageController = PageController(initialPage: currentIndex);
//   }

//   @override
//   void dispose() {
//     pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: const Size.fromHeight(appBarHeight),
//         child: AppBar(
//           title: RichText(
//             text: TextSpan(
//               style: TextStyle(color: Colors.black, fontSize: appBarTextSize),
//               children: [
//                 TextSpan(
//                   text: '${currentIndex + 1}',
//                   style: TextStyle(
//                     color: Colors.cyan.shade500,
//                     fontSize: Responsive.height10 * 2.5,
//                   ),
//                 ),
//                 const TextSpan(text: ' / '),
//                 TextSpan(text: '${widget.examples.length}')
//               ],
//             ),
//           ),
//         ),
//       ),
//       body: SafeArea(
//         child: Center(
//             child: PageView.builder(
//           controller: pageController,
//           itemCount: widget.examples.length,
//           onPageChanged: onPageChanged,
//           itemBuilder: (context, index) {
//             return Padding(
//               padding: EdgeInsets.symmetric(horizontal: Responsive.width10),
//               child: Card(
//                 child: Padding(
//                   padding: EdgeInsets.all(Responsive.width14),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       SizedBox(height: Responsive.height10),
//                       // Row(
//                       //   children: [
//                       //     Text(
//                       //       '예제',
//                       //       style: TextStyle(
//                       //         fontWeight: FontWeight.bold,
//                       //         fontSize: Responsive.height10 * 1.8,
//                       //         color: AppColors.mainBordColor,
//                       //       ),
//                       //     ),
//                       //   ],
//                       // ),
//                       // RichText(
//                       //   text: TextSpan(
//                       //     children: [
//                       //       TextSpan(text: widget.examples[index].word),
//                       //       const TextSpan(text: '  '),
//                       //       WidgetSpan(
//                       //         child: GetBuilder<TtsController>(
//                       //           builder: (ttsController) {
//                       //             return IconButton(
//                       //               style: IconButton.styleFrom(
//                       //                 padding: EdgeInsets.zero,
//                       //                 minimumSize: const Size(0, 0),
//                       //                 tapTargetSize:
//                       //                     MaterialTapTargetSize.shrinkWrap,
//                       //               ),
//                       //               onPressed: () => ttsController.speak(
//                       //                 widget.examples[index].word,
//                       //               ),
//                       //               icon: FaIcon(
//                       //                 ttsController.isPlaying
//                       //                     ? FontAwesomeIcons.volumeLow
//                       //                     : FontAwesomeIcons.volumeOff,
//                       //                 color: AppColors.mainBordColor,
//                       //               ),
//                       //             );
//                       //           },
//                       //         ),
//                       //       ),
//                       //     ],
//                       //     style: TextStyle(
//                       //       color: Colors.black,
//                       //       letterSpacing: 3,
//                       //       fontSize: Responsive.width20,
//                       //       fontWeight: FontWeight.bold,
//                       //       fontFamily: AppFonts.japaneseFont,
//                       //     ),
//                       //   ),
//                       // ),
//                       // SizedBox(height: Responsive.height10),
//                       // Text(
//                       //   widget.examples[index].mean,
//                       //   style: const TextStyle(fontSize: 18),
//                       // ),
//                       // const Divider(),
//                       // SizedBox(height: Responsive.height10 * 1.5),
//                       // RelatedWords(
//                       //   japanese: widget.examples[index].word,
//                       //   kangiStepRepositroy: kangiStepRepositroy,
//                       //   temp: temp,
//                       // ),
//                       SpeechBodyWidget(
//                         example: widget.examples[index],
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         )),
//       ),
//       bottomNavigationBar: const GlobalBannerAdmob(),
//     );
//   }

//   void onPageChanged(value) {
//     currentIndex = value;
//     // resetText();
//     setState(() {});
//   }
// }
