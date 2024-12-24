import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/admob/controller/ad_controller.dart';
import 'package:japanese_voca/common/widget/custom_snack_bar.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/features/my_voca/services/my_voca_controller.dart';
import 'package:japanese_voca/features/my_voca/widgets/upload_excel_infomation.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/repository/my_word_repository.dart';
import 'package:japanese_voca/user/controller/user_controller.dart';

enum TextFormEnum { JAPANESE, YOMIKATA, MEAN, EXAMPLES }

// ignore: constant_identifier_names

extension TextFormEnumExtension on TextFormEnum {
  String get id {
    switch (this) {
      case TextFormEnum.JAPANESE:
        return '일본어';
      case TextFormEnum.YOMIKATA:
        return '읽는 법';
      case TextFormEnum.MEAN:
        return '의미';
      case TextFormEnum.EXAMPLES:
        return '예시';
    }
  }
}

class MyWordInputField extends StatefulWidget {
  const MyWordInputField({super.key});

  @override
  State<MyWordInputField> createState() => _MyWordInputFieldState();
}

class _MyWordInputFieldState extends State<MyWordInputField> {
  bool isManual = true;
  AdController adController = Get.find<AdController>();
  MyVocaController controller = Get.find<MyVocaController>();
  UserController userController = Get.find<UserController>();

  late TextEditingController wordController;
  late TextEditingController yomikataController;
  late TextEditingController meanController;
  late TextEditingController exampleController;

  late FocusNode wordFocusNode;
  late FocusNode yomikataFocusNode;
  late FocusNode meanFocusNode;
  late FocusNode exampleFocusNode;

  TextFormEnum currentFocus = TextFormEnum.JAPANESE;

  @override
  void initState() {
    super.initState();
    wordController = TextEditingController();
    yomikataController = TextEditingController();
    meanController = TextEditingController();
    exampleController = TextEditingController();

    wordFocusNode = FocusNode();
    wordFocusNode.addListener(() => changeFocusNode(TextFormEnum.JAPANESE));

    yomikataFocusNode = FocusNode();
    yomikataFocusNode.addListener(() => changeFocusNode(TextFormEnum.YOMIKATA));

    meanFocusNode = FocusNode();
    meanController.addListener(() => changeFocusNode(TextFormEnum.MEAN));
    exampleFocusNode = FocusNode();
  }

  void changeFocusNode(TextFormEnum currentFocusNode) {
    this.currentFocus = currentFocusNode;

    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    wordController.dispose();
    yomikataController.dispose();
    meanController.dispose();

    wordFocusNode.dispose();
    yomikataFocusNode.dispose();
    meanFocusNode.dispose();
  }

