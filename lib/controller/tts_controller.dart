import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter_tts/flutter_tts_web.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/model/word.dart';

class TtsController extends GetxController {
  late FlutterTts _tts;

  TtsController() {
    _tts = FlutterTts();

    if (GetPlatform.isIOS) {
      isoSetting();
    }

    _tts.setLanguage('ja-JP');
  }

  @override
  void onClose() {
    _tts.stop();
    super.onClose();
  }

  void isoSetting() async {
    await _tts.setSharedInstance(true);
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

  // Future<void> systemSpeak(String japanese, String korean) async {
  //   await _tts.awaitSpeakCompletion(true);
  //   _tts.setLanguage('ja-JP');
  //   await _tts.speak(japanese);
  //   _tts.setLanguage('ko-KR');
  //   await _tts.speak(korean);
  // }

  Future<void> systemSpeak(Word word) async {
    await _tts.awaitSpeakCompletion(true);
    if (GetPlatform.isIOS) {
      _tts.setLanguage('ja-JP');
      await _tts.speak(word.word);
      _tts.setLanguage('ko-KR');
      await _tts.speak(word.mean);
    } else {
      _tts.setLanguage('ja-JP');
      await _tts.speak(word.yomikata);
      _tts.setLanguage('ko-KR');
      await _tts.speak(word.mean);
    }
  }
}
