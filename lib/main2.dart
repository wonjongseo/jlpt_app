// // ignore_for_file: library_private_types_in_public_api

// import 'dart:async';
// import 'dart:developer';
// import 'dart:io' show Platform;
// import 'package:flutter/foundation.dart' show kIsWeb;

// import 'package:flutter/material.dart';
// import 'package:flutter_tts/flutter_tts.dart';

// import 'model/word.dart';
// // import 'package:jlpt_jonggack/model/word.dart';

// MUST
// await flutterTts.setIosAudioCategory(IosTextToSpeechAudioCategory.ambient,
//      [
//           IosTextToSpeechAudioCategoryOptions.allowBluetooth,
//           IosTextToSpeechAudioCategoryOptions.allowBluetoothA2DP,
//           IosTextToSpeechAudioCategoryOptions.mixWithOthers
//      ],
//      IosTextToSpeechAudioMode.voicePrompt
// );


// List<Map<String, String>> tempMap = [
//   {
//     "word": "己惚れる·自惚れる",
//     "yomikata": "うぬぼれる",
//     "mean": "자부하다, 자만하다",
//     "headTitle": "챕터2"
//   },
//   {
//     "word": "生(ま)れつき·生(ま)れ付き",
//     "yomikata": "うまれつき",
//     "mean": "1. 타고난 것, 천성\n2. 선천적으로, 천성으로",
//     "headTitle": "챕터2"
//   },
//   {
//     "word": "裏返(し)",
//     "yomikata": "うらがえし",
//     "mean": "뒤집음, 혹은 뒤집혀 있음",
//     "headTitle": "챕터2"
//   },
//   {
//     "word": "売(り)出し",
//     "yomikata": "うりだし",
//     "mean": "1. 팔기 시작함\n2. 매출, 방매\n3. 갑자기 인기가 높아짐",
//     "headTitle": "챕터2"
//   },
//   {
//     "word": "売(り)出す",
//     "yomikata": "うりだす",
//     "mean": "1. 팔기 시작하다\n2. 대대적으로 팔다, 매출하다\n3. 유명해지다",
//     "headTitle": "챕터2"
//   },
//   {
//     "word": "潤う·湿う",
//     "yomikata": "うるおう",
//     "mean": "1. 습기를 띠다, 축축해지다\n2. 풍부해지다, 혜택을 얻다\n3. 마음이 따뜻해지다",
//     "headTitle": "챕터2"
//   },
//   {"word": "売れ筋", "yomikata": "うれすじ", "mean": "잘 팔리는 상품", "headTitle": "챕터2"},
//   {
//     "word": "浮気",
//     "yomikata": "うわき",
//     "mean": "1. 바람기\n2. 변덕, 마음이 들떠 변하기 잘함",
//     "headTitle": "챕터2"
//   },
//   {
//     "word": "上回る·上廻る",
//     "yomikata": "うわまわる",
//     "mean": "상회하다, 많아지다",
//     "headTitle": "챕터2"
//   },
//   {"word": "植わる", "yomikata": "うわる", "mean": "심어지다", "headTitle": "챕터2"},
//   {"word": "運営", "yomikata": "うんえい", "mean": "운영", "headTitle": "챕터2"},
//   {
//     "word": "うんざり",
//     "yomikata": "うんざり",
//     "mean": "진절머리가 남, 지긋지긋함, 몹시 싫증남",
//     "headTitle": "챕터2"
//   },
//   {"word": "運送", "yomikata": "うんそう", "mean": "운송", "headTitle": "챕터2"},
//   {"word": "云云", "yomikata": "うんぬん", "mean": "운운", "headTitle": "챕터2"},
//   {"word": "運搬", "yomikata": "うんぱん", "mean": "운반", "headTitle": "챕터2"},
//   {"word": "運命", "yomikata": "うんめい", "mean": "운명", "headTitle": "챕터2"},
//   {"word": "運輸", "yomikata": "うんゆ", "mean": "운수, 수송", "headTitle": "챕터2"},
//   {"word": "運用", "yomikata": "うんよう", "mean": "운용", "headTitle": "챕터2"},
//   {"word": "柄", "yomikata": "え", "mean": "자루, 손잡이", "headTitle": "챕터2"},
//   {"word": "映写", "yomikata": "えいしゃ", "mean": "영사", "headTitle": "챕터2"},
//   {"word": "英字", "yomikata": "えいじ", "mean": "영자", "headTitle": "챕터2"},
//   {"word": "映像", "yomikata": "えいぞう", "mean": "영상", "headTitle": "챕터2"},
//   {"word": "英雄", "yomikata": "えいゆう", "mean": "영웅", "headTitle": "챕터2"},
//   {"word": "液", "yomikata": "えき", "mean": "액, 즙, 액체", "headTitle": "챕터2"},
//   {"word": "閲覧", "yomikata": "えつらん", "mean": "열람", "headTitle": "챕터2"},
//   {
//     "word": "獲物",
//     "yomikata": "えもの",
//     "mean": "1. 수렵물, 어획물\n2. 전리품, 빼앗은 것",
//     "headTitle": "챕터2"
//   },
//   {
//     "word": "襟·衿",
//     "yomikata": "えり",
//     "mean": "1. 옷깃, 동정\n2. 목덜미",
//     "headTitle": "챕터2"
//   },
//   {
//     "word": "縁",
//     "yomikata": "えん",
//     "mean": "1. 인연, 연분\n2. 그렇게 될 운명\n3. 사물과의 관계·연결",
//     "headTitle": "챕터2"
//   },
//   {"word": "円滑", "yomikata": "えんかつ", "mean": "원활", "headTitle": "챕터2"},
//   {
//     "word": "縁がわ·縁側",
//     "yomikata": "えんがわ",
//     "mean": "1. 툇마루\n2. 물고기의 지느러미나 아가미 언저리의 살",
//     "headTitle": "챕터2"
//   },
//   {"word": "沿岸", "yomikata": "えんがん", "mean": "연안", "headTitle": "챕터2"},
//   {"word": "婉曲", "yomikata": "えんきょく", "mean": "완곡", "headTitle": "챕터2"},
//   {"word": "演出", "yomikata": "えんしゅつ", "mean": "연출", "headTitle": "챕터2"},
//   {
//     "word": "演ずる",
//     "yomikata": "えんずる",
//     "mean": "1. 하다, 행하다\n2. 진술하다",
//     "headTitle": "챕터2"
//   },
//   {"word": "沿線", "yomikata": "えんせん", "mean": "연선", "headTitle": "챕터2"},
//   {"word": "延滞", "yomikata": "えんたい", "mean": "연체", "headTitle": "챕터2"},
//   {"word": "縁談", "yomikata": "えんだん", "mean": "혼담", "headTitle": "챕터2"},
//   {"word": "遠方", "yomikata": "えんぽう", "mean": "원방, 먼 곳", "headTitle": "챕터2"},
//   {
//     "word": "円満",
//     "yomikata": "えんまん",
//     "mean": "1. 원만\n2. 신불의 공덕 등이 충분하여 빠짐이나 모자람이 없음",
//     "headTitle": "챕터2"
//   },
//   {
//     "word": "尾",
//     "yomikata": "お",
//     "mean": "1. 꼬리, 혹은 그와 비슷한 것\n2. 산기슭이 길게 뻗은 곳",
//     "headTitle": "챕터2"
//   },
//   {
//     "word": "追(い)込む",
//     "yomikata": "おいこむ",
//     "mean": "1. 몰아넣다\n2. 몰아들이다\n3. 빠지게 하다",
//     "headTitle": "챕터2"
//   },
//   {
//     "word": "生(い)立ち",
//     "yomikata": "おいたち",
//     "mean": "성장함, 생장함, 자라남",
//     "headTitle": "챕터2"
//   },
//   {
//     "word": "追(い)出す",
//     "yomikata": "おいだす",
//     "mean": "내쫓다, 몰아내다",
//     "headTitle": "챕터2"
//   },
//   {
//     "word": "於いて",
//     "yomikata": "おいて",
//     "mean": "1. ~에서, ~에 있어서\n2. ~에 관하여, ~으로",
//     "headTitle": "챕터2"
//   },
//   {
//     "word": "追(い)抜く",
//     "yomikata": "おいぬく",
//     "mean": "1. 앞지르다\n2. 따라잡다, 추월하다\n3. 상대보다 더 나아지다, 목표보다 더 낫다",
//     "headTitle": "챕터2"
//   },
//   {
//     "word": "老いる",
//     "yomikata": "おいる",
//     "mean": "1. 늙다, 노쇠하다\n2. 철이 다 되다",
//     "headTitle": "챕터2"
//   },
//   {
//     "word": "負う",
//     "yomikata": "おう",
//     "mean": "1. 지다\n2. 짊어지다, 업다\n3. 맞먹다, 알맞다",
//     "headTitle": "챕터2"
//   },
//   {"word": "応急", "yomikata": "おうきゅう", "mean": "응급", "headTitle": "챕터2"},
//   {
//     "word": "黄金",
//     "yomikata": "おうごん",
//     "mean": "1. 황금, 혹은 돈\n2. 매우 귀중한 것의 비유\n3. =おおばん2",
//     "headTitle": "챕터2"
//   },
//   {"word": "往診", "yomikata": "おうしん", "mean": "왕진", "headTitle": "챕터2"},
//   {"word": "旺盛", "yomikata": "おうせい", "mean": "왕성", "headTitle": "챕터2"},
//   {
//     "word": "おおい",
//     "yomikata": "おおい",
//     "mean": "멀리 있는 사람을 부르는 소리, 어이",
//     "headTitle": "챕터2"
//   },
//   {"word": "大方", "yomikata": "おおかた", "mean": "대충, 대개, 거의", "headTitle": "챕터2"},
//   {
//     "word": "大がら·大柄",
//     "yomikata": "おおがら",
//     "mean": "1. 몸집이나 형상 등이 보통보다 큼\n2. 무늬나 모양이 큼",
//     "headTitle": "챕터2"
//   },
//   {
//     "word": "大雑把",
//     "yomikata": "おおざっぱ",
//     "mean": "1. 대략적임, 조잡함\n2. 대충, 얼추\n3. 대범함",
//     "headTitle": "챕터2"
//   },
//   {"word": "大筋", "yomikata": "おおすじ", "mean": "대강, 요점", "headTitle": "챕터2"},
//   {"word": "大空", "yomikata": "おおぞら", "mean": "대공, 넓은 하늘", "headTitle": "챕터2"},
//   {
//     "word": "大幅·大巾",
//     "yomikata": "おおはば",
//     "mean": "1. 큰 폭, 보통 폭의 두 배의 폭\n2. 수량 등의 변동이 큰 모양",
//     "headTitle": "챕터2"
//   },
//   {
//     "word": "大まか",
//     "yomikata": "おおまか",
//     "mean": "1. 세세한 점까지 구애받지 않는 모양\n2. 후함, 손이 큼\n3. 대략적임, 대충",
//     "headTitle": "챕터2"
//   },
//   {"word": "大水", "yomikata": "おおみず", "mean": "홍수, 큰물", "headTitle": "챕터2"},
//   {
//     "word": "公",
//     "yomikata": "おおやけ",
//     "mean": "1. 공\n2. 조정, 정부\n3. 사유가 아님, 공유",
//     "headTitle": "챕터2"
//   },
//   {
//     "word": "大らか",
//     "yomikata": "おおらか",
//     "mean": "너글너글한 모양, 느긋하고 대범한 모양",
//     "headTitle": "챕터2"
//   },
//   {
//     "word": "犯す",
//     "yomikata": "おかす",
//     "mean": "1. 범하다\n2. 어기다\n3. 여자를 능욕하다",
//     "headTitle": "챕터2"
//   },
//   {"word": "臆病", "yomikata": "おくびょう", "mean": "겁이 많음", "headTitle": "챕터2"},
//   {
//     "word": "遅らす∙後らす",
//     "yomikata": "おくらす",
//     "mean": "1. 늦추다, 늦도록 하다\n2. 뒤에 남기고 가다, 내버려 두고 가다\n3. 遅らせる의 문어형",
//     "headTitle": "챕터2"
//   },
//   {"word": "遅れ", "yomikata": "おくれ", "mean": "늦음, 늦은 정도", "headTitle": "챕터2"},
//   {
//     "word": "怠る",
//     "yomikata": "おこたる",
//     "mean": "1. 게으름을 피우다, 태만히 하다\n2. 방심하다, 소홀히 하다\n3. 좀 나아지다",
//     "headTitle": "챕터2"
//   },
//   {
//     "word": "行(な)い",
//     "yomikata": "おこない",
//     "mean": "1. 행실, 행위\n2. 불공, 근행",
//     "headTitle": "챕터2"
//   },
//   {"word": "厳か", "yomikata": "おごそか", "mean": "엄숙함", "headTitle": "챕터2"},
//   {
//     "word": "押(さ)える·抑える·圧える",
//     "yomikata": "おさえる",
//     "mean": "1. 누르다\n2. 억압하다, 꺽다\n3. 억제하다, 막다",
//     "headTitle": "챕터2"
//   },
// ];

