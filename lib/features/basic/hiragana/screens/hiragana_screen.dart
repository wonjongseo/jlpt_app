import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/admob/banner_ad/global_banner_admob.dart';
import 'package:japanese_voca/common/controller/tts_controller.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/config/size.dart';
import 'package:japanese_voca/config/theme.dart';
import 'package:japanese_voca/features/basic/hiragana/components/hiragana_example_card.dart';
import 'package:japanese_voca/features/basic/hiragana/models/hiragana.dart';
import 'package:kanji_drawing_animation/kanji_drawing_animation.dart';

class HiraganaScreen extends StatefulWidget {
  const HiraganaScreen({super.key, required this.category});
  final String category;
  @override
  State<HiraganaScreen> createState() => _HiraganaScreenState();
}

class _HiraganaScreenState extends State<HiraganaScreen> {
  int selectedIndex = 0;
  late Hiragana selectedHiragana;
  late List<Hiragana> hiraAndkatakana;

  @override
  void initState() {
    super.initState();
    if (widget.category == 'hiragana') {
      hiraAndkatakana = hiraganas;
    } else {
      hiraAndkatakana = katakana;
    }
    selectedHiragana = hiraAndkatakana[0];
  }

  TtsController ttsController = Get.find<TtsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(appBarHeight),
        child: AppBar(
          title: Text(
            widget.category == 'hiragana' ? '히라가나 단어장' : '카타카나 단어장',
            style: TextStyle(fontSize: appBarTextSize),
          ),
        ),
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
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(border: Border.all(width: 1)),
                      padding: EdgeInsets.symmetric(
                          horizontal: Responsive.width16 / 2),
                      child: DropdownButton(
                          value: selectedHiragana,
                          underline: Container(),
                          items: List.generate(
                            hiraAndkatakana.length,
                            (index) => DropdownMenuItem(
                              value: hiraAndkatakana[index],
                              child: Text(
                                hiraAndkatakana[index].hiragana,
                                style:
                                    selectedHiragana == hiraAndkatakana[index]
                                        ? TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontFamily: AppFonts.japaneseFont,
                                            fontSize: 18,
                                            color: Colors.cyan.shade500,
                                          )
                                        : const TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontFamily: AppFonts.japaneseFont,
                                            fontSize: 14,
                                          ),
                              ),
                            ),
                          ),
                          onChanged: (v) {
                            selectedHiragana = v!;
                            selectedIndex = 0;
                            setState(() {});
                          }),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
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
                              width: 70,
                              height: 50,
                              child: Card(
                                elevation: 0,
                                color: index == selectedIndex
                                    ? AppColors.mainColor
                                    : Colors.grey.shade200,
                                child: Center(
                                  child: Text(
                                    selectedHiragana
                                        .subHiragana[index].hiragana,
                                    style: const TextStyle(
                                      fontFamily: AppFonts.japaneseFont,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
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
                      padding: EdgeInsets.symmetric(
                        vertical: Responsive.height16,
                        horizontal: Responsive.width16,
                      ),
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
                                height: 100,
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
                                  fontFamily: AppFonts.japaneseFont,
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
                                  color: AppColors.mainBordColor,
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
                              color: AppColors.mainBordColor,
                              fontFamily: AppFonts.japaneseFont,
                            ),
                          ),
                          SizedBox(height: Responsive.height10 / 2),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: List.generate(
                                  selectedHiragana.subHiragana[selectedIndex]
                                      .examples!.length,
                                  (index) => HiraganaExampleCard(
                                    example: selectedHiragana
                                        .subHiragana[selectedIndex]
                                        .examples![index],
                                  ),
                                ),
                              ),
                            ),
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
      bottomNavigationBar: const GlobalBannerAdmob(),
    );
  }
}
