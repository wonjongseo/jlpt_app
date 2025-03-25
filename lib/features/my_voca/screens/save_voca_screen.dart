import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/admob/banner_ad/global_banner_admob.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/enums.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/config/theme.dart';
import 'package:japanese_voca/features/my_voca/components/custom_button.dart';
import 'package:japanese_voca/features/my_voca/components/custom_text_form.dart';
import 'package:japanese_voca/features/my_voca/components/import_excel_file_widget.dart';
import 'package:japanese_voca/features/my_voca/services/my_voca_controller.dart';
import 'package:japanese_voca/model/example.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/user/controller/user_controller.dart';

TextStyle accentTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  color: AppColors.mainColor,
  fontSize: Responsive.width16,
);

class SaveWordScreen extends StatefulWidget {
  const SaveWordScreen({super.key});

  @override
  State<SaveWordScreen> createState() => _SaveWordScreenState();
}

class _SaveWordScreenState extends State<SaveWordScreen> {
  MyVocaController controller = Get.find<MyVocaController>();
  UserController userController = Get.find<UserController>();
  final wordFormKey = GlobalKey<FormState>();
  final exampleFormKey = GlobalKey<FormState>();

  late TextEditingController japaneseController;
  late TextEditingController yomikataController;
  late TextEditingController meanController;
  late TextEditingController exampleController;

  late FocusNode japaneseFocusNode;
  late FocusNode yomikataFocusNode;
  late FocusNode meanFocusNode;
  // late FocusNode exampleFocusNode;

  List<Example>? examples;
  late TextEditingController exampleWordController;
  late TextEditingController exampleMeanController;

  late FocusNode exampleWordFocusNode;
  late FocusNode exampleMeanFocusNode;

  TextInputEnum currentFocus = TextInputEnum.JAPANESE;

  int pageIndex = 0;
  List<String> pageLabel = ["직접 입력", "엑셀 불러오기"];
  @override
  void initState() {
    super.initState();

    japaneseController = TextEditingController();
    yomikataController = TextEditingController();
    meanController = TextEditingController();
    exampleController = TextEditingController();

    japaneseFocusNode = FocusNode();
    yomikataFocusNode = FocusNode();
    meanFocusNode = FocusNode();
    // exampleFocusNode = FocusNode();

    japaneseFocusNode.addListener(() => _onFocusChange(TextInputEnum.JAPANESE));
    yomikataFocusNode.addListener(() => _onFocusChange(TextInputEnum.YOMIKATA));
    meanFocusNode.addListener(() => _onFocusChange(TextInputEnum.MEAN));
    // exampleFocusNode.addListener(() => _onFocusChange(TextInputEnum.EXAMPLE));
  }

  void _onFocusChange(TextInputEnum currentFocus) {
    setState(() {
      this.currentFocus = currentFocus;
    });
  }

  @override
  void dispose() {
    japaneseController.dispose();
    yomikataController.dispose();
    meanController.dispose();
    exampleController.dispose();

    japaneseFocusNode.dispose();
    yomikataFocusNode.dispose();
    meanFocusNode.dispose();
    // exampleFocusNode.dispose();

    disposeExampleContAndFocusNode();
    super.dispose();
  }

  void initExampleContAndFocusNode() {
    setState(() {
      examples = [];
      exampleWordController = TextEditingController();
      exampleMeanController = TextEditingController();

      exampleWordFocusNode = FocusNode();
      exampleMeanFocusNode = FocusNode();

      exampleWordFocusNode
          .addListener(() => _onFocusChange(TextInputEnum.EXAMPLE_JAPANESE));
      exampleMeanFocusNode
          .addListener(() => _onFocusChange(TextInputEnum.EXAMPLE_MEAN));
      exampleWordFocusNode.requestFocus();
    });
  }

  void disposeExampleContAndFocusNode() {
    if (examples != null) {
      examples = null;
      exampleWordController.dispose();
      exampleMeanController.dispose();
      exampleWordFocusNode.dispose();
      exampleMeanFocusNode.dispose();
    }
  }

