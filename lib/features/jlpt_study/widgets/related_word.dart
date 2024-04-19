import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/admob/banner_ad/global_banner_admob.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/common/controller/tts_controller.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/size.dart';
import 'package:japanese_voca/config/theme.dart';
import 'package:japanese_voca/features/kangi_study/widgets/kangi_card.dart';
import 'package:japanese_voca/model/kangi.dart';
import 'package:japanese_voca/repository/kangis_step_repository.dart';
import 'package:japanese_voca/config/colors.dart';

class RelatedWords extends StatelessWidget {
  const RelatedWords({
    super.key,
    required this.japanese,
    required this.kangiStepRepositroy,
    required this.temp,
  });

  final String japanese;
  final KangiStepRepositroy kangiStepRepositroy;
  final List<String> temp;

  @override
  Widget build(BuildContext context) {
    TtsController ttsController = Get.find<TtsController>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '연관 한자',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Responsive.height10 * 1.8,
            color: AppColors.mainBordColor,
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: Responsive.height16 / 4),
          decoration: const BoxDecoration(color: Colors.grey),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(japanese.length, (index) {
                List<int> kangiIndex =
                    getKangiIndex(japanese, kangiStepRepositroy);

                if (kangiIndex.contains(index)) {
                  if (!temp.contains(japanese[index])) {
                    temp.add(japanese[index]);
                    Kangi kangi =
                        kangiStepRepositroy.getKangi(japanese[index])!;
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Responsive.width16 / 1.5,
                      ),
                      child: InkWell(
                        onTap: () {
                          ttsController.stop();
                          Get.to(
                            preventDuplicates: false,
                            () => RelatedWordScren(
                              kangi: kangi,
                            ),
                          );
                        },
                        child: Card(
                          shadowColor: Colors.white,
                          color: Colors.grey,
                          shape: Border.all(color: Colors.black),
                          child: Padding(
                            padding: EdgeInsets.all(Responsive.width16 / 4),
                            child: Column(
                              children: [
                                Text(
                                  japanese[index],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontFamily: AppFonts.japaneseFont,
                                    color: Colors.black,
                                    fontSize: Responsive.height10 * 2.2,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: Responsive.width16 / 4),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                          color: Colors.black, width: 1.5),
                                    ),
                                  ),
                                  child: Text(
                                    kangi.korea,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Responsive.height14,
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

                return const SizedBox();
              }),
            ),
          ),
        ),
      ],
    );
  }
}

// TODO
class RelatedWordScren extends StatefulWidget {
  const RelatedWordScren({
    super.key,
    required this.kangi,
  });

  final Kangi kangi;
  @override
  State<RelatedWordScren> createState() => _RelatedWordScrenState();
}

class _RelatedWordScrenState extends State<RelatedWordScren> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(appBarHeight),
        child: AppBar(),
      ),
      body: KangiCard(kangi: widget.kangi),
      bottomNavigationBar: const GlobalBannerAdmob(),
    );
  }
}
