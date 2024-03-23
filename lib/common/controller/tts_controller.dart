import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/user/controller/user_controller.dart';

import '../../model/word.dart';

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

  Future setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
    await flutterTts.awaitSynthCompletion(true);
  }

  @override
  void dispose() {
    super.dispose();

    pause();
    stop();
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

  Future pause() async {
    var result = await flutterTts.pause();
    if (result == 1) {
      ttsState = TtsState.paused;
      update();
    }
  }

  @override
  void onClose() {
    pause();
    stop();
    super.dispose();
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

    print('userController.volumn : ${userController.volumn}');
    print('(userController.rate : ${userController.rate}');
    print('userController.pitch : ${userController.pitch}');

    print('language : ${language}');
    print('word : ${word}');

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

    String mean = newWord.mean.replaceAll('~', '무엇무엇');

    if (mean.contains('\n')) {
      List<String> eachMeans = mean.split('\n');

      for (int i = 0; i < eachMeans.length; i++) {
        full += '${eachMeans[i]},';
      }
      await flutterTts.speak(full);
    } else {
      await flutterTts.speak(mean);
    }
  }

  Future _setAwaitOptions() async {
    await flutterTts.awaitSpeakCompletion(true);
  }

  bool disalbe = false;
  initTts() async {
    print('initTts');
    flutterTts = FlutterTts();
    var getLanguages = await flutterTts.getLanguages;
    print('getLanguages: ${getLanguages}');
    _setAwaitOptions();

    setAwaitOptions();

    if (isIOS) {
      await flutterTts.setIosAudioCategory(
          // IosTextToSpeechAudioCategory.playback,
          IosTextToSpeechAudioCategory.playback,
          [
            IosTextToSpeechAudioCategoryOptions.allowBluetooth,
            IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
            IosTextToSpeechAudioCategoryOptions.mixWithOthers
          ],
          IosTextToSpeechAudioMode.voicePrompt);
    }
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
