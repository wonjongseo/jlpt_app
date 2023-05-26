import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../common/widget/kangi_text.dart';
import '../../../model/my_word.dart';
import '../../../repository/local_repository.dart';
import '../../../repository/my_word_repository.dart';
import '../components/flip_button.dart';
import 'my_word_tutorial_service.dart';

class MyVocaController extends GetxController {
  List<MyWord> myWords = [];

  // 키보드 On / OF
  bool isTextFieldOpen = true;

  // Flip 기능 종류
  bool isOnlyKnown = false;
  bool isOnlyUnKnown = false;
  bool isWordFlip = false;

  late bool isSeenTutorial;

  MyWordRepository myWordReposotiry = MyWordRepository();

  late TextEditingController wordController;
  late TextEditingController yomikataController;
  late TextEditingController meanController;

  late FocusNode wordFocusNode;
  late FocusNode yomikataFocusNode;
  late FocusNode meanFocusNode;

  late MyVocaTutorialService? myVocaTutorialService = null;

  MyWord getCurrentMyWord(int index) {
    return myWords[myWords.length - 1 - index];
  }

  Map<DateTime, List<MyWord>> kEvents = {};
  void loadData() async {
    myWords = await myWordReposotiry.getAllMyWord();
    DateTime now = DateTime.now();
    kEvents = LinkedHashMap<DateTime, List<MyWord>>(
      equals: isSameDay,
      hashCode: getHashCode,
    );

    for (int i = 0; i < myWords.length; i++) {
      if (myWords[i].createdAt == null) {
        DateTime savedDate = DateTime.utc(now.year, now.month, now.day);
        kEvents.addAll({
          savedDate: [...kEvents[savedDate] ?? [], myWords[i]]
        });
      } else {
        DateTime savedDate = DateTime.utc(myWords[i].createdAt!.year,
            myWords[i].createdAt!.month, myWords[i].createdAt!.day);
        kEvents.addAll(
          {
            savedDate: [...kEvents[savedDate] ?? [], myWords[i]]
          },
        );
      }
    }
    update();
  }

  @override
  void onInit() async {
    super.onInit();

    isSeenTutorial = LocalReposotiry.isSeenMyWordTutorial();

    if (!isSeenTutorial) {
      MyWord tempWord = MyWord(word: '食べる', mean: '먹다', yomikata: 'たべる');
      tempWord.isKnown = true;

      tempWord.createdAt = DateTime.now();

      myWords.add(tempWord);

      update();
      myVocaTutorialService = MyVocaTutorialService();
      myVocaTutorialService!.initTutorial();
      //TODO
      // myVocaTutorialService!.showTutorial(context, () {
      //   myWords.remove(tempWord);
      //   update();
      //   // setState(() {});
      // });
    } else {
      loadData();
    }

    wordController = TextEditingController();
    yomikataController = TextEditingController();
    meanController = TextEditingController();
    wordFocusNode = FocusNode();
    yomikataFocusNode = FocusNode();
    meanFocusNode = FocusNode();
  }

  @override
  void onClose() {
    wordController.dispose();
    yomikataController.dispose();
    meanController.dispose();
    wordFocusNode.dispose();
    yomikataFocusNode.dispose();
    meanFocusNode.dispose();
    super.onClose();
  }

  void saveWord() async {
    String word = wordController.text;
    String yomikata = yomikataController.text;
    String mean = meanController.text;

    if (word.isEmpty) {
      wordFocusNode.requestFocus();
      return;
    }
    if (yomikata.isEmpty) {
      yomikataFocusNode.requestFocus();
      return;
    }
    if (mean.isEmpty) {
      meanFocusNode.requestFocus();
      return;
    }

    MyWord newWord = MyWord(word: word, mean: mean, yomikata: yomikata);
    DateTime now = DateTime.now();
    newWord.createdAt = now;

    if (kEvents[now] == null) {
      kEvents[now] = [];
    }
    kEvents[now]!.add(newWord);

    myWords.add(newWord);
    MyWordRepository.saveMyWord(newWord);

    selectedEvents.value.add(newWord);
    update();

    wordController.clear();
    meanController.clear();
    yomikataController.clear();
    wordFocusNode.requestFocus();

    update();
  }

  // void deleteWord(MyWord word) {
  //   myWordReposotiry.deleteMyWord(word);
  //   DateTime time = DateTime.utc(
  //       word.createdAt!.year, word.createdAt!.month, word.createdAt!.day);
  //   // kEvents[time]!.remove(Event(deletedWord.word));

