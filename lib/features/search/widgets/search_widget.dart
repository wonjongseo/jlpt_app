import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/controller/tts_controller.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/features/search/widgets/searched_word_card.dart';
import 'package:japanese_voca/user/controller/user_controller.dart';

class NewSearchWidget extends StatelessWidget {
  const NewSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(TtsController());
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
