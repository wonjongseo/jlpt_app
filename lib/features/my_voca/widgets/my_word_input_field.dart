import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/admob/controller/ad_controller.dart';
import 'package:japanese_voca/common/common.dart';
import 'package:japanese_voca/common/excel.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/features/my_voca/screens/my_voca_sceen.dart';
import 'package:japanese_voca/features/my_voca/services/my_voca_controller.dart';
import 'package:japanese_voca/features/my_voca/widgets/upload_excel_infomation.dart';

class MyWordInputField extends StatefulWidget {
  const MyWordInputField({
    super.key,
    required this.wordFocusNode,
    required this.wordController,
    required this.yomikataFocusNode,
    required this.yomikataController,
    required this.meanFocusNode,
    required this.meanController,
    required this.saveWord,
  });

  final Function() saveWord;
  final FocusNode wordFocusNode;
  final TextEditingController wordController;
  final FocusNode yomikataFocusNode;
  final TextEditingController yomikataController;
  final FocusNode meanFocusNode;
  final TextEditingController meanController;

  @override
  State<MyWordInputField> createState() => _MyWordInputFieldState();
}

class _MyWordInputFieldState extends State<MyWordInputField> {
  bool isManual = true;
  AdController adController = Get.find<AdController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Responsive.width16),
          child: Row(
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
        ),
        SizedBox(height: Responsive.height15),
        // if ()
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.width * 0.8,
          child: isManual
              ? Stack(
                  children: [
                    Form(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            style: const TextStyle(
                                color: AppColors.scaffoldBackground),
                            autofocus: true,
                            focusNode: widget.wordFocusNode,
                            onFieldSubmitted: (value) => widget.saveWord(),
                            controller: widget.wordController,
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
                          // SizedBox(height: Responsive.height10 / 2),
                          TextFormField(
                            style: const TextStyle(
                                color: AppColors.scaffoldBackground),
                            focusNode: widget.yomikataFocusNode,
                            onFieldSubmitted: (value) => widget.saveWord(),
                            controller: widget.yomikataController,
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
                          // SizedBox(height: Responsive.height10 / 2),
                          TextFormField(
                            style: const TextStyle(
                                color: AppColors.scaffoldBackground),
                            focusNode: widget.meanFocusNode,
                            onFieldSubmitted: (value) => widget.saveWord(),
                            controller: widget.meanController,
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
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: OutlinedButton(
                        onPressed: widget.saveWord,
                        child: Text(
                          '저장',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Responsive.height10 * 1.6),
                        ),
                      ),
                    )
                  ],
                )
              : Stack(
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
                    Positioned(
                      bottom: 0,
                      right: 0,
                      left: 0,
                      child: OutlinedButton(
                        onPressed: () async {
                          // Get.back(result: true);
                          bool result2 = await askToWatchMovieAndGetHeart(
                            title: const Text('엑셀 단어 등록하기'),
                            content: const Text(
                              '광고를 시청하고 엑셀의 단어를 JLPT종각에 저장하시겠습니까?',
                              style: TextStyle(
                                  color: AppColors.scaffoldBackground),
                            ),
                          );

                          if (result2) {
                            int savedWordNumber = await postExcelData();
                            if (savedWordNumber != 0) {
                              Get.offNamed(
                                MY_VOCA_PATH,
                                arguments: {MY_VOCA_TYPE: MyVocaEnum.MY_WORD},
                                preventDuplicates: false,
                              );
                              adController!.showRewardedInterstitialAd();
                            }
                          }
                        },
                        child: Text(
                          '저장',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Responsive.height10 * 1.6),
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
                bottom: BorderSide(width: 2, color: Colors.cyan.shade700),
              ),
            )
          : null,
      child: Text(
        text,
        style: isActive
            ? TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Responsive.height16,
                color: Colors.cyan.shade700,
              )
            : TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: Responsive.height14,
              ),
      ),
    );
  }
}
