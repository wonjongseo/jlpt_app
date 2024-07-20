import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/features/search/widgets/searched_word_card.dart';
import 'package:japanese_voca/user/controller/user_controller.dart';
import 'package:japanese_voca/config/colors.dart';

class NewSearchWidget extends StatelessWidget {
  const NewSearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(builder: (userController) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Card(
                child: Form(
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller: userController.textEditingController,
                    onEditingComplete: () {
                      FocusScope.of(context).unfocus();
                      userController.sendQuery();
                    },
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      hintText: ' 단어 검색...',
                      hintStyle: TextStyle(
                        fontSize: Responsive.height14,
                      ),
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                right: 10,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    color: userController.isSearchReq
                        ? Colors.grey.shade300
                        : AppColors.mainBordColor,
                    child: InkWell(
                      onTap: () async {
                        if (userController.isSearchReq) return;
                        if (userController.textEditingController.text.isEmpty ||
                            userController.textEditingController.text == '') {
                          return;
                        }
                        await userController.sendQuery();
                      },
                      child: Padding(
                        padding: EdgeInsets.all(Responsive.height10 / 2),
                        child: Icon(
                          Icons.search,
                          size: Responsive.height30,
                          color: userController.isSearchReq
                              ? Colors.grey.shade100
                              : Colors.white70,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          if (userController.isSearchReq)
            Center(
              child: SizedBox(
                height: Responsive.height10 * 5,
                child: const CircularProgressIndicator.adaptive(),
              ),
            )
          else if (userController.searchedWords != null) ...[
            if (userController.searchedWords!.isEmpty) ...[
              SizedBox(height: Responsive.height10 / 2),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '"${userController.textEditingController.text}"를 찾을 수 없습니다.',
                  style: TextStyle(
                    color: AppColors.mainBordColor,
                    fontWeight: FontWeight.bold,
                    fontSize: Responsive.height14,
                  ),
                ),
              )
            ] else ...[
              SizedBox(height: Responsive.height10 / 2),
              Container(
                padding: EdgeInsets.all(Responsive.height16 / 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '검색 결과: ${userController.searchedWords!.length}',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: Responsive.height14,
                      ),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(
                          userController.searchedWords!.length,
                          (index) => SearchedWordCard(
                            searchedWords: userController.searchedWords!,
                            index: index,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ]
          ] else
            SizedBox(height: Responsive.height10 * 5)
        ],
      );
    });
  }
}
