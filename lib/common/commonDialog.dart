import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class CommonDialog {
  static Future<bool> alertPreviousTestRequired() async {
    Get.dialog(AlertDialog(
      shape: Border.all(),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: Responsive.height10),
          RichText(
            text: TextSpan(
              text: '다음 단계로 넘어가기 위해서 해당 챕터의\n퀴즈에서',
              children: [
                TextSpan(
                  text: ' 100점',
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: Responsive.width18,
                  ),
                ),
                const TextSpan(
                  text: '을 맞으셔야 합니다!',
                )
              ],
              style: TextStyle(
                color: Colors.black,
                fontSize: Responsive.width16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: Responsive.height20),
          const JonggackAvator(),
          SizedBox(height: Responsive.height20),
        ],
      ),
    ));
    return true;
  }

  static Future<void> appealDownLoadThePaidVersion() async {
    Get.dialog(AlertDialog(
      shape: Border.all(),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RichText(
            text: TextSpan(
              text: 'JLPT N1을 더 위해서는',
              children: [
                TextSpan(
                  text: '\nJLPT 종각앱 Plus',
                  style: TextStyle(
                    color: AppColors.mainColor,
                    fontSize: Responsive.width20,
                  ),
                ),
                const TextSpan(
                  text: '를 이용해주세요',
                )
              ],
              style: TextStyle(
                color: Colors.black,
                fontSize: Responsive.width18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(height: Responsive.height10),
          const JonggackAvator(),
          SizedBox(height: Responsive.height40),
          TextButton(
            onPressed: () async {
              if (GetPlatform.isIOS) {
                launchUrl(Uri.parse('https://apps.apple.com/app/id6450434849'));
              } else if (GetPlatform.isAndroid) {
                launchUrl(Uri.parse(
                    'https://play.google.com/store/apps/details?id=com.wonjongseo.jlpt_jonggack_plus'));
              } else {
                launchUrl(Uri.parse('https://apps.apple.com/app/id6450434849'));
              }
            },
            style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              minimumSize: const Size(0, 0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'JLPT종각 Plus 다운로드 하러가기 →',
              style: TextStyle(color: AppColors.mainBordColor),
            ),
          )
        ],
      ),
    ));
  }
}

class JonggackAvator extends StatelessWidget {
  const JonggackAvator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.width10 * 11,
      height: Responsive.width10 * 11,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.fill,
          image: AssetImage(
            'assets/images/my_avator.jpeg',
          ),
        ),
      ),
    );
  }
}
