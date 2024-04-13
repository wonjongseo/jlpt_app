import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/controller/tts_controller.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/model/example.dart';

class HiraganaExampleCard extends StatelessWidget {
  const HiraganaExampleCard({super.key, required this.example});
  final Example example;
  @override
  Widget build(BuildContext context) {
    TtsController ttsController = Get.find<TtsController>();
    return Container(
      decoration: BoxDecoration(border: Border.all(width: 0.5)),
      child: ListTile(
        onTap: () => ttsController.speak(example.word),
        leading: Text(
          example.word,
          style: TextStyle(
            fontSize: Responsive.width10 * 1.8,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        title: Row(
          children: [
            Text(
              '(${example.yomikata})',
              style: TextStyle(
                fontSize: Responsive.width10 * 1.6,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(width: Responsive.width10 / 2),
            IconButton(
              style: IconButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: const Size(0, 0),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () {
                ttsController.speak(
                  example.word,
                );
              },
              icon: FaIcon(
                FontAwesomeIcons.volumeOff,
                color: AppColors.mainBordColor,
                size: Responsive.height17,
              ),
            ),
          ],
        ),
        trailing: Text(
          example.mean,
          style: TextStyle(
            fontSize: Responsive.width10 * 1.6,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
