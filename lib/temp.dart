import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:in_app_review/in_app_review.dart';

class TempHome extends StatefulWidget {
  const TempHome({super.key});

  @override
  State<TempHome> createState() => _TempHomeState();
}

class _TempHomeState extends State<TempHome> {
  @override
  Widget build(BuildContext context) {
    AppReviewManager.created();
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Template'),
            ],
          ),
        ),
      ),
    );
  }
}

class AppReviewManager {
  static final InAppReview _inAppReview = InAppReview.instance;
  static const String _reviewedBox = 'reviewed';
  static const String _reviewedKey = 'reviewedKey';
  static const String _launchCountKey = 'launchCountKey';
  static const int _launchCountThreshold = 10;
  static int _launchCount = 0;

  final list = Hive.box(_reviewedBox);

  static created() async {
    if (!Hive.isBoxOpen(_reviewedBox)) {
      await Hive.openBox(_reviewedBox);
    }
    final list = Hive.box(_reviewedBox);
    final bool reviewed = list.get(_reviewedKey, defaultValue: false);
    print('reviewed : ${reviewed}');

    _launchCount = list.get(_launchCountKey, defaultValue: 0);
    print('_launchCount : ${_launchCount}');
    print('_launchCountThreshold : ${_launchCountThreshold}');

    if (!reviewed) {
      _launchCount++;

      list.put(_launchCountKey, _launchCount);

      // if (_launchCount >= _launchCountThreshold) {
      _showReviewRequest();
      // }
    }
  }

  static Future<void> _showReviewRequest() async {
    if (await _inAppReview.isAvailable()) {
      _inAppReview.requestReview();
      if (!Hive.isBoxOpen(_reviewedBox)) {
        await Hive.openBox(_reviewedBox);
      }

      final list = Hive.box(_reviewedBox);
      list.put(_reviewedKey, true);
    }
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final InAppReview _inAppReview = InAppReview.instance;
  static const String _reviewedBox = 'reviewed';
  static const String _reviewedKey = 'reviewedKey';
  static const String _launchCountKey = 'launchCountKey';
  static const int _launchCountThreshold = 5;
  int _launchCount = 0;

  @override
  void initState() {
    super.initState();
    _checkReviewStatus();
  }

  Future<void> _checkReviewStatus() async {
    if (!Hive.isBoxOpen(_reviewedBox)) {
      await Hive.openBox(_reviewedBox);
    }

    final list = Hive.box(_reviewedBox);
    final bool reviewed = list.get(_reviewedKey, defaultValue: false);
    print('reviewed : ${reviewed}');

    _launchCount = list.get(_launchCountKey, defaultValue: 0);
    print('_launchCount : ${_launchCount}');

    if (!reviewed) {
      _launchCount++;

      list.put(_launchCountKey, _launchCount);

      if (_launchCount >= _launchCountThreshold) {
        _showReviewRequest();
      }
    }
  }

  Future<void> _showReviewRequest() async {
    if (await _inAppReview.isAvailable()) {
      _inAppReview.requestReview();
      if (!Hive.isBoxOpen(_reviewedBox)) {
        await Hive.openBox(_reviewedBox);
      }

      final list = Hive.box(_reviewedBox);
      list.put(_reviewedKey, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Demo Home Page'),
      ),
      body: Center(
        child: Text(
          'Launch count: $_launchCount',
        ),
      ),
    );
  }
}
