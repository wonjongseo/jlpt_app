import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:japanese_voca/new_app/models/new_japanese.dart';
import 'package:japanese_voca/new_app/new_study/components/search_widget.dart';
import 'package:japanese_voca/new_app/new_study/new_study_screen.dart';
import 'package:japanese_voca/new_app/new_study_category/new_study_word_list_screen.dart';

class NewStudyCategoryScreen extends StatefulWidget {
  const NewStudyCategoryScreen({super.key, required this.level});

  final int level;

  @override
  State<NewStudyCategoryScreen> createState() => _NewStudyCategoryScreenState();
}

class _NewStudyCategoryScreenState extends State<NewStudyCategoryScreen> {
  late TextEditingController textEditingController;
  late PageController pageController;
  List<String> categories = [
    'All Japaneses',
    'All Grammars',
    'All Kangis',
  ];

  int selectedCategoryIndex = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    textEditingController = TextEditingController();
    pageController = PageController(initialPage: selectedCategoryIndex);
  }

  onPageChanged(int newPage) {
    selectedCategoryIndex = newPage;
    setState(() {});
  }

  @override
  void dispose() {
    textEditingController.dispose();
    pageController.dispose();
    super.dispose();
  }

  List<Widget> bodys = [
    const Column(
      children: [
        Card(
          child: Text('Chat 1'),
        ),
      ],
    ),
    const Center(child: Text('Grammar')),
    const Center(child: Text('Kangi')),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'JLPT N${widget.level}',
          style: const TextStyle(fontWeight: FontWeight.w900),
        ),
        backgroundColor: Colors.grey.shade200,
      ),
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                NewSearchWidget(
                  textEditingController: textEditingController,
                  onChanged: (String v) {},
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: List.generate(
                      categories.length,
                      (index) => TextButton(
                        onPressed: () {
                          pageController.animateToPage(index,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.ease);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: selectedCategoryIndex == index
                                ? Border(
                                    bottom: BorderSide(
                                      width: 3,
                                      color: Colors.cyan.shade700,
                                    ),
                                  )
                                : null,
                          ),
                          child: Text(
                            categories[index],
                            style: TextStyle(
                              color: selectedCategoryIndex == index
                                  ? Colors.black
                                  : Colors.grey.shade700,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Flexible(
                  child: PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: bodys.length,
                    controller: pageController,
                    onPageChanged: onPageChanged,
                    itemBuilder: (context, index) {
                      // return bodys[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: SingleChildScrollView(
                          child: Column(
                            children: List.generate(
                              30,
                              (index) =>
                                  NewChapterCard(chapterNumber: index + 1),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class NewChapterCard extends StatelessWidget {
  int? chapterNumber;
  List<NewJapanese>? newJapaneses;
  int? index;
  NewChapterCard({
    Key? key,
    this.chapterNumber,
    this.newJapaneses,
    this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: InkWell(
        onTap: () {
          if (newJapaneses == null) {
            Get.to(() => NewStudyWordListScreen(chapterNumber: chapterNumber!));
          } else {
            Get.to(() =>
                NewStudyScreen(newJapaneses: newJapaneses!, index: index!));
          }
        },
        child: Card(
          color: Colors.white,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (newJapaneses == null)
                  RichText(
                      text: TextSpan(
                    text: 'Chapter $chapterNumber  ',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    children: const [
                      TextSpan(
                        text: ' (0 /30)',
                        style: TextStyle(color: Colors.grey, fontSize: 13),
                      ),
                    ],
                  ))
                else
                  Text(
                    newJapaneses![index!].word,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                const Icon(
                  Icons.arrow_forward_ios_sharp,
                  size: 13,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