  // 직접 입력해서 일본어 단어 저장
  void manualSaveMyWord() async {
    String word = wordController.text;
    String yomikata = yomikataController.text;
    String mean = meanController.text;

    if (word.isEmpty) {
      wordFocusNode.requestFocus();
      return;
    }

    if (yomikata.isEmpty) {
      yomikataFocusNode.requestFocus();
      return;
    }

    if (mean.isEmpty) {
      meanFocusNode.requestFocus();
      return;
    }

    controller.manualSaveMyWord(MyWord(
      // 종각앱 내부의 단어와 겹치지 않기 위해서
      // _M_A_N_U_A_L를 붙여서 저장
      // word: '${word}_M_A_N_U_A_L',
      word: '${word}',
      mean: mean,
      yomikata: yomikata,
      isManuelSave: true,
    ));

    wordController.clear();
    meanController.clear();
    yomikataController.clear();
    wordFocusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                isManual = true;
                setState(() {});
              },
              child: DDDD(text: '직접 입력', isActive: isManual),
            ),
            InkWell(
              onTap: () {
                isManual = false;
                setState(() {});
              },
              child: DDDD(text: '엑셀 데이터 저장', isActive: !isManual),
            ),
          ],
        ),
        SizedBox(height: Responsive.height15),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: isManual
              ? Column(
                  children: [
                    Form(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomInputField(
                            color: currentFocus == TextFormEnum.JAPANESE
                                ? AppColors.mainBordColor
                                : null,
                            textFormEnum: TextFormEnum.JAPANESE,
                            textEditingController: wordController,
                            focusNode: wordFocusNode,
                            onFieldSubmitted: manualSaveMyWord,
                          ),
                          CustomInputField(
                            color: currentFocus == TextFormEnum.YOMIKATA
                                ? AppColors.mainBordColor
                                : null,
                            textFormEnum: TextFormEnum.YOMIKATA,
                            textEditingController: yomikataController,
                            focusNode: yomikataFocusNode,
                            onFieldSubmitted: manualSaveMyWord,
                          ),
                          CustomInputField(
                            color: currentFocus == TextFormEnum.MEAN
                                ? AppColors.mainBordColor
                                : null,
                            textFormEnum: TextFormEnum.MEAN,
                            textEditingController: meanController,
                            focusNode: meanFocusNode,
                            onFieldSubmitted: manualSaveMyWord,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: Responsive.height10),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(Responsive.height10),
                      child: OutlinedButton(
                        onPressed: () {
                          manualSaveMyWord();
                        },
                        child: Text(
                          '저장',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Responsive.height10 * 1.6,
                            color: AppColors.mainBordColor,
                          ),
                        ),
                      ),
                    )
                  ],
                )
              : Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'EXCEL 데이터 형식',
                          style: TextStyle(
                            color: AppColors.scaffoldBackground,
                            fontSize: Responsive.height10 * 1.8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: Responsive.height16 / 2),
                          child: const UploadExcelInfomation(),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(Responsive.height10),
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () async {
                          // Get.offAllNamed(HOME_PATH);

                          int savedWordNumber =
                              await controller.postExcelData();
                          if (savedWordNumber != 0) {
                            Get.back();
                            Get.back();
                            showSnackBar(
                              '$savedWordNumber개의 단어가 저장되었습니다.\n($savedWordNumber 단어가 이미 저장되어 있습니다.)',
                              duration: const Duration(seconds: 4),
                            );
                            userController.updateMyWordSavedCount(
                              true,
                              isYokumatiageruWord: false,
                              count: savedWordNumber,
                            );
                            return;
                          }
                        },
                        child: Text(
                          '저장',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.mainBordColor,
                            fontSize: Responsive.height10 * 1.6,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
        ),
      ],
    );
  }
}

class DDDD extends StatelessWidget {
  const DDDD({
    super.key,
    required this.isActive,
    required this.text,
  });

  final bool isActive;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: isActive
          ? BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 3, color: AppColors.mainBordColor),
              ),
            )
          : null,
      child: Text(
        text,
        style: isActive
            ? TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Responsive.height16,
                color: AppColors.mainBordColor,
              )
            : TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: Responsive.height14,
              ),
      ),
    );
  }
}

class CustomInputField extends StatelessWidget {
  const CustomInputField({
    super.key,
    required this.textEditingController,
    required this.focusNode,
    required this.onFieldSubmitted,
    required this.textFormEnum,
    required this.color,
  });

  final Color? color;
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final Function onFieldSubmitted;
  final TextFormEnum textFormEnum;

  OutlineInputBorder textFieldBorder() {
    return OutlineInputBorder(
      gapPadding: 0,
      borderSide: BorderSide(
        width: 3,
        color: AppColors.mainColor,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(Responsive.height10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    FontWeight? fontWeight = color != null ? FontWeight.bold : null;
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: Responsive.height8 / 2, horizontal: Responsive.width8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            textFormEnum.id,
            style: TextStyle(
              color: color,
              fontWeight: fontWeight,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Responsive.width8 / 4,
                vertical: Responsive.height8 / 2),
            child: Center(
              child: TextFormField(
                style: TextStyle(fontSize: Responsive.width15),
                autofocus: textFormEnum == TextFormEnum.JAPANESE,
                focusNode: focusNode,
                onFieldSubmitted: (value) => onFieldSubmitted(),
                controller: textEditingController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: Responsive.height16,
                  ),
                  errorBorder: textFieldBorder(),
                  focusedBorder: textFieldBorder(),
                  focusedErrorBorder: textFieldBorder(),
                  disabledBorder: textFieldBorder(),
                  // enabledBorder: textFieldBorder(),
                  border: textFieldBorder(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/**
    ,
 */
