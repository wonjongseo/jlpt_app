import 'dart:math';
import 'package:japanese_voca/common/admob/banner_ad/global_banner_admob.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/size.dart';
import 'package:japanese_voca/features/jlpt_test/screens/jlpt_test_screen.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/features/home/screens/home_screen.dart';
import 'package:japanese_voca/features/jlpt_and_kangi/jlpt/controller/jlpt_step_controller.dart';
import 'package:japanese_voca/features/jlpt_study/widgets/word_card.dart';
import 'package:japanese_voca/model/jlpt_step.dart';
import 'package:japanese_voca/model/word.dart';

class NotificaionScreen extends StatefulWidget {
  const NotificaionScreen({
    super.key,
  });
  @override
  State<NotificaionScreen> createState() => _NotificaionScreenState();
}

class _NotificaionScreenState extends State<NotificaionScreen> {
  late List<Word> words;

  late PageController pageController;
  int _currentPageIndex = 0;
  List<Word> generateWord() {
    Random random = Random();

    int randomLevel = random.nextInt(4) + 1;

    JlptStepController jlptStepController =
        Get.put(JlptStepController(level: '$randomLevel'));
    List<Word> words = [];
    for (int i = 0; i < 15; i++) {
      int randomHeaderIndex =
          random.nextInt(jlptStepController.headTitleCount) + 1;

      jlptStepController.setJlptSteps('챕터$randomHeaderIndex');

      int stepCount = jlptStepController.jlptSteps.length;

      int randomStepIndex = random.nextInt(stepCount);

      jlptStepController.setStep(randomStepIndex);
      JlptStep jlptStep = jlptStepController.getJlptStep();
      int wordCount = jlptStep.words.length;

      int randomWordIndex = random.nextInt(wordCount);

      Word word = jlptStep.words[randomWordIndex];
      words.add(word);
    }
    return words;
  }

  @override
  void initState() {
    super.initState();
    words = generateWord();
    pageController = PageController(initialPage: _currentPageIndex);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int len = words.length;
    return Scaffold(
      appBar: AppBar(
        title: RichText(
          text: TextSpan(
            style: TextStyle(color: Colors.black, fontSize: appBarTextSize),
            children: [
              const TextSpan(text: '오늘의 단어장 '),
              if (_currentPageIndex != len) ...[
                TextSpan(
                  text: '${_currentPageIndex + 1}',
                  style: TextStyle(
                    color: Colors.cyan.shade500,
                    fontSize: Responsive.height10 * 2.5,
                  ),
                ),
                const TextSpan(text: ' / '),
                TextSpan(text: '${words.length}')
              ]
            ],
          ),
        ),
        leading: BackButton(
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: Center(
            child: PageView.builder(
          controller: pageController,
          onPageChanged: onPageChanged,
          itemCount: len + 1,
          itemBuilder: (context, index) {
            if (index == len) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
                child: InkWell(
                  onTap: () {
                    Get.offAndToNamed(
                      JLPT_TEST_PATH,
                      arguments: {JLPT_TEST: words},
                    );
                  },
                  child: Card(
                    child: Center(
                      child: Text(
                        '퀴즈 풀러 가기!',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.cyan.shade600,
                            fontSize: Responsive.height10 * 2.4),
                      ),
                    ),
                  ),
                ),
              );
              /**
          
               */
            }
            return WordCard(word: words[index]);
          },
        )),
      ),
      bottomNavigationBar: const GlobalBannerAdmob(),
    );
  }

  void onPageChanged(value) {
    _currentPageIndex = value;
    setState(() {});
  }
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

class FlutterLocalNotification {
  FlutterLocalNotification._();

  static Word? word;
  static init() async {
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('mipmap/ic_launcher');

    DarwinInitializationSettings iosInitializationSettings =
        const DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );
  }

  static requestNotificationPermission() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  static Future<void> showNotificationImi() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      'channel id',
      'channel name',
      channelDescription: 'channel description',
      importance: Importance.max,
      priority: Priority.max,
      showWhen: false,
    );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: DarwinNotificationDetails(badgeNumber: 0),
    );

    print('showNotification');
    print('payload : ${payload}');

    await flutterLocalNotificationsPlugin.periodicallyShow(
      0,
      '일본어를 공부할 시간이에요!',
      '오늘의 단어 공부하러 가기',
      RepeatInterval.everyMinute,
      notificationDetails,
      payload: payload,
    );
  }

  static Future<void> showNotification() async {
    final tz.TZDateTime now =
        tz.TZDateTime.now(tz.local).add(const Duration(minutes: 1));

    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 12);

    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channel id', 'channel name',
            channelDescription: 'channel description',
            importance: Importance.max,
            priority: Priority.max,
            showWhen: false);

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: DarwinNotificationDetails(badgeNumber: 1),
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      '일본어를 공부할 시간이에요!',
      '오늘의 단어 공부하러 가기',
      scheduledDate,
      notificationDetails,
      // ignore: deprecated_member_use
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
      payload: payload,
    );
  }

  static String payload = 'HELLOWOLRD';

  static tz.TZDateTime _nextInstanceOf8AM() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
// https://velog.io/@tygerhwang/Flutter-Local-Notifications-%EC%82%AC%EC%9A%A9%ED%95%B4-%EB%B3%B4%EA%B8%B0#:~:text=%EC%82%AC%EC%9A%A9%EC%9E%90%EC%97%90%EA%B2%8C%20%EB%A7%A4%EC%9D%BC%20%EC%98%A4%EC%A0%84%209,%EC%9D%84%20%EC%A0%84%EC%86%A1%ED%95%A0%20%ED%95%84%EC%9A%94%EA%B0%80%20%EC%97%86%EB%8B%A4.
    payload = word!.toJson();
    print('payload : ${payload}');
    print('CALLED ');
    print(word!.word);
    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, 11);
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(seconds: 3));
    }
    print('scheduledDate : ${scheduledDate}');

    return scheduledDate;
  }
  //! Foreground 상태(앱이 열린 상태에서 받은 경우)

  static void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    //! Payload(전송 데이터)를 Stream에 추가합니다.

    final String payload = notificationResponse.payload ?? "";

    if (notificationResponse.payload != null ||
        notificationResponse.payload!.isNotEmpty) {
      print('FOREGROUND PAYLOAD: $payload');

      streamController.add(payload);
    }
  }

  //! Background 상태(앱이 닫힌 상태에서 받은 경우)

  static void onBackgroundNotificationResponse() async {
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    //! 앱이 Notification을 통해서 열린 경우라면 Payload(전송 데이터)를 Stream에 추가합니다.

    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      String payload =
          notificationAppLaunchDetails!.notificationResponse?.payload ?? "";

      print("BACKGROUND PAYLOAD: $payload");

      streamController.add(payload);
    }
  }
}