// class WordListenScreen extends StatefulWidget {
//   const WordListenScreen({super.key});

//   @override
//   _WordListenScreenState createState() => _WordListenScreenState();
// }

// enum TtsState { playing, stopped, paused, continued }

// class _WordListenScreenState extends State<WordListenScreen> {
//   List<Word> words = [];
//   late FlutterTts flutterTts;
//   // String? language;
//   String? engine;
//   double volume = 0.5;
//   double pitch = 1.0;
//   double rate = 0.5;
//   bool isCurrentLanguageInstalled = false;

//   // String? _newJapaneseText;
//   // String? _newMeanText;
//   int? _inputLength;

//   TtsState ttsState = TtsState.stopped;

//   get isPlaying => ttsState == TtsState.playing;
//   get isStopped => ttsState == TtsState.stopped;
//   get isPaused => ttsState == TtsState.paused;
//   get isContinued => ttsState == TtsState.continued;

//   bool get isIOS => !kIsWeb && Platform.isIOS;
//   bool get isAndroid => !kIsWeb && Platform.isAndroid;
//   bool get isWindows => !kIsWeb && Platform.isWindows;
//   bool get isWeb => kIsWeb;

//   bool isAutoPlay = false;

//   @override
//   initState() {
//     super.initState();
//     pageController = PageController();
//     initTts();

