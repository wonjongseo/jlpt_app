import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/screen/listen_page.dart';
import 'package:japanese_voca/screen/user/controller/user_controller.dart';

import 'model/word.dart';

enum TtsState { playing, stopped, paused, continued }

class TtsController extends GetxController {
  late FlutterTts flutterTts;

  String? engine;
  int? inputLength;
  UserController userController = Get.find<UserController>();
  TtsState ttsState = TtsState.stopped;

  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;
  get isPaused => ttsState == TtsState.paused;
  get isContinued => ttsState == TtsState.continued;

  bool get isIOS => !kIsWeb && GetPlatform.isIOS;
  bool get isAndroid => !kIsWeb && GetPlatform.isAndroid;
  bool get isWindows => !kIsWeb && GetPlatform.isWindows;
  bool get isWeb => kIsWeb;

  // bool isAutoPlay = false;

  bool isCurrentLanguageInstalled = false;

  void changeVolumn(double newValue) {
    userController.updateSoundValues(SOUND_OPTIONS.VOLUMN, newValue);

    update();
  }

  void changePitch(double newPitch) {
    userController.updateSoundValues(SOUND_OPTIONS.PITCH, newPitch);
    update();
  }

  void changeRate(double newRate) {
    userController.updateSoundValues(SOUND_OPTIONS.RATE, newRate);

    update();
  }

  // Word? newWord;
  // int currentPageIndex = 0;

  // void onPageChange(int value) {
  //   currentPageIndex = value;
  //   if (!userController.isUserPremieum()) {
  //     // 상수변수로 변경하기

  //     if (currentPageIndex > 59) {
  //       currentPageIndex = 59;
  //       isAutoPlay = false;
  //       update();
  //       userController.openPremiumDialog('N1급 모든 단어 활성화');

  //       return;
  //     }
  //   }

  //   update();
  // }

  // void startListenWords(List<Word> words) async {
  //   isAutoPlay = true;
  //   update();
  //   for (int i = currentPageIndex; i < words.length; i++) {
  //     if (!isAutoPlay) return;
  //     newWord = words[currentPageIndex];
  //     if (newWord != null) {
  //       await japaneseSpeak(newWord!);
  //       await Future.delayed(const Duration(milliseconds: 150));
  //     }

  //     if (currentPageIndex < words.length - 1) {
  //       currentPageIndex++;
  //     } else {
  //       currentPageIndex = 0;
  //       i = 0;
  //     }

  //     if (pageController.hasClients) {
  //       onPageChange(currentPageIndex);
  //     }
  //   }
  // }

  Future setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }

  // Future stop() async {
  //   print('STOP');
  //   isAutoPlay = false;
  //   // await pause();

  //   var result = await flutterTts.stop();
  //   if (result == 1) {
  //     ttsState = TtsState.stopped;
  //     if (!isClosed) {
  //       update();
  //     }
  //   }
  // }

  // void autuPlayStop() {
  //   isAutoPlay = false;
  //   update();
  //   stop();
  // }

  // Future pause() async {
  //   isAutoPlay = false;
  //   var result = await flutterTts.pause();
  //   if (result == 1) {
  //     ttsState = TtsState.paused;
  //     update();
  //   }
  // }

  // late PageController pageController;

  @override
  void dispose() {
    super.dispose();

    // flutterTts.stop();
    stop();
    // isAutoPlay = false;
    // pageController.dispose();
  }

  stop() async {
    var result = await flutterTts.stop();
    if (result == 1) {
      ttsState = TtsState.stopped;
      if (!isClosed) {
        update();
      }
    }
  }

  @override
  void onClose() {
    super.dispose();

    // flutterTts.stop();
    stop();
    // isAutoPlay = false;
    // pageController.dispose();
  }

  @override
  void onInit() {
    super.onInit();

    initTts();
  }

  Future getDefaultEngine() async {
    var engine = await flutterTts.getDefaultEngine;
    if (engine != null) {
      log(engine);
    }
  }

  Future getDefaultVoice() async {
    var voice = await flutterTts.getDefaultVoice;
    if (voice != null) {
      log(voice);
    }
  }

  Future<void> speak(String word, {String language = 'ja-JP'}) async {
    if (isPlaying) return;
    await flutterTts.setVolume(userController.volumn);
    await flutterTts.setSpeechRate(userController.rate);
    await flutterTts.setPitch(userController.pitch);

    flutterTts.setLanguage(language);
    await flutterTts.speak(word);
  }

  Future<void> japaneseSpeak(Word newWord) async {
    await flutterTts.setVolume(userController.volumn);
    await flutterTts.setSpeechRate(userController.rate);
    await flutterTts.setPitch(userController.pitch);

    flutterTts.setLanguage('ja-JP');
    await flutterTts.speak(newWord.yomikata);
    await Future.delayed(const Duration(milliseconds: 150));
    flutterTts.setLanguage('ko-KR');
    String full = '';
    if (newWord.mean.contains('\n')) {
      List<String> aa = newWord.mean.split('\n');

      for (int i = 0; i < aa.length; i++) {
        full += '${aa[i]},';
      }
      await flutterTts.speak(full);
    } else {
      await flutterTts.speak(newWord.mean);
    }
  }

  bool disalbe = false;
  initTts() async {
    flutterTts = FlutterTts();
    setAwaitOptions();

    if (isAndroid) {
      getDefaultEngine();
      getDefaultVoice();
    }

    flutterTts.setStartHandler(() {
      disalbe = true;
      log("Playing");
      ttsState = TtsState.playing;

      update();
    });

    if (isAndroid) {
      flutterTts.setInitHandler(() {
        log("TTS Initialized");
        update();
      });
    }

    flutterTts.setCompletionHandler(() {
      disalbe = false;
      log("Complete");

      ttsState = TtsState.stopped;

      update();
    });

    flutterTts.setCancelHandler(() {
      log("Cancel");
      ttsState = TtsState.stopped;
    });

    flutterTts.setPauseHandler(() {
      update();
      log("Paused");
      ttsState = TtsState.paused;
    });

    flutterTts.setContinueHandler(() {
      log("Continued");
      ttsState = TtsState.continued;
      update();
    });

    flutterTts.setErrorHandler((msg) {
      log("error: $msg");
      ttsState = TtsState.stopped;
      update();
    });
  }
}
