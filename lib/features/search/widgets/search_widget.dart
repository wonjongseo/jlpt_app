import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/string.dart';
import 'package:japanese_voca/config/theme.dart';
import 'package:japanese_voca/features/search/widgets/searched_word_card.dart';
import 'package:japanese_voca/user/controller/user_controller.dart';
import 'package:japanese_voca/config/colors.dart';

List<String> list = ['일본어', '한자', '문법'];

class NewSearchWidget extends StatefulWidget {
  const NewSearchWidget({
    super.key,
  });

  @override
  State<NewSearchWidget> createState() => _NewSearchWidgetState();
}

class _NewSearchWidgetState extends State<NewSearchWidget> {
  String curValue = list[0];
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
                      if (userController.isSearchReq) return;

                      userController.sendQuery();
                    },
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily: AppFonts.japaneseFont,
                    ),
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      // hintText: ' 일본어/한자/문법 검색...',
                      hintText: AppString.searchHintText.tr,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        color: userController.isSearchReq
                            ? Colors.grey.shade300
                            : AppColors.mainBordColor,
                        child: InkWell(
                          onTap: () async {
                            if (userController.isSearchReq) return;

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
                    ],
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
          else if (userController.searchedWords != null &&
              userController.searchedKangis != null &&
              userController.searchedGrammar != null) ...[
            if (userController.searchedWords!.isEmpty &&
                userController.searchedKangis!.isEmpty &&
                userController.searchedGrammar!.isEmpty) ...[
              SizedBox(height: Responsive.height10 / 2),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  '"${userController.query}"를 찾을 수 없습니다.',
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              '${userController.query} ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Responsive.height14,
                                fontFamily: AppFonts.japaneseFont,
                              ),
                            ),
                            Text(
                              '의 검색 결과: ${userController.searchedWords!.length + userController.searchedKangis!.length + userController.searchedGrammar!.length}',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: Responsive.height14,
                                fontFamily: AppFonts.japaneseFont,
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: userController.clearQuery,
                          child: const Icon(
                            Icons.remove,
                            color: Colors.black54,
                          ),
                        )
                      ],
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ...List.generate(
                            userController.searchedWords!.length,
                            (index) => SearchedWordCard(
                              searchedWords: userController.searchedWords!,
                              index: index,
                            ),
                          ),
                          ...List.generate(
                            userController.searchedKangis!.length,
                            (index) => SearchedKangiCard(
                              searchedKangis: userController.searchedKangis!,
                              index: index,
                            ),
                          ),
                          ...List.generate(
                            userController.searchedGrammar!.length,
                            (index) => SearchedGrammarCard(
                              searchedGrammar: userController.searchedGrammar!,
                              index: index,
                            ),
                          ),
                        ],
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
