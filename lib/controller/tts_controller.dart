// import 'package:flutter_tts/flutter_tts.dart';
// import 'package:flutter_tts/flutter_tts_web.dart';
// import 'package:get/get.dart';

// class TtsController extends GetxController {
//   late FlutterTts _tts;

//   TtsController() {
//     _tts = FlutterTts();

//     if (GetPlatform.isIOS) {
//       isoSetting();
//     }
//     _tts.setLanguage('ja-JP');
//   }

//   void isoSetting() async {
//     await _tts.setSharedInstance(true);
//     await _tts.setIosAudioCategory(
//         IosTextToSpeechAudioCategory.ambient,
//         [
//           IosTextToSpeechAudioCategoryOptions.allowBluetooth,
//           IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
//           IosTextToSpeechAudioCategoryOptions.mixWithOthers
//         ],
//         IosTextToSpeechAudioMode.voicePrompt);
//   }

//   void setSpeachRate(double speed) {
//     _tts.setSpeechRate(speed);
//   }

//   void isSpeaking() {}

//   Future<void> speak(String japanese, String korean) async {
//     FlutterTtsPlugin flutterTtsPlugin = FlutterTtsPlugin();

//     _tts.setLanguage('ja-JP');

//     await _tts.speak(japanese);

//     _tts.setLanguage('ko-KR');

//     await _tts.speak(korean);
//   }
// }

class TtsController {}
