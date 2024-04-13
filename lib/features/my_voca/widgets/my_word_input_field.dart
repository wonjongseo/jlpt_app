import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/admob/controller/ad_controller.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/features/home/screens/home_screen.dart';
import 'package:japanese_voca/features/my_voca/services/my_voca_controller.dart';
import 'package:japanese_voca/features/my_voca/widgets/upload_excel_infomation.dart';

class MyWordInputField extends StatefulWidget {
  const MyWordInputField({super.key});

  @override
  State<MyWordInputField> createState() => _MyWordInputFieldState();
}

class _MyWordInputFieldState extends State<MyWordInputField> {
  bool isManual = true;
  AdController adController = Get.find<AdController>();
  MyVocaController controller = Get.find<MyVocaController>();
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
              child: DDDD(text: '데이터 직접 입력', isActive: isManual),
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
                          TextFormField(
                            style: const TextStyle(
                                color: AppColors.scaffoldBackground),
                            autofocus: true,
                            focusNode: controller.wordFocusNode,
                            onFieldSubmitted: (value) =>
                                controller.manualSaveMyWord(),
                            controller: controller.wordController,
                            decoration: InputDecoration(
                              label: Text(
                                '일본어',
                                style: TextStyle(
                                  fontSize: Responsive.height10 * 1.4,
                                  color: AppColors.scaffoldBackground,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          TextFormField(
                            style: const TextStyle(
                                color: AppColors.scaffoldBackground),
                            focusNode: controller.yomikataFocusNode,
                            onFieldSubmitted: (value) =>
                                controller.manualSaveMyWord(),
                            controller: controller.yomikataController,
                            decoration: InputDecoration(
                              label: Text(
                                '읽는 법',
                                style: TextStyle(
                                  fontSize: Responsive.height10 * 1.4,
                                  color: AppColors.scaffoldBackground,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          TextFormField(
                            style: const TextStyle(
                                color: AppColors.scaffoldBackground),
                            focusNode: controller.meanFocusNode,
                            onFieldSubmitted: (value) =>
                                controller.manualSaveMyWord(),
                            controller: controller.meanController,
                            decoration: InputDecoration(
                              label: Text(
                                '의미',
                                style: TextStyle(
                                  fontSize: Responsive.height10 * 1.4,
                                  color: AppColors.scaffoldBackground,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
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
                          bool result2 = await askToWatchMovieAndGetHeart(
                            title: const Text('엑셀 단어 등록하기'),
                            content: const Text(
                              '광고를 시청하고 엑셀의 단어를 종각앱 저장하시겠습니까?',
                              style: TextStyle(
                                  color: AppColors.scaffoldBackground),
                            ),
                          );

                          if (result2) {
                            int savedWordNumber =
                                await controller.postExcelData();
                            if (savedWordNumber != 0) {
                              Get.offAll(const HomeScreen());
                            }
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