  String? customValidator(
      {String? value, required TextInputEnum textInputEnum}) {
    switch (textInputEnum) {
      case TextInputEnum.JAPANESE:
        if (value == null || value.isEmpty) {
          japaneseFocusNode.requestFocus();
          return '${textInputEnum.name}을 입력해주세요.';
        }
        return null;
      // return '일본어';
      case TextInputEnum.YOMIKATA:
        if (value == null || value.isEmpty) {
          yomikataFocusNode.requestFocus();
          return '${textInputEnum.name}을 입력해주세요.';
        }
        return null;

      case TextInputEnum.MEAN:
        if (value == null || value.isEmpty) {
          meanFocusNode.requestFocus();
          return '${textInputEnum.name}을 입력해주세요.';
        }
        return null;

      case TextInputEnum.EXAMPLE_MEAN:
        if (value == null || value.isEmpty) {
          exampleMeanFocusNode.requestFocus();
          return '${textInputEnum.name}을 입력해주세요.';
        }
        return null;
      case TextInputEnum.EXAMPLE_JAPANESE:
        if (value == null || value.isEmpty) {
          exampleWordFocusNode.requestFocus();
          return '${textInputEnum.name}을 입력해주세요.';
        }
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const GlobalBannerAdmob(),
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        centerTitle: true,
        title: Text(
          "나만의 단어장 2 - 단어 저장",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Responsive.height10 * 1.8,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Responsive.width16 / 2),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  pageLabel.length,
                  (index) => InkWell(
                    onTap: () {
                      pageIndex = index;
                      setState(() {});
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2 -
                          Responsive.width10 * 5,
                      decoration: BoxDecoration(
                          color: pageIndex == index
                              ? AppColors.mainColor
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(5)),
                      padding: EdgeInsets.symmetric(
                        vertical: Responsive.height16 / 2,
                        horizontal: Responsive.width16,
                      ),
                      child: Center(
                          child: Text(
                        pageLabel[index],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                    ),
                  ),
                ),
              ),
              if (pageIndex == 0)
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(Responsive.width16 / 2),
                        child: Form(
                          key: wordFormKey,
                          child: Column(
                            children: [
                              WordTextForms(),
                              Padding(
                                padding: EdgeInsets.all(Responsive.width16 / 2),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '예제',
                                          style: accentTextStyle,
                                        ),
                                        if (examples == null)
                                          InkWell(
                                            onTap: initExampleContAndFocusNode,
                                            // icon: const Icon(Icons.add),
                                            child: Text(
                                              '펼치기',
                                              style: TextStyle(
                                                color: AppColors.mainBordColor,
                                                fontSize: Responsive.height14,
                                              ),
                                            ),
                                          )
                                        else
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                disposeExampleContAndFocusNode();
                                              });
                                            },
                                            child: Text(
                                              '접기',
                                              style: TextStyle(
                                                color: AppColors.mainBordColor,
                                                fontSize: Responsive.height14,
                                              ),
                                            ),
                                          )
                                      ],
                                    ),
                                    if (examples != null)
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          ExampleTextForms(),
                                          SingleChildScrollView(
                                            scrollDirection: Axis.vertical,
                                            child: Column(
                                              children: List.generate(
                                                examples!.length,
                                                (index) {
                                                  return Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding: EdgeInsets.only(
                                                            left: Responsive
                                                                    .width16 /
                                                                2),
                                                        child: Text(
                                                          "${index + 1}. ${examples![index].word}",
                                                          style:
                                                              const TextStyle(
                                                            fontFamily: AppFonts
                                                                .japaneseFont,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          examples!
                                                              .removeAt(index);
                                                          setState(() {});
                                                        },
                                                        child: Text(
                                                          "삭제",
                                                          style: TextStyle(
                                                            color: Colors.red,
                                                            fontSize: Responsive
                                                                .height14,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    SizedBox(height: Responsive.height20),
                                    CustomButton(
                                      onTap: addWord,
                                      label: '단어 저장',
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              else
                const ImportExcelFileWidget()
            ],
          ),
        ),
      ),
    );
  }

  Widget ExampleTextForms() {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: Responsive.height10,
          horizontal: Responsive.width15,
        ),
        child: Form(
          key: exampleFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomTextForm(
                textInputEnum: TextInputEnum.EXAMPLE_JAPANESE,
                textController: exampleWordController,
                focusNode: exampleWordFocusNode,
                isFocus: TextInputEnum.EXAMPLE_JAPANESE == currentFocus,
                validator: (value) {
                  return customValidator(
                    value: value,
                    textInputEnum: TextInputEnum.EXAMPLE_JAPANESE,
                  );
                },
              ),
              CustomTextForm(
                textInputEnum: TextInputEnum.EXAMPLE_MEAN,
                textController: exampleMeanController,
                focusNode: exampleMeanFocusNode,
                isFocus: TextInputEnum.EXAMPLE_MEAN == currentFocus,
                validator: (value) {
                  return customValidator(
                    value: value,
                    textInputEnum: TextInputEnum.EXAMPLE_MEAN,
                  );
                },
              ),
              IconButton(
                onPressed: appendExample,
                icon: Text(
                  "예제 추가",
                  style: TextStyle(
                    color: AppColors.mainBordColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget WordTextForms() {
    return Card(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: Responsive.height10,
          horizontal: Responsive.width15,
        ),
        child: Column(
          children: [
            CustomTextForm(
              textInputEnum: TextInputEnum.JAPANESE,
              textController: japaneseController,
              focusNode: japaneseFocusNode,
              isFocus: TextInputEnum.JAPANESE == currentFocus,
              validator: (value) {
                return customValidator(
                  value: value,
                  textInputEnum: TextInputEnum.JAPANESE,
                );
              },
            ),
            CustomTextForm(
              textInputEnum: TextInputEnum.YOMIKATA,
              textController: yomikataController,
              focusNode: yomikataFocusNode,
              isFocus: TextInputEnum.YOMIKATA == currentFocus,
              validator: (value) {
                return customValidator(
                  value: value,
                  textInputEnum: TextInputEnum.YOMIKATA,
                );
              },
            ),
            CustomTextForm(
              textInputEnum: TextInputEnum.MEAN,
              textController: meanController,
              focusNode: meanFocusNode,
              isFocus: TextInputEnum.MEAN == currentFocus,
              validator: (value) {
                return customValidator(
                  value: value,
                  textInputEnum: TextInputEnum.MEAN,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void addWord() {
    if (wordFormKey.currentState!.validate()) {
      String japanese = japaneseController.text;
      String yomikata = yomikataController.text;
      String mean = meanController.text;

      controller.manualSaveMyWord(MyWord(
        word: japanese,
        mean: mean,
        yomikata: yomikata,
        examples: examples,
        isManuelSave: true,
      ));

      japaneseController.clear();
      yomikataController.clear();
      meanController.clear();

      japaneseFocusNode.requestFocus();

      setState(() {
        disposeExampleContAndFocusNode();
      });
    }
  }

  void appendExample() {
    if (exampleFormKey.currentState!.validate()) {
      String eJapanese = exampleWordController.text;
      String eMean = exampleMeanController.text;

      Example example = Example(word: eJapanese, mean: eMean);

      examples!.add(example);

      exampleWordController.clear();
      exampleMeanController.clear();

      exampleWordFocusNode.requestFocus();
      setState(() {});
    }
  }
}
