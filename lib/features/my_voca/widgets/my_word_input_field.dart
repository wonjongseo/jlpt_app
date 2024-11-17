import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/admob/controller/ad_controller.dart';
import 'package:japanese_voca/common/widget/custom_snack_bar.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/features/my_voca/services/my_voca_controller.dart';
import 'package:japanese_voca/features/my_voca/widgets/upload_excel_infomation.dart';
import 'package:japanese_voca/user/controller/user_controller.dart';

enum TextFormEnum { JAPANESE, YOMIKATA, MEAN }

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
  @override
  void initState() {
    super.initState();
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
                            textFormEnum: TextFormEnum.JAPANESE,
                            textEditingController: controller.wordController,
                            focusNode: controller.wordFocusNode,
                            onFieldSubmitted: controller.manualSaveMyWord,
                          ),
                          CustomInputField(
                            textFormEnum: TextFormEnum.YOMIKATA,
                            textEditingController:
                                controller.yomikataController,
                            focusNode: controller.yomikataFocusNode,
                            onFieldSubmitted: controller.manualSaveMyWord,
                          ),
                          CustomInputField(
                            textFormEnum: TextFormEnum.MEAN,
                            textEditingController: controller.meanController,
                            focusNode: controller.meanFocusNode,
                            onFieldSubmitted: controller.manualSaveMyWord,
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
                          controller.manualSaveMyWord();
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
                bottom: BorderSide(width: 2, color: AppColors.mainBordColor),
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
  });

  final TextEditingController textEditingController;
  final FocusNode focusNode;
  final Function onFieldSubmitted;
  final TextFormEnum textFormEnum;

  OutlineInputBorder textFieldBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.mainColor,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(Responsive.height10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // MyVocaController controller = Get.find<MyVocaController>();
    return Container(
      margin: EdgeInsets.symmetric(vertical: Responsive.height8),
      padding: EdgeInsets.only(bottom: Responsive.height8),
      height: Responsive.height10 * 6,
      child: TextFormField(
        autofocus: textFormEnum == TextFormEnum.JAPANESE,
        style: const TextStyle(color: AppColors.scaffoldBackground),
        focusNode: focusNode,
        onFieldSubmitted: (value) => onFieldSubmitted(),
        controller: textEditingController,
        decoration: InputDecoration(
          errorBorder: textFieldBorder(),
          focusedBorder: textFieldBorder(),
          focusedErrorBorder: textFieldBorder(),
          disabledBorder: textFieldBorder(),
          enabledBorder: textFieldBorder(),
          border: textFieldBorder(),
          label: Text(
            textFormEnum.id,
            style: TextStyle(
              fontSize: Responsive.height10 * 1.4,
              color: AppColors.scaffoldBackground,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

/**
    ,
 */