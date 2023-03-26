import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/config/constatns.dart';
// import 'package:sqflite/sqflite.dart';

class VocaCard extends StatefulWidget {
  VocaCard({super.key, this.onPress, this.onPressLike});

  VoidCallback? onPress;
  // final Vocabulary voca;
  VoidCallbackIntent? onPressLike;

  @override
  State<VocaCard> createState() => _VocaCardState();
}

class _VocaCardState extends State<VocaCard> {
  // final FlutterTts tts = FlutterTts();
  // @override
  // void initState() {
  //   super.initState();
  //   setTTS();
  //   tts.setLanguage('en');
  //   tts.setSpeechRate(0.4);
  // }

  // void setTTS() async {
  //   await tts.setSharedInstance(true);
  // }

  bool isClick = false;
  double _height = 100;
  // late WordApiDatasource wordApiDatasource;

  @override
  void initState() {
    super.initState();
    //  wordApiDatasource = WordApiDatasource();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        height: _height,
        decoration: cBoxDecoration,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    // tts.speak(widget.voca.voca);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4, left: 8),
                    child:
                        SvgPicture.asset('assets/svg/speaker.svg', height: 20),
                  ),
                ),
                // widget.voca.isMine
                //     ? InkWell(
                //         onTap: widget.onPress!,
                //         child: const Padding(
                //           padding: EdgeInsets.only(top: 4, right: 8.0),
                //           child: Icon(
                //             Icons.remove,
                //             size: 28,
                //           ),
                //         ),
                //       )
                //     : GetBuilder<VocabularyController>(builder: (controller) {
                //         return !widget.voca.isLike
                //             ? InkWell(
                //                 child: Padding(
                //                   padding:
                //                       const EdgeInsets.only(top: 4, right: 10),
                //                   child: SvgPicture.asset(
                //                     'assets/svg/star_boder.svg',
                //                     height: 20,
                //                   ),
                //                 ),
                //                 onTap: () {
                //                   controller.addLikeVocabulary(widget.voca);
                //                 },
                //               )
                //             : InkWell(
                //                 child: Padding(
                //                   padding:
                //                       const EdgeInsets.only(top: 4, right: 10),
                //                   child: SvgPicture.asset(
                //                     'assets/svg/star_full.svg',
                //                     height: 20,
                //                   ),
                //                 ),
                //                 onTap: () {
                //                   controller.deleteLikeVocabulary(widget.voca);
                //                 },
                //               );
                //       })
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                  child: Text(
                    'widget.voca.word',
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 21,
                        overflow: TextOverflow.clip),
                  ),
                ),
                if (isClick)
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Center(
                      child: Text('widget.voca.mean'),
                    ),
                  )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  // onTap: showExample,
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 4, left: 8.0),
                    child: SvgPicture.asset('assets/svg/eye.svg',
                        color: Colors.black, height: 20),
                  ),
                ),
                isClick
                    ? InkWell(
                        onTap: () {
                          setState(() {
                            _height = 100;
                            isClick = false;
                          });
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(bottom: 4, right: 8.0),
                          child: Icon(
                            Icons.keyboard_arrow_up,
                            size: 28,
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          setState(() {
                            _height = 150;
                            isClick = true;
                          });
                        },
                        child: const Padding(
                          padding: EdgeInsets.only(bottom: 4, right: 8.0),
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            size: 28,
                          ),
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  int getExampleIndex(List<String> exampleList, String word) {
    int exampleIndex = exampleList.indexOf(word);
    if (exampleIndex == -1) {
      exampleIndex = exampleList.indexOf('${word}s');
      if (exampleIndex == -1) {
        exampleIndex = exampleList.indexOf('${word}ed');
        if (exampleIndex == -1) {
          exampleIndex = exampleList.indexOf('${word}d');
        }
      }
    }
    return exampleIndex;
  }

  // void showExample() async {
  //   String word = widget.voca.word;
  //   Future<List<dynamic>> examplesFuture =
  //       wordApiDatasource.getWordExample(word);

  //   Get.dialog(
  //     StatefulBuilder(
  //       builder: (context, setState) {
  //         return AlertDialog(
  //           title: Text(
  //             '예제',
  //             style: Theme.of(context).textTheme.bodySmall,
  //           ),
  //           content: FutureBuilder(
  //               future: examplesFuture,
  //               builder: (context, snapshot) {
  //                 if (snapshot.hasData == false) {
  //                   return SizedBox(
  //                     width: 30,
  //                     height: 30,
  //                     child: Center(child: const CircularProgressIndicator()),
  //                   );
  //                 } else if (snapshot.hasError) {
  //                   return Padding(
  //                     padding: const EdgeInsets.all(8.0),
  //                     child: Text('Error: ${snapshot.error}'),
  //                   );
  //                 } else {
  //                   List<dynamic> examples = snapshot.data as List<dynamic>;

  //                   return examples.isNotEmpty
  //                       ? Container(
  //                           height: (examples.length * 65),
  //                           child: SingleChildScrollView(
  //                             child: Column(
  //                               crossAxisAlignment: CrossAxisAlignment.start,
  //                               children: List.generate(
  //                                 examples.length,
  //                                 (index) {
  //                                   String example = examples[index];
  //                                   List<String> exampleList =
  //                                       example.split(' ');
  //                                   int exampleIndex =
  //                                       getExampleIndex(exampleList, word);

  //                                   return ExampleMeanCard(
  //                                     example: example,
  //                                     exampleList: exampleList,
  //                                     exampleIndex: exampleIndex,
  //                                     index: index,
  //                                   );
  //                                 },
  //                               ),
  //                             ),
  //                           ),
  //                         )
  //                       : const Text('준비된 예제가 없습니다.');
  //                 }
  //               }),
  //           actions: [
  //             TextButton(
  //               onPressed: () async {
  //                 Get.back();
  //               },
  //               child: const Text('Back'),
  //             )
  //           ],
  //         );
  //       },
  //     ),
  //   );
  // }

}