//     mapToWord();
//   }

//   void mapToWord() {
//     for (int j = 0; j < tempMap.length; j++) {
//       Word word = Word.fromMap(tempMap[j]);

//       words.add(word);
//     }
//   }

//   initTts() async {
//     flutterTts = FlutterTts();
//     List<dynamic>? languages = await flutterTts.getLanguages;
//     print('languages: ${languages}');
//     _setAwaitOptions();

//     if (isAndroid) {
//       _getDefaultEngine();
//       _getDefaultVoice();
//     }

//     flutterTts.setStartHandler(() {
//       setState(() {
//         log("Playing");
//         ttsState = TtsState.playing;
//       });
//     });

//     if (isAndroid) {
//       flutterTts.setInitHandler(() {
//         setState(() {
//           log("TTS Initialized");
//         });
//       });
//     }

//     flutterTts.setCompletionHandler(() {
//       setState(() {
//         log("Complete");
//         ttsState = TtsState.stopped;
//       });
//     });

//     flutterTts.setCancelHandler(() {
//       setState(() {
//         log("Cancel");
//         ttsState = TtsState.stopped;
//       });
//     });

//     flutterTts.setPauseHandler(() {
//       setState(() {
//         log("Paused");
//         ttsState = TtsState.paused;
//       });
//     });

