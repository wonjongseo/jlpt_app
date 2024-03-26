import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/features/jlpt_study/widgets/word_card.dart';
import 'package:japanese_voca/model/word.dart';
import 'package:japanese_voca/user/controller/user_controller.dart';

class NewSearchWidget extends StatelessWidget {
  const NewSearchWidget({super.key});

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
                  child: SizedBox(
                    height: Responsive.height10 * 6,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      controller: userController.textEditingController,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        hintText: ' Looking for...',
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
              ),
              // Positioned.fill(
              //   right: 60,
              //   child: Align(
              //     alignment: Alignment.centerRight,
              //     child: GetBuilder<UserController>(builder: (userController) {
              //       return DropdownButton(
              //         value: userController.selectedDropDownItem,
              //         items: const [
              //           DropdownMenuItem(value: 'japanese', child: Text('일본어')),
              //           DropdownMenuItem(value: 'kangi', child: Text('한자')),
              //           DropdownMenuItem(value: 'grammar', child: Text('문법'))
              //         ],
              //         onChanged: (v) {
              //           userController.changeDropDownButtonItme(v);
              //         },
              //       );
              //     }),
              //   ),
              // ),
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
                        : Colors.cyan.shade700,
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
                  'Not found of "${userController.textEditingController.text}"',
                  style: TextStyle(
                    color: Colors.cyan.shade700,
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
                      ' Count of Result: ${userController.searchedWords!.length}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
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
                            searchedWord: userController.searchedWords![index],
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

class SearchedWordCard extends StatelessWidget {
  const SearchedWordCard({
    super.key,
    required this.searchedWord,
  });

  final Word searchedWord;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: Responsive.height16 / 2),
      child: InkWell(
        onTap: () => Get.to(
          () => DetailVocaScreen(body: WordCard(word: searchedWord)),
        ),
        child: Card(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Responsive.height10,
                vertical: Responsive.height16 / 4),
            child: Text(
              searchedWord.word,
              style: TextStyle(
                  fontSize: Responsive.height18, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}

class DetailVocaScreen extends StatelessWidget {
  const DetailVocaScreen({super.key, required this.body});
  final Widget body;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: body,
        ),
      ),
    );
  }
}