  //   for (int i = 0; i < kEvents[time]!.length; i++) {
  //     print('kEvents[i]: ${kEvents[time]![i]}');
  //     if (word.word == kEvents[time]![i].word) {
  //       print('YES');
  //       kEvents[time]!.removeAt(i);
  //     }
  //   }

  //   print('kEvents[time]: ${kEvents[time]}');
  //   myWords.remove(word);
  //   update();
  // }
  void deleteWord(int index) {
    MyWord deletedWord = myWords[index];
    myWordReposotiry.deleteMyWord(deletedWord);

    DateTime time = DateTime.utc(deletedWord.createdAt!.year,
        deletedWord.createdAt!.month, deletedWord.createdAt!.day);
    // kEvents[time]!.remove(Event(deletedWord.word));

    for (int i = 0; i < kEvents[time]!.length; i++) {
      print('kEvents[i]: ${kEvents[time]![i]}');
      if (deletedWord.word == kEvents[time]![i].word) {
        print('YES');
        kEvents[time]!.removeAt(i);
      }
    }

    print('kEvents[time]: ${kEvents[time]}');
    myWords.remove(deletedWord);
    update();
  }

  void updateWord(MyWord myword) {
    myWordReposotiry.updateKnownMyVoca(myword);
    update();
  }

  void clickMyWord(BuildContext context, MyWord myWord) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: KangiText(
            fontSize: 40,
            color: Colors.black,
            japanese: myWord.word,
            clickTwice: false,
          ),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '의미 : ${myWord.mean}',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '읽는 법 : ${myWord.yomikata}',
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void changeFunc(BuildContext context) {
    Get.dialog(
      AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FlipButton(
                    text: '암기 단어',
                    onTap: () {
                      isOnlyKnown = true;
                      isOnlyUnKnown = false;
                      // setState(() {});
                      update();
                      Navigator.pop(context);
                    }),
                const SizedBox(width: 10),
                FlipButton(
                    text: '미암기 단어',
                    onTap: () {
                      isOnlyUnKnown = true;
                      isOnlyKnown = false;
                      // setState(() {});
                      update();
                      Navigator.pop(context);
                    }),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FlipButton(
                    text: '모든 단어',
                    onTap: () {
                      isOnlyKnown = false;
                      isOnlyUnKnown = false;
                      // setState(() {});
                      update();
                      Navigator.pop(context);
                    }),
                const SizedBox(width: 10),
                FlipButton(
                    text: '뒤집기',
                    onTap: () {
                      isWordFlip = !isWordFlip;
                      // setState(() {});
                      update();
                      Navigator.pop(context);
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }

  seeByReverse(BuildContext context) {
    isWordFlip = !isWordFlip;
    // setState(() {});
    update();
    Navigator.pop(context);
  }

  seeByAllWord(BuildContext context) {
    isOnlyKnown = false;
    isOnlyUnKnown = false;
    // setState(() {});
    update();
    Navigator.pop(context);
  }

  seeByUnKnownWord(BuildContext context) {
    isOnlyUnKnown = true;
    isOnlyKnown = false;
    // setState(() {});
    update();
    Navigator.pop(context);
  }

  seeByKnownWord(BuildContext context) {
    isOnlyKnown = true;
    isOnlyUnKnown = false;
    // setState(() {});
    update();
    Navigator.pop(context);
  }

  // Calden
  final kToday = DateTime.now();
  CalendarFormat calendarFormat = CalendarFormat.twoWeeks;

  final ValueNotifier<List<MyWord>> selectedEvents = ValueNotifier([]);

  DateTime focusedDay = DateTime.now();
  final Set<DateTime> selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
  );
  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }

  List<MyWord> getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  List<MyWord> getEventsForDays(Set<DateTime> days) {
    return [
      for (final d in days) ...getEventsForDay(d),
    ];
  }

  void onFormatChanged(format) {
    if (calendarFormat != format) {
      calendarFormat = format;
      // setState(() {});
      update();
    }
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    focusedDay = focusedDay;
    if (selectedDays.contains(selectedDay)) {
      selectedDays.remove(selectedDay);
    } else {
      selectedDays.add(selectedDay);
    }
    // setState(() {});
    update();

    selectedEvents.value = getEventsForDays(selectedDays);
  }
}