//     flutterTts.setContinueHandler(() {
//       setState(() {
//         log("Continued");
//         ttsState = TtsState.continued;
//       });
//     });

//     flutterTts.setErrorHandler((msg) {
//       setState(() {
//         log("error: $msg");
//         ttsState = TtsState.stopped;
//       });
//     });
//   }

//   Future _getDefaultEngine() async {
//     var engine = await flutterTts.getDefaultEngine;
//     if (engine != null) {
//       log(engine);
//     }
//   }

//   Future _getDefaultVoice() async {
//     var voice = await flutterTts.getDefaultVoice;
//     if (voice != null) {
//       log(voice);
//     }
//   }

//   Word? _newWord;
//   Future _speak() async {
//     await flutterTts.setVolume(volume);
//     await flutterTts.setSpeechRate(rate);
//     await flutterTts.setPitch(pitch);

//     if (_newWord != null) {
//       flutterTts.setLanguage('ja-JP');
//       // if (_newJapaneseText!.isNotEmpty) {
//       await flutterTts.speak(_newWord!.yomikata);
//       // }
//       flutterTts.setLanguage('ko-KR');
//       await flutterTts.speak(_newWord!.mean);
//     }
//   }

//   Future _setAwaitOptions() async {
//     await flutterTts.awaitSpeakCompletion(true);
//   }

