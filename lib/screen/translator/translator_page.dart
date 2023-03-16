import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:japanese_voca/common/network.dart';
import 'package:japanese_voca/model/translator_word.dart';
import 'package:japanese_voca/repository/localRepository.dart';

final List<String> languages = ['KO', 'EN', 'JP'];

class TranslatorPage extends StatefulWidget {
  const TranslatorPage({super.key});

  @override
  State<TranslatorPage> createState() => TtranslatorStatePage();
}

class TtranslatorStatePage extends State<TranslatorPage> {
  List<TranslatorWord> words = [];
  LocalReposotiry localReposotiry = LocalReposotiry();
  late TextEditingController controller;
  bool isReFresh = false;
  late FocusNode focusNode;

  void loadData() async {
    words = await localReposotiry.getAllTranslatorWord();
    isReFresh = true;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadData();
    controller = TextEditingController();
    focusNode = FocusNode();
  }

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  NetWork netWork = NetWork();
  String word1 = '';
  String word2 = '';
  bool isWord1Wait = false;
  bool isWord2Wait = false;
  String originalLan = 'KO';
  String target1Lan = 'EN';
  String target2Lan = 'JP';

  void copyText(String word) {
    Clipboard.setData(ClipboardData(text: word));
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Copied $word !'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          child: const Icon(Icons.info_outline),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('How to Use'),
                  content: const Text(
                      '1. Select the language to translate\n2. Click to copy the searched sentence\n3. Slide the saved text to the right to delete it'),
                  actions: [
                    IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.exit_to_app))
                  ],
                );
              },
            );
          },
        ),
      ),
      body: !isReFresh
          ? const CircularProgressIndicator()
          : Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: DropdownButton(
                        value: originalLan,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: languages.map((String item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: (String? newVal) {
                          originalLan = newVal!;
                          focusNode.requestFocus();
                          setState(() {});
                        },
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            child: Material(
                              child: TextFormField(
                                focusNode: focusNode,
                                autofocus: true,
                                onFieldSubmitted: (value) {
                                  sendMessageToPapago(value: value);
                                },
                                controller: controller,
                                decoration:
                                    const InputDecoration(hintText: 'input'),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () {
                            sendMessageToPapago();
                          },
                          //
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            controller.clear();
                            focusNode.requestFocus();
                          },
                        ),
                      ],
                    ),
                    // translator
                    if (word1 == '' &&
                        word2 == '' &&
                        !(isWord1Wait == true || isWord2Wait == true))
                      const SizedBox(height: 70),

                    isWord1Wait == true || isWord2Wait == true
                        ? const Padding(
                            padding: EdgeInsets.all(18.0),
                            child: CircularProgressIndicator(),
                          )
                        : Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  const SizedBox(height: 15),
                                  if (word1 != '')
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                              onTap: () => copyText(word1),
                                              child: Text(word1)),
                                        ),
                                        IconButton(
                                            onPressed: () async {
                                              controller.text = word1;

                                              switch (target1Lan) {
                                                case 'KO':
                                                  originalLan = 'KO';
                                                  break;
                                                case 'EN':
                                                  originalLan = 'EN';
                                                  break;
                                                case 'JP':
                                                  originalLan = 'JP';
                                                  break;
                                              }
                                              setState(() {
                                                sendMessageToPapago();
                                              });
                                            },
                                            icon: const Icon(Icons.send))
                                      ],
                                    ),
                                  const SizedBox(height: 15),
                                  if (word2 != '')
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: InkWell(
                                            onTap: () => copyText(word2),
                                            child: Text(word2),
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () async {
                                              controller.text = word2;

                                              switch (target2Lan) {
                                                case 'KO':
                                                  originalLan = 'KO';
                                                  break;
                                                case 'EN':
                                                  originalLan = 'EN';
                                                  break;
                                                case 'JP':
                                                  originalLan = 'JP';
                                                  break;
                                              }
                                              sendMessageToPapago();
                                            },
                                            icon: const Icon(Icons.send))
                                      ],
                                    ),
                                  const SizedBox(height: 15),
                                ],
                              ),
                            ),
                          ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      child: Divider(),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List.generate(words.length, (index) {
                              List<String> savedWord =
                                  words[words.length - index - 1].getEnglish();
                              return Slidable(
                                endActionPane: ActionPane(
                                  motion: ScrollMotion(),
                                  children: [
                                    SlidableAction(
                                      onPressed: (context) {
                                        words
                                            .removeAt(words.length - index - 1);

                                        localReposotiry.deleteTranslatorWord(
                                            words[words.length - index - 1]);
                                        setState(() {});
                                      },
                                      backgroundColor: Color(0xFFFE4A49),
                                      foregroundColor: Colors.white,
                                      icon: Icons.delete,
                                      label: 'Delete',
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        margin:
                                            const EdgeInsets.only(bottom: 20.0),
                                        child: TextButton(
                                          child: Text(savedWord[0]),
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: Text(savedWord[0]),
                                                  content:
                                                      SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        Text(savedWord[1]),
                                                        const SizedBox(
                                                            height: 30),
                                                        Text(savedWord[2]),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            })),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  void sendMessageToPapago({value}) async {
    if (controller.text.isEmpty) return;

    setState(() {
      isWord1Wait = true;
      isWord2Wait = true;
    });

    switch (originalLan) {
      // 'KO', 'EN', 'JP'
      case 'KO':
        word1 = await netWork.getWordMean(
            source: 'ko', target: 'ja', word: controller.text);

        word2 =
            await netWork.getWordMean(source: 'ja', target: 'en', word: word1);

        target1Lan = 'JP';
        target2Lan = 'EN';
        break;

      case 'EN':
        word1 = await netWork.getWordMean(
            source: 'en', target: 'ko', word: controller.text);

        target1Lan = 'KO';

        word2 = await netWork.getWordMean(
            source: 'en', target: 'ja', word: controller.text);

        target2Lan = 'JP';
        break;
      case 'JP':
        word1 = await netWork.getWordMean(
            source: 'ja', target: 'ko', word: controller.text);

        target1Lan = 'KO';

        word2 = await netWork.getWordMean(
            source: 'ja', target: 'en', word: controller.text);

        target2Lan = 'EN';
        break;
    }

    TranslatorWord newWord = TranslatorWord(
        originalWord: controller.text,
        target1Word: word1,
        target2Word: word2,
        originalLan: originalLan,
        target1Lan: target1Lan,
        target2Lan: target2Lan);
    words.add(newWord);

    localReposotiry.saveTranslatorWord(newWord);
    setState(() {
      isWord1Wait = false;
      isWord2Wait = false;
    });
  }
}
