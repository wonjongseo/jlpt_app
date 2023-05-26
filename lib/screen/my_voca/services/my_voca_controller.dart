// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';

// import '../../../model/my_word.dart';
// import '../../../repository/local_repository.dart';
// import '../../../repository/my_word_repository.dart';
// import 'my_word_tutorial_service.dart';

// class MyVocaController extends GetxController {
//   List<MyWord> myWords = [];

//   // 키보드 On / OF
//   bool isTextFieldOpen = true;

//   final BuildContext context;

//   MyVocaController({required this.context});

//   // Flip 기능 종류
//   bool isOnlyKnown = false;
//   bool isOnlyUnKnown = false;
//   bool isWordFlip = false;

//   late bool isSeenTutorial;

//   MyWordRepository myWordReposotiry = MyWordRepository();

//   late TextEditingController wordController;
//   late TextEditingController yomikataController;
//   late TextEditingController meanController;

//   late FocusNode wordFocusNode;
//   late FocusNode yomikataFocusNode;
//   late FocusNode meanFocusNode;

//   late MyVocaTutorialService? myVocaTutorialService = null;

//   void loadData() async {
//     myWords = await myWordReposotiry.getAllMyWord();
//   }

//   @override
//   void onInit() async {
//     super.onInit();

//     isSeenTutorial = LocalReposotiry.isSeenMyWordTutorial();

//     if (!isSeenTutorial) {
//       MyWord tempWord = MyWord(word: '食べる', mean: '먹다', yomikata: 'たべる');
//       tempWord.isKnown = true;
//       DateTime now = DateTime.now();
//       String nowString = now.toString();
//        String formattedNow = nowString.substring(0,16);
//       tempWord.createdAt = formattedNow;

//       myWords.add(tempWord);
//       // setState(() {});
//       update();
//       myVocaTutorialService = MyVocaTutorialService();
//       myVocaTutorialService!.initTutorial();
//       myVocaTutorialService!.showTutorial(context, () {
//         myWords.remove(tempWord);
//         update();
//         // setState(() {});
//       });
//     } else {
//       loadData();
//     }

//     wordController = TextEditingController();
//     yomikataController = TextEditingController();
//     meanController = TextEditingController();
//     wordFocusNode = FocusNode();
//     yomikataFocusNode = FocusNode();
//     meanFocusNode = FocusNode();
//   }

//   @override
//   void onClose() {
//     wordController.dispose();
//     yomikataController.dispose();
//     meanController.dispose();
//     wordFocusNode.dispose();
//     yomikataFocusNode.dispose();
//     meanFocusNode.dispose();
//     super.onClose();
//   }

//   void saveWord() async {
//     String word = wordController.text;
//     String yomikata = yomikataController.text;
//     String mean = meanController.text;

//     if (word.isEmpty) {
//       wordFocusNode.requestFocus();
//       return;
//     }
//     if (yomikata.isEmpty) {
//       yomikataFocusNode.requestFocus();
//       return;
//     }
//     if (mean.isEmpty) {
//       meanFocusNode.requestFocus();
//       return;
//     }

//     MyWord newWord = MyWord(word: word, mean: mean, yomikata: yomikata);

//     DateTime now = DateTime.now();
//     String nowString = now.toString();
//      String formattedNow = nowString.substring(0,16);
//     newWord.createdAt = formattedNow;

//     myWords.add(newWord);
//     MyWordRepository.saveMyWord(newWord);

//     wordController.clear();
//     meanController.clear();
//     yomikataController.clear();
//     wordFocusNode.requestFocus();

//     setState(() {});
//   }

//   void deleteWord(int index) {
//     myWordReposotiry.deleteMyWord(myWords[index]);
//     myWords.removeAt(index);
//   }

//   void updateWord(int index) {
//     myWordReposotiry.updateKnownMyVoca(myWords[index]);
//   }

//   void changeFunc() {
//     Get.dialog(
//       AlertDialog(
//         backgroundColor: Colors.transparent,
//         elevation: 0,
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 FlipButton(
//                     text: '암기 단어',
//                     onTap: () {
//                       isOnlyKnown = true;
//                       isOnlyUnKnown = false;
//                       setState(() {});
//                       Navigator.pop(context);
//                     }),
//                 const SizedBox(width: 10),
//                 FlipButton(
//                     text: '미암기 단어',
//                     onTap: () {
//                       isOnlyUnKnown = true;
//                       isOnlyKnown = false;
//                       setState(() {});
//                       Navigator.pop(context);
//                     }),
//               ],
//             ),
//             const SizedBox(height: 10),
//             Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 FlipButton(
//                     text: '모든 단어',
//                     onTap: () {
//                       isOnlyKnown = false;
//                       isOnlyUnKnown = false;
//                       setState(() {});
//                       Navigator.pop(context);
//                     }),
//                 const SizedBox(width: 10),
//                 FlipButton(
//                     text: '뒤집기',
//                     onTap: () {
//                       isWordFlip = !isWordFlip;
//                       setState(() {});
//                       Navigator.pop(context);
//                     }),
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }

// }
