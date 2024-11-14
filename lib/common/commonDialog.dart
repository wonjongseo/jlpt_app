import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/app_constant.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/config/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class CommonDialog {
  static Future<bool> askToDeleteAllMyWord(int countOfWords) async {
    return selectionDialog(
      title: Text(
        '선택된 $countOfWords개의 단어를 삭제 하시겠습니까?',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: Responsive.height16,
        ),
      ),
      connent: const Text(
        '삭제 후 복구는 불가능합니다.\n그래도 삭제 하시겠습니까?',
        style: TextStyle(color: AppColors.scaffoldBackground),
      ),
    );
  }

  static Future<bool> askToDeleteAllDataOneMore() async {
    return selectionDialog(
      title: Text(
        '정말 초기화를 안하시나요?',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: Responsive.height20,
          fontFamily: AppFonts.japaneseFont,
        ),
      ),
      connent: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text:
                  '수정된 데이터로 종각앱을 학습하면 더 정확하고 많은 예제로 학습할 수 있습니다.\n 문법 예시의 읽는 법도 추가 되었습니다.\n\n초기화 하시겠습니까??',
              style: TextStyle(
                color: Colors.black,
                fontFamily: AppFonts.japaneseFont,
                fontWeight: FontWeight.w100,
                fontSize: Responsive.height16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Future<bool> askToDeleteAllDataForUpdateDatas() async {
    return selectionDialog(
      title: Text(
        '데이터를 초기화 하시겠습니까?',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: Responsive.height20,
          fontFamily: AppFonts.japaneseFont,
        ),
      ),
      connent: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '종각앱의 데이터가 대량 수정・추가 되었습니다.\n\n',
              children: const [
                TextSpan(text: '수정・추가된 데이터로 학습하려면 종각앱의 데이터를 '),
                TextSpan(
                  text: '1회',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
                TextSpan(text: ' 초기화를 해야 합니다.\n\n데이터를 초기화하시겠습니까? '),
                TextSpan(
                  text: '(권장)',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ],
              style: TextStyle(
                color: Colors.black,
                fontFamily: AppFonts.japaneseFont,
                fontWeight: FontWeight.w100,
                fontSize: Responsive.height16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Future<bool> alertPreviousTestRequired() async {
    return selectionDialog(
      title: RichText(
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
      connent: const Text(
        '해당 챕터의 퀴즈를 보시겠습니까?',
        style: TextStyle(color: AppColors.scaffoldBackground),
      ),
    );
  }

  static Future<bool> askSetSubjectQuestionOfJlptTestDialog() async {
    return selectionDialog(
      title: Text(
        '주관식 문제를 활성화 하시겠습니까?',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: Responsive.height16,
        ),
      ),
      connent: const Text(
        '일본어 단어 퀴즈에 읽는 법을 직접 입력하는 기능이 있습니다.\n해당 기능을 활성화하면 일본어 학습하는데 도움이 됩니다.',
        style: TextStyle(color: AppColors.scaffoldBackground),
      ),
    );
  }

  static Future<bool> askSaveExcelDatasDialog() async {
    return selectionDialog(
      title: const Text('광고를 시청하고 엑셀에 있는 데이터를\n나만의 단어장에 저장하시겠습니까?'),
    );
  }

  static Future<bool> askGoToMyVocaPageDialog(int savedCount) async {
    return selectionDialog(
      title: Text('단어가 $savedCount개 이상이나 저장되었어요!'),
      connent: const Text(
        '나만의 단어장 페이지로 가서 저장했던 단어를 학습하시겠습니까?',
        style: TextStyle(color: AppColors.scaffoldBackground),
      ),
    );
  }

  static Future<bool> errorNoEnrolledEmail() async {
    return selectionDialog(
      title: const Text(
        '종각 앱에서 이메일을 작성하는데 실패하였습니다.',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent),
      ),
      connent: const Text(
        '핸드폰에 이메일 등록이 되어 있지 않으면 종각 앱에서 이메일을 작성하는데 어려움이 있습니다.\n별도의 이메일 앱에서 문의 해주시면 감사하겠습니다.\n\n이메일 visionwill3322@gmail.com을 복사하시겠습니까?',
        style: TextStyle(color: AppColors.scaffoldBackground),
      ),
    );
  }

  static Future<bool> noSelectionDialog(
      {Widget? title, Widget? connent}) async {
    return jonggackDialog(
      title: title,
      connent: connent,
    );
  }

  static Future<bool> selectionDialog({Widget? title, Widget? connent}) async {
    return jonggackDialog(
      title: title,
      connent: connent,
      action: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Card(
            shape: const CircleBorder(),
            child: InkWell(
              onTap: () async {
                return Get.back(result: true);
              },
              child: Padding(
                padding: EdgeInsets.all(Responsive.width15),
                child: Text(
                  '네!',
                  style: TextStyle(
                    // fontSize: Responsive.height14,
                    fontWeight: FontWeight.w600,
                    color: Colors.cyan.shade600,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: Responsive.height10),
          Card(
            shape: const CircleBorder(),
            child: InkWell(
              onTap: () async {
                return Get.back(result: false);
              },
              child: Padding(
                padding: EdgeInsets.all(Responsive.width15),
                child: Text(
                  '아뇨!',
                  style: TextStyle(
                    // fontSize: Responsive.height14,
                    fontWeight: FontWeight.w600,
                    color: Colors.cyan.shade600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Future<bool> beforeExitTestPageDialog() async {
    return selectionDialog(
      title: const Text('테스트를 그만두시겠습니까?'),
      connent: const Text(
        '테스트 중간에 나가면 점수가 기록되지 않습니다. 그래도 나가시겠습니까?',
        style: TextStyle(color: AppColors.scaffoldBackground),
      ),
    );
  }

  static Future<bool> askStartToRemainQuestionsDialog() async {
    return selectionDialog(
      title: const Text('과거의 테스트에서 틀린 문제들이 있습니다.'),
      connent: const Text(
        '틀린 문제만으로 다시 테스트를 보시겠습니까?',
        style: TextStyle(color: AppColors.scaffoldBackground),
      ),
    );
  }

  static Future<bool> askBeforeDeleteDatasDialog(String category,
      {message = AppConstantMsg.initDataAlertMsg}) async {
    return selectionDialog(
      title: Text(
        '$category 초기화 하시겠습니까?',
        style: const TextStyle(
          color: AppColors.scaffoldBackground,
          fontWeight: FontWeight.bold,
        ),
      ),
      connent: Text(
        message,
        style: const TextStyle(
          color: AppColors.scaffoldBackground,
        ),
      ),
    );
  }

  static Future<bool> confirmToSubmitGrammarTest(String remainQuestions) async {
    bool result = await Get.dialog(
      AlertDialog(
        shape: Border.all(),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RichText(
              text: TextSpan(
                text: '',
                children: [
                  TextSpan(
                    text: remainQuestions,
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: Responsive.width18,
                    ),
                  ),
                  const TextSpan(
                    text: '번이 남아 있습니다.\n\n',
                  ),
                  const TextSpan(
                    text: '그래도 제출 하시겠습니까?',
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Card(
                  shape: const CircleBorder(),
                  child: InkWell(
                    onTap: () async {
                      return Get.back(result: true);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(Responsive.width15),
                      child: Text(
                        '네!',
                        style: TextStyle(
                          // fontSize: Responsive.height14,
                          fontWeight: FontWeight.w600,
                          color: Colors.cyan.shade600,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: Responsive.height10),
                Card(
                  shape: const CircleBorder(),
                  child: InkWell(
                    onTap: () async {
                      return Get.back(result: false);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(Responsive.width15),
                      child: Text(
                        '아뇨!',
                        style: TextStyle(
                          // fontSize: Responsive.height14,
                          fontWeight: FontWeight.w600,
                          color: Colors.cyan.shade600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: Responsive.height10),
          ],
        ),
      ),
    );

    return result;
  }

  // static Future<bool> alertPreviousTestRequired() async {
  //   Get.dialog(AlertDialog(
  //     shape: Border.all(),
  //     content: Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         SizedBox(height: Responsive.height10),
  //         RichText(
  //           text: TextSpan(
  //             text: '다음 단계로 넘어가기 위해서 해당 챕터의\n퀴즈에서',
  //             children: [
  //               TextSpan(
  //                 text: ' 100점',
  //                 style: TextStyle(
  //                   color: Colors.redAccent,
  //                   fontSize: Responsive.width18,
  //                 ),
  //               ),
  //               const TextSpan(
  //                 text: '을 맞으셔야 합니다!',
  //               )
  //             ],
  //             style: TextStyle(
  //               color: Colors.black,
  //               fontSize: Responsive.width16,
  //               fontWeight: FontWeight.w500,
  //             ),
  //           ),
  //         ),
  //         SizedBox(height: Responsive.height20),
  //         const JonggackAvator(),
  //         SizedBox(height: Responsive.height20),
  //       ],
  //     ),
  //   ));
  //   return true;
  // }

  static Future<void> appealDownLoadThePaidVersion() async {
    Get.dialog(AlertDialog(
      shape: Border.all(),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RichText(
            text: TextSpan(
              text: 'JLPT N1을 더 학습하기 위해서는',
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

  static Future<bool> jonggackDialog(
      {Widget? title, Widget? connent, Widget? action}) async {
    bool result = await Get.dialog(
      barrierDismissible: false,
      AlertDialog(
        shape: Border.all(),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null) ...[
              title,
              SizedBox(height: Responsive.height20),
            ],
            if (connent != null) ...[
              connent,
              SizedBox(height: Responsive.height20),
            ],
            const Align(alignment: Alignment.center, child: JonggackAvator()),
            if (action != null) ...[
              SizedBox(height: Responsive.height20),
              action,
              SizedBox(height: Responsive.height10),
            ],
          ],
        ),
      ),
    );

    return result;
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
