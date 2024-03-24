import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/controller/tts_controller.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/theme.dart';
import 'package:japanese_voca/features/basic/hiragana/components/hiragana_example_card.dart';
import 'package:japanese_voca/features/basic/hiragana/models/hiragana.dart';
import 'package:kanji_drawing_animation/kanji_drawing_animation.dart';

class HiraganaScreen extends StatefulWidget {
  const HiraganaScreen({super.key, required this.hiraAndkatakana});
  final List<Hiragana> hiraAndkatakana;

  @override
  State<HiraganaScreen> createState() => _HiraganaScreenState();
}

class _HiraganaScreenState extends State<HiraganaScreen> {
  int selectedIndex = 0;
  late Hiragana selectedHiragana;

  @override
  void initState() {
    super.initState();
    selectedHiragana = widget.hiraAndkatakana[0];
  }

  TtsController ttsController = Get.put(TtsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('히리가나'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(Responsive.height16 / 2),
          child: Center(
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    DropdownButtonFormField(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        value: selectedHiragana,
                        items: List.generate(
                          widget.hiraAndkatakana.length,
                          (index) => DropdownMenuItem(
                            value: widget.hiraAndkatakana[index],
                            child: Text(
                              widget.hiraAndkatakana[index].hiragana,
                              style: selectedHiragana ==
                                      widget.hiraAndkatakana[index]
                                  ? TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: Responsive.height10 * 2,
                                      color: Colors.cyan.shade400,
                                    )
                                  : TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: Responsive.height14,
                                    ),
                            ),
                          ),
                        ),
                        onChanged: (v) {
                          selectedHiragana = v!;
                          selectedIndex = 0;
                          setState(() {});
                        }),
                    Padding(
                      padding: EdgeInsets.all(Responsive.height16 / 2),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          selectedHiragana.subHiragana.length,
                          (index) => InkWell(
                            onTap: () {
                              selectedIndex = index;
                              setState(() {});
                            },
                            child: SizedBox(
                              width: Responsive.width10 * 7,
                              height: Responsive.height10 * 5,
                              child: Card(
                                elevation: 0,
                                color: index == selectedIndex
                                    ? Colors.cyan.shade400
                                    : Colors.grey.shade200,
                                child: Center(
                                  child: Text(
                                    selectedHiragana
                                        .subHiragana[index].hiragana,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: Responsive.height10 * 2,
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
                Expanded(
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(Responsive.height16 / 2),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                selectedHiragana
                                    .subHiragana[selectedIndex].hiragana,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: Responsive.height60,
                                  color: Colors.black,
                                  fontFamily: AppFonts.japaneseFont,
                                ),
                              ),
                              SizedBox(
                                height: Responsive.height10 * 10,
                                child: KanjiDrawingAnimation(
                                  selectedHiragana
                                      .subHiragana[selectedIndex].hiragana,
                                  speed: 60,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                '${selectedHiragana.subHiragana[selectedIndex].kSound} [${selectedHiragana.subHiragana[selectedIndex].eSound}]',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Responsive.height18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: Responsive.width10),
                              IconButton(
                                style: IconButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  minimumSize: const Size(0, 0),
                                  tapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                onPressed: () {
                                  ttsController.speak(selectedHiragana
                                      .subHiragana[selectedIndex].hiragana);
                                },
                                icon: FaIcon(
                                  FontAwesomeIcons.volumeOff,
                                  color: Colors.cyan.shade700,
                                  size: Responsive.height10 * 2.4,
                                ),
                              )
                            ],
                          ),
                          const Divider(),
                          SizedBox(height: Responsive.height10 * 3),
                          Text(
                            '예시',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Responsive.height18,
                              color: Colors.cyan.shade700,
                            ),
                          ),
                          SizedBox(height: Responsive.height10 / 2),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: selectedHiragana
                                .subHiragana[selectedIndex].examples!.length,
                            itemBuilder: (context, index) {
                              return HiraganaExampleCard(
                                example: selectedHiragana
                                    .subHiragana[selectedIndex]
                                    .examples![index],
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