//   Future _stop() async {
//     var result = await flutterTts.stop();
//     if (result == 1) setState(() => ttsState = TtsState.stopped);
//   }

//   Future _pause() async {
//     var result = await flutterTts.pause();
//     if (result == 1) setState(() => ttsState = TtsState.paused);
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     flutterTts.stop();
//   }

//   int _currentPage = 0;

//   void onPageChange(int value) {
//     _currentPage = value;
//     setState(() {});
//   }

//   List<DropdownMenuItem<String>> getLanguageDropDownMenuItems(
//       dynamic languages) {
//     var items = <DropdownMenuItem<String>>[];
//     for (dynamic type in languages) {
//       items.add(DropdownMenuItem(
//           value: type as String?, child: Text(type as String)));
//     }
//     return items;
//   }

//   late PageController pageController;

//   goToPreviousPage() async {
//     if (_currentPage > 0) {
//       _currentPage--;
//       pageController.animateToPage(
//         _currentPage,
//         duration: const Duration(milliseconds: 350),
//         curve: Curves.easeIn,
//       );
//       // await manualPlaySound();
//     } else {
//       return;
//     }
//   }

//   goToNextPage() async {
//     if (_currentPage < words.length - 1) {
//       _currentPage++;
//       pageController.animateToPage(
//         _currentPage,
//         duration: const Duration(milliseconds: 350),
//         curve: Curves.easeIn,
//       );
//       //   await manualPlaySound();
//     } else {
//       return;
//     }
//   }

//   void startListenWords() async {
//     for (int i = _currentPage; i < words.length; i++) {
//       // if (!isAutoPlay) break;
//       _newWord = words[_currentPage];

//       await _speak();

//       if (_currentPage < words.length) {
//         _currentPage++;
//       } else {
//         _currentPage = 0;
//       }

