// import 'package:animate_do/animate_do.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:japanese_voca/common/common.dart';
// import 'package:japanese_voca/common/widget/dimentions.dart';
// import 'package:japanese_voca/features/jlpt_study/screens/jlpt_study_sceen.dart';
// import 'package:japanese_voca/model/jlpt_step.dart';
// import 'package:japanese_voca/model/my_word.dart';
// import 'package:japanese_voca/features/setting/services/setting_controller.dart';
// import 'package:japanese_voca/features/jlpt_test/screens/jlpt_test_screen.dart';
// import 'package:japanese_voca/features/jlpt_and_kangi/jlpt/controller/jlpt_step_controller.dart';
// import 'package:japanese_voca/repository/my_word_repository.dart';

// import '../../config/colors.dart';
// import '../../model/word.dart';
// import '../../common/controller/tts_controller.dart';
// import '../../user/controller/user_controller.dart';

// class JlptStudyController extends GetxController {
//   int savedWordCount = 0;

//   bool isWordSaved = false;
//   JlptStepController jlptWordController = Get.find<JlptStepController>();
//   SettingController settingController = Get.find<SettingController>();
//   UserController userController = Get.find<UserController>();

//   TtsController ttsController = Get.find<TtsController>();

//   late JlptStep jlptStep;

//   int currentIndex = 0;

//   List<Word> words = [];

//   bool isSavedInLocal() {
//     MyWord newMyWord = MyWord.wordToMyWord(getWord());

//     newMyWord.createdAt = DateTime.now();
//     isWordSaved = MyWordRepository.savedInMyWordInLocal(newMyWord);
//     return isWordSaved;
//   }

//   void toggleSaveWord() {
//     MyWord newMyWord = MyWord.wordToMyWord(getWord());
//     if (isSavedInLocal()) {
//       MyWordRepository.deleteMyWord(newMyWord);
//       isWordSaved = false;
//       savedWordCount--;
//     } else {
//       MyWordRepository.saveMyWord(newMyWord);
//       isWordSaved = true;
//       savedWordCount++;
//     }
//     update();
//   }

//   void saveCurrentWord() {
//     userController.clickUnKnownButtonCount++;
//     // Word currentWord = getWord();

//     if (isSavedInLocal()) {
//       savedWordCount++;
//     }
//   }

//   Future<void> speakYomikata() async {
//     await ttsController.speak(getWord().yomikata);
//   }

//   @override
//   void onClose() {
//     // pageController.dispose();
//     ttsController.stop();
//     userController.updateCountYokumatigaeruWord(savedWordCount);
//     super.onClose();
//   }

//   void onPageChanged(int page) {
//     currentIndex = page;

//     update();
//   }

//   Word getWord() {
//     return words[currentIndex];
//   }

//   bool isAginText = false;

//   @override
//   void onInit() {
//     super.onInit();

//     // pageController = PageController(initialPage: currentIndex);
//     jlptStep = jlptWordController.getJlptStep();

//     if (jlptStep.unKnownWord.isNotEmpty) {
//       isAginText = true;
//       words = jlptStep.unKnownWord;
//     } else {
//       words = jlptStep.words;
//     }
//     isSavedInLocal();
//   }

//   Future<void> goToTest() async {
//     // 테스트를 본 적이 있으면.
//     if (jlptStep.wrongQestion != null &&
//         jlptStep.scores != 0 &&
//         jlptStep.scores != jlptStep.words.length) {
//       bool result = await askToWatchMovieAndGetHeart(
//         title: const Text('과거의 테스트에서 틀린 문제들이 있습니다.'),
//         content: const Text(
//           '틀린 문제를 다시 보시겠습니까 ?',
//           style: TextStyle(
//             color: AppColors.scaffoldBackground,
//           ),
//         ),
//       );
//       if (result) {
//         // 과거에 틀린 문제로만 테스트 보기.
//         Get.toNamed(
//           JLPT_TEST_PATH,
//           arguments: {
//             CONTINUTE_JLPT_TEST: jlptStep.wrongQestion,
//           },
//         );
//       }
//     }

//     // 모든 문제로 테스트 보기.
//     Get.toNamed(
//       JLPT_TEST_PATH,
//       arguments: {
//         JLPT_TEST: jlptStep.words,
//       },
//     );
//   }
// }
