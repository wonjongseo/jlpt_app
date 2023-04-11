import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/cusomt_button.dart';
import 'package:japanese_voca/common/widget/kangi_text.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/repository/localRepository.dart';

const MY_VOCA_PATH = '/myvoca';

class MyVocaPage extends StatefulWidget {
  const MyVocaPage({super.key});

  @override
  State<MyVocaPage> createState() => _MyVocaPageState();
}

class _MyVocaPageState extends State<MyVocaPage> {
  List<MyWord> myWords = [];
  List<bool> isKnwonWords = [];
  bool isReFresh = false;
  bool isOnlyKnown = false;
  bool isOnlyUnKnown = false;
  bool isWordFlip = false;
  LocalReposotiry localReposotiry = LocalReposotiry();
  late TextEditingController controller1;
  late TextEditingController controller2;
  late TextEditingController controller3;

  late FocusNode focusNode;

  void loadData() async {
    myWords = await localReposotiry.getAllMyWord();
    isReFresh = true;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadData();

    controller1 = TextEditingController();
    controller2 = TextEditingController();
    controller3 = TextEditingController();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void deleteWord(int index) {
    localReposotiry.deleteMyWord(myWords[index]);
    myWords.removeAt(index);
  }

  void updateWord(int index) {
    localReposotiry.updateKnownMyVoca(myWords[index]);
  }

  void saveWord() async {
    String word = controller1.text;
    String mean = controller2.text;
    if (word.isEmpty || mean.isEmpty) return;

    MyWord newWord = MyWord(word: word, mean: mean);
    myWords.add(newWord);

    LocalReposotiry.saveMyWord(newWord);

    controller1.clear();
    controller2.clear();
    focusNode.requestFocus();

    setState(() {});
  }

  bool isFold = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    print(width);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(20),
              textStyle: const TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              isFold = !isFold;
              setState(() {});
            },
            child: const Text('Input Form Fold')),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: 16.0, horizontal: width > 500 ? 60 : 20),
        child: !isReFresh
            ? const CircularProgressIndicator()
            : Column(
                children: [
                  Stack(
                    children: [
                      Column(
                        children: [
                          Container(
                            height: isFold ? 0 : null,
                            width: isFold ? 0 : null,
                            padding: const EdgeInsets.only(
                                top: 16, bottom: 32, right: 60, left: 60),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Form(
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: double.infinity,
                                    child: TextFormField(
                                      enabled: isReFresh,
                                      autofocus: true,
                                      focusNode: focusNode,
                                      onFieldSubmitted: (value) {
                                        // sendMessageToPapago(value: value);
                                      },
                                      controller: controller1,
                                      decoration: InputDecoration(
                                          label: const Text('WORD'),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black
                                                    .withOpacity(0.2)),
                                          ),
                                          focusedBorder:
                                              const UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                          ),
                                          labelStyle: const TextStyle(
                                              color: Colors.black)),
                                    ),
                                  ),
                                  SizedBox(height: width > 500 ? 20 : 10),
                                  SizedBox(
                                    width: double.infinity,
                                    child: TextFormField(
                                      enabled: isReFresh,
                                      onFieldSubmitted: (value) => saveWord(),
                                      controller: controller2,
                                      decoration: InputDecoration(
                                          label: const Text('MEAN'),
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black
                                                    .withOpacity(0.2)),
                                          ),
                                          focusedBorder:
                                              const UnderlineInputBorder(
                                            borderSide:
                                                BorderSide(color: Colors.black),
                                          ),
                                          labelStyle: const TextStyle(
                                              color: Colors.black)),
                                    ),
                                  ),
                                  SizedBox(height: width > 500 ? 20 : 10),
                                  SizedBox(
                                    width: double.infinity,
                                    height: width > 500 ? 70 : 40,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white),
                                      child: const Icon(
                                        Icons.add,
                                        color: Colors.black,
                                      ),
                                      onPressed: saveWord,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          // const Divider(),
                          const SizedBox(
                            height: 10,
                            width: double.infinity,
                          ),
                        ],
                      ),
                      Positioned(
                          child: IconButton(
                        icon: const Icon(Icons.flip),
                        onPressed: () {
                          Get.dialog(AlertDialog(
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 2),
                            actionsAlignment: MainAxisAlignment.spaceAround,
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            content: SizedBox(
                              width: 300,
                              height: 150,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomButton(
                                        onTap: () {
                                          isOnlyKnown = false;
                                          isOnlyUnKnown = false;
                                          setState(() {});
                                          Navigator.pop(context);
                                        },
                                        text: 'All',
                                      ),
                                      const SizedBox(width: 10),
                                      CustomButton(
                                        onTap: () {
                                          isOnlyUnKnown = true;
                                          isOnlyKnown = false;

                                          setState(() {});
                                          Navigator.pop(context);
                                        },
                                        text: 'UnKown',
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomButton(
                                        onTap: () {
                                          isOnlyKnown = true;
                                          isOnlyUnKnown = false;

                                          setState(() {});
                                          Navigator.pop(context);
                                        },
                                        text: 'Known',
                                      ),
                                      const SizedBox(width: 10),
                                      CustomButton(
                                          onTap: () {
                                            isWordFlip = !isWordFlip;
                                            setState(() {});
                                            Navigator.pop(context);
                                          },
                                          text: 'Flip')
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ));
                        },
                      )),
                    ],
                  ),

                  // List
                  Expanded(
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(myWords.length, (index) {
                            if (isOnlyKnown) {
                              if (myWords[myWords.length - 1 - index].isKnown ==
                                  false) {
                                return SizedBox();
                              }
                            } else if (isOnlyUnKnown) {
                              if (myWords[myWords.length - 1 - index].isKnown ==
                                  true) {
                                return SizedBox();
                              }
                            }
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Slidable(
                                startActionPane: ActionPane(
                                  motion: ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) {
                                        updateWord(myWords.length - index - 1);

                                        setState(() {});
                                      },
                                      backgroundColor: Colors.blueAccent,
                                      foregroundColor: Colors.white,
                                      icon: Icons.check,
                                      label: myWords[myWords.length - 1 - index]
                                                  .isKnown ==
                                              true
                                          ? 'Uknown'
                                          : 'Known',
                                    ),
                                  ],
                                ),
                                endActionPane: ActionPane(
                                  motion: ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) {
                                        deleteWord(myWords.length - index - 1);

                                        setState(() {});
                                      },
                                      backgroundColor: Color(0xFFFE4A49),
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Delete',
                                    ),
                                  ],
                                ),
                                child: MyWordCard(
                                    isWordFlip: isWordFlip,
                                    myWord:
                                        myWords[myWords.length - 1 - index]),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class MyWordCard extends StatelessWidget {
  const MyWordCard({
    super.key,
    required this.myWord,
    required this.isWordFlip,
  });

  final MyWord myWord;
  final bool isWordFlip;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: KangiText(
                japanese: myWord.word,
                clickTwice: false,
              ),
              content: Text(myWord.mean),
            );
          },
        );
      },
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1, color: Colors.grey),
            boxShadow: [
              BoxShadow(
                color: myWord.isKnown
                    ? Colors.grey.withOpacity(0.7)
                    : Colors.white,
                offset: Offset(0, 1),
              )
            ]),
        child: Center(child: Text(isWordFlip ? myWord.mean : myWord.word)),
      ),
    );
  }
}
