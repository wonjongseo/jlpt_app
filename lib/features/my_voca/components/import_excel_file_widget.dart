import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/custom_snack_bar.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/features/my_voca/components/custom_button.dart';
import 'package:japanese_voca/features/my_voca/services/my_voca_controller.dart';
import 'package:japanese_voca/user/controller/user_controller.dart';

class ImportExcelFileWidget extends StatelessWidget {
  const ImportExcelFileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    MyVocaController controller = Get.find<MyVocaController>();
    UserController userController = Get.find<UserController>();
    return Padding(
      padding: EdgeInsets.all(Responsive.width16 / 2),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: Responsive.height16 / 2),
            child: Text(
              "아래의 형식에 맞는 엑셀 파일을 불러와주세요.",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Responsive.width10 * 1.8,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Responsive.width16 / 2),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(Responsive.width16 / 2),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.mainColor),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("1. 확장자는 .xlsx로 지정해주세요."),
                      SizedBox(height: Responsive.height16 / 4),
                      const Text("2. A(첫번쨰) 열에는 일본어를 입력해주세요."),
                      SizedBox(height: Responsive.height16 / 4),
                      const Text("3. B(두번쨰) 열에는 읽는 법를 입력해주세요."),
                      SizedBox(height: Responsive.height16 / 4),
                      const Text("4. C(세번쨰) 열에는 의미를 입력해주세요."),
                      SizedBox(height: Responsive.height16 / 4),
                      const Text("5. 빈 행이 없도록 입력해주세요."),
                    ],
                  ),
                ),
                SizedBox(height: Responsive.height16),
                CustomButton(
                  label: "엑셀 파일 불러오기",
                  onTap: () async {
                    // Get.offAllNamed(HOME_PATH);

                    int savedWordNumber = await controller.postExcelData();
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
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
