import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/screen/answer_controller.dart';
import 'package:pdfx/pdfx.dart';

const String JLPT_REAL_TEST_PAGE = '/test';

List<String> testNames = [
  '2019_7_n1_tester.pdf',
  '2019_12_n1_tester.pdf',
  '2020_12_n1_tester.pdf',
  '2021_7_n1_tester.pdf',
  '2022_12_n1_tester.pdf',
];

class JlptRealTestPage extends StatefulWidget {
  const JlptRealTestPage({Key? key, required this.fileName}) : super(key: key);
  final String fileName;
  @override
  _JlptRealTestPageState createState() => _JlptRealTestPageState();
}

class _JlptRealTestPageState extends State<JlptRealTestPage> {
  // ignore: prefer_typing_uninitialized_variables
  late final pdfController;
  late PageController pageController;
  late AnswerController answerController;

  String selectedTextName = '';
  static const int _initialPage = 0;
  int actualPageNumber = _initialPage, allPagesCount = 0;
  @override
  void initState() {
    print('iniT');
    super.initState();
    selectedTextName = widget.fileName;
    answerController = Get.put(AnswerController());
    pageController = PageController();

    pdfController = GetPlatform.isDesktop
        ? PdfController(
            document: PdfDocument.openAsset(selectedTextName),
          )
        : PdfControllerPinch(
            document: PdfDocument.openAsset('assets/$selectedTextName'),
            initialPage: _initialPage,
          );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.navigate_before),
              onPressed: () {
                pdfController.previousPage(
                  curve: Curves.ease,
                  duration: const Duration(milliseconds: 100),
                );
              },
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                '$actualPageNumber/$allPagesCount',
                style: const TextStyle(fontSize: 22),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.navigate_next),
              onPressed: () {
                pdfController.nextPage(
                  curve: Curves.ease,
                  duration: const Duration(milliseconds: 100),
                );
              },
            ),
          ],
        ),
        actions: <Widget>[
          FittedBox(
            child: DropdownButton(
              items: List<DropdownMenuItem<String>>.generate(
                testNames.length,
                (index) {
                  // testNames[index].split('_n1_tester.pdf')[0];
                  return DropdownMenuItem(
                    value: testNames[index],
                    child: Text(
                      testNames[index].split('_n1_tester.pdf')[0],
                    ),
                  );
                },
              ),
              value: selectedTextName,
              onChanged: (value) {
                setState(() {
                  selectedTextName = value!;
                });
                Get.to(
                  preventDuplicates: false,
                  () => JlptRealTestPage(
                    fileName: selectedTextName,
                  ),
                );
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              if (GetPlatform.isDesktop) {
                (pdfController as PdfController).jumpToPage(allPagesCount);
              } else {
                (pdfController as PdfControllerPinch)
                    .goToPage(pageNumber: allPagesCount);
              }
            },
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GetPlatform.isDesktop
                  ? PdfView(
                      documentLoader:
                          const Center(child: CircularProgressIndicator()),
                      pageLoader:
                          const Center(child: CircularProgressIndicator()),
                      controller: pdfController,
                      onDocumentLoaded: (document) {
                        setState(() {
                          allPagesCount = document.pagesCount;
                        });
                      },
                      onPageChanged: (page) {
                        setState(() {
                          actualPageNumber = page;
                        });
                      },
                    )
                  : PdfViewPinch(
                      documentLoader:
                          const Center(child: CircularProgressIndicator()),
                      pageLoader:
                          const Center(child: CircularProgressIndicator()),
                      controller: pdfController,
                      onDocumentLoaded: (document) {
                        setState(() {
                          allPagesCount = document.pagesCount;
                        });
                      },
                      onPageChanged: (page) {
                        setState(() {
                          actualPageNumber = page;
                        });
                      },
                    ),
            ),
            const Divider(thickness: 5),
            if (actualPageNumber == allPagesCount)
              SizedBox(
                height: 180,
                child: GridView.count(
                  scrollDirection: Axis.horizontal,
                  crossAxisCount: 3,
                  children: List.generate(
                    answerController.answerList.length,
                    (index) => Center(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              style: const TextStyle(color: Colors.black),
                              text: '${index + 1}番: ',
                            ),
                            TextSpan(
                              style: const TextStyle(color: Colors.red),
                              text:
                                  answerController.answerList[index].toString(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  height: 80,
                  child: PageView(
                    controller: pageController,
                    children: List.generate(answerController.answerList.length,
                        (index) {
                      return SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('${(index + 1).toString()}번'),
                            GetBuilder<AnswerController>(
                                builder: (innerContainer) {
                              return Row(children: [
                                if (index != 0)
                                  SizedBox(
                                    width: 30,
                                    child: IconButton(
                                        onPressed: () {
                                          // nextPage;
                                          pageController.animateToPage(
                                              pageController.page!.toInt() - 1,
                                              duration: const Duration(
                                                  milliseconds: 400),
                                              curve: Curves.easeIn);
                                        },
                                        icon: const Icon(Icons.arrow_back_ios)),
                                  ),
                                ...[
                                  Expanded(
                                    child: Stack(
                                      alignment: AlignmentDirectional.center,
                                      children: [
                                        Radio<String>(
                                          groupValue: innerContainer
                                              .answerList[index]
                                              .toString(),
                                          visualDensity: VisualDensity.compact,
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.padded,
                                          value: '1',
                                          onChanged: (String? value) {
                                            innerContainer.selectQuestion(
                                                index, 1);
                                          },
                                        ),
                                        const Text('1'),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Stack(
                                      alignment: AlignmentDirectional.center,
                                      children: [
                                        Radio<String>(
                                          groupValue: innerContainer
                                              .answerList[index]
                                              .toString(),
                                          visualDensity: VisualDensity.compact,
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.padded,
                                          value: '2',
                                          onChanged: (String? value) {
                                            innerContainer.selectQuestion(
                                                index, 2);
                                          },
                                        ),
                                        const Text('2'),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Stack(
                                      alignment: AlignmentDirectional.center,
                                      children: [
                                        Radio<String>(
                                          groupValue: innerContainer
                                              .answerList[index]
                                              .toString(),
                                          visualDensity: VisualDensity.compact,
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.padded,
                                          value: '3',
                                          onChanged: (String? value) {
                                            innerContainer.selectQuestion(
                                                index, 3);
                                          },
                                        ),
                                        const Text('3'),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Stack(
                                      alignment: AlignmentDirectional.center,
                                      children: [
                                        Radio<String>(
                                          groupValue: innerContainer
                                              .answerList[index]
                                              .toString(),
                                          visualDensity: VisualDensity.compact,
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.padded,
                                          value: '4',
                                          onChanged: (String? value) {
                                            innerContainer.selectQuestion(
                                                index, 4);
                                          },
                                        ),
                                        const Text('4'),
                                      ],
                                    ),
                                  ),
                                ],
                                if (index !=
                                    answerController.answerList.length - 1)
                                  SizedBox(
                                    width: 30,
                                    child: IconButton(
                                      onPressed: () {
                                        // nextPage;
                                        pageController.animateToPage(
                                            pageController.page!.toInt() + 1,
                                            duration:
                                                Duration(milliseconds: 400),
                                            curve: Curves.easeIn);
                                      },
                                      icon: const Icon(Icons.arrow_forward_ios),
                                    ),
                                  ),
                              ]);
                            }),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
