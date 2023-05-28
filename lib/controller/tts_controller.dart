import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/model/word.dart';

enum TtsState { playing, stopped, paused, continued }

class TtsController extends GetxController {
  late FlutterTts _tts;

  double volume = 0.5;
  double pitch = 1.0;
  double rate = 0.5;
  bool isCurrentLanguageInstalled = false;

  String? _newVoiceText;
  int? _inputLength;

  TtsState ttsState = TtsState.stopped;
  get isPlaying => ttsState == TtsState.playing;
  get isStopped => ttsState == TtsState.stopped;
  get isPaused => ttsState == TtsState.paused;
  get isContinued => ttsState == TtsState.continued;

  bool get isIOS => !kIsWeb && Platform.isIOS;
  bool get isAndroid => !kIsWeb && Platform.isAndroid;
  bool get isWindows => !kIsWeb && Platform.isWindows;
  bool get isWeb => kIsWeb;

  TtsController() {
    _tts = FlutterTts();

    // _setAwaitOptions();

    if (GetPlatform.isIOS) {
      isoSetting();
    }

    _tts.setLanguage('ja-JP');
  }

  @override
  void onClose() {
    _tts.pause();
    _tts.stop();
    super.onClose();
  }

  Future _setAwaitOptions() async {
    await _tts.awaitSpeakCompletion(true);
  }

  void isoSetting() async {
    print('1');
    await _tts.setSharedInstance(true);

    await _tts.awaitSpeakCompletion(true);
    await _tts.awaitSynthCompletion(true);
    await _tts.setIosAudioCategory(
        IosTextToSpeechAudioCategory.ambient,
        [
          IosTextToSpeechAudioCategoryOptions.allowBluetooth,
          IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
          IosTextToSpeechAudioCategoryOptions.mixWithOthers
        ],
        IosTextToSpeechAudioMode.defaultMode);
  }

  void setSpeachRate(double speed) {
    _tts.setSpeechRate(speed);
  }

  void stopListening() {
    _tts.pauseHandler;
  }

  Future<void> systemSpeak(Word word) async {
    _tts.setLanguage('ja-JP');
    await _tts.speak(word.yomikata);
    _tts.setLanguage('ko-KR');
    await _tts.speak(word.mean);
  }
}