//       // onPageChange(_currentPage);
//       if (pageController.hasClients) {
//         pageController.animateToPage(
//           _currentPage,
//           duration: const Duration(milliseconds: 350),
//           curve: Curves.easeIn,
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: TextButton(
//           child: Text(
//             "AUTO PLAY",
//             style: TextStyle(color: Colors.white),
//           ),
//           onPressed: () {
//             print('object');
//             startListenWords();
//           },
//         ),
//       ),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Spacer(),
//             Expanded(
//               child: Row(
//                 children: [
//                   TextButton(
//                       onPressed: ttsState == TtsState.playing
//                           ? null
//                           : () => goToPreviousPage(),
//                       child: Text('<')),
//                   Expanded(
//                     flex: 10,
//                     child: PageView.builder(
//                       onPageChanged: onPageChange,
//                       controller: pageController,
//                       itemCount: words.length,
//                       itemBuilder: (context, index) {
//                         _newWord = words[_currentPage];

//                         return Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Text(words[index].yomikata,
//                                 style: const TextStyle(
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.w700,
//                                     color: Colors.white)),
//                             Text(
//                               words[index].word,
//                               style: Theme.of(context)
//                                   .textTheme
//                                   .headline3
//                                   ?.copyWith(
//                                     fontSize: 30,
//                                     color: Colors.white,
//                                   ),
//                               textAlign: TextAlign.center,
//                             ),
//                             const SizedBox(height: 15),
//                             Text(
//                               words[index].mean,
//                               style: const TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.w700,
//                                   color: Colors.white),
//                             ),
//                           ],
//                         );
//                       },
//                     ),
//                   ),
//                   TextButton(
//                       onPressed: ttsState == TtsState.playing
//                           ? null
//                           : () => goToNextPage(),
//                       child: Text('>')),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),
//             _btnSection(),
//             // _engineSection(),
//             // _futureBuilder(),
//             _buildSliders(),
//             if (isAndroid) _getMaxSpeechInputLengthSection(),
//             Spacer(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _btnSection() {
//     return Container(
//       padding: const EdgeInsets.only(top: 50.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           _buildButtonColumn(
//               Colors.red, Colors.redAccent, Icons.stop, 'STOP', _stop),
//           _buildButtonColumn(Colors.green, Colors.greenAccent, Icons.play_arrow,
//               'PLAY', _speak),
//           _buildButtonColumn(
//               Colors.blue, Colors.blueAccent, Icons.pause, 'PAUSE', _pause),
//         ],
//       ),
//     );
//   }

//   Column _buildButtonColumn(Color color, Color splashColor, IconData icon,
//       String label, Function func) {
//     return Column(
//         mainAxisSize: MainAxisSize.min,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           IconButton(
//               icon: Icon(icon),
//               color: color,
//               splashColor: splashColor,
//               onPressed: () => func()),
//           Container(
//             margin: const EdgeInsets.only(top: 8.0),
//             child: Text(
//               label,
//               style: TextStyle(
//                   fontSize: 12.0, fontWeight: FontWeight.w400, color: color),
//             ),
//           )
//         ]);
//   }

//   Widget _getMaxSpeechInputLengthSection() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: [
//         ElevatedButton(
//           child: Text('Get max speech input length'),
//           onPressed: () async {
//             _inputLength = await flutterTts.getMaxSpeechInputLength;
//             setState(() {});
//           },
//         ),
//         Text("$_inputLength characters"),
//       ],
//     );
//   }

//   Widget _buildSliders() {
//     return Column(
//       children: [_volume(), _pitch(), _rate()],
//     );
//   }

//   Widget _volume() {
//     return Slider(
//         value: volume,
//         onChanged: (newVolume) {
//           setState(() => volume = newVolume);
//         },
//         min: 0.0,
//         max: 1.0,
//         divisions: 10,
//         label: "Volume: $volume");
//   }

//   Widget _pitch() {
//     return Slider(
//       value: pitch,
//       onChanged: (newPitch) {
//         setState(() => pitch = newPitch);
//       },
//       min: 0.5,
//       max: 2.0,
//       divisions: 15,
//       label: "Pitch: $pitch",
//       activeColor: Colors.red,
//     );
//   }

//   Widget _rate() {
//     return Slider(
//       value: rate,
//       onChanged: (newRate) {
//         setState(() => rate = newRate);
//       },
//       min: 0.0,
//       max: 1.0,
//       divisions: 10,
//       label: "Rate: $rate",
//       activeColor: Colors.green,
//     );
//   }
// }
