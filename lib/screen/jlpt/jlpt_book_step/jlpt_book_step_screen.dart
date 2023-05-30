import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:japanese_voca/ad_controller.dart';
import 'package:japanese_voca/ad_unit_id.dart';
import 'package:japanese_voca/common/widget/banner_parent.dart';
import 'package:japanese_voca/common/widget/book_card.dart';
import 'package:japanese_voca/common/widget/heart_count.dart';
import 'package:japanese_voca/controller/jlpt_word_controller.dart';
import 'package:japanese_voca/controller/kangi_controller.dart';
import 'package:japanese_voca/controller/user_controller.dart';
import 'package:japanese_voca/screen/jlpt/jlpt_calendar_step/jlpt_calendar_step_sceen.dart';

final String BOOK_STEP_PATH = '/book-step';

// ignore: must_be_immutable
class JlptBookStepScreen extends StatefulWidget {
  late JlptWordController jlptWordController;
  late KangiController kangiController;
  final String level;
  final bool isJlpt;

  JlptBookStepScreen({super.key, required this.level, required this.isJlpt}) {
    if (isJlpt) {
      jlptWordController = Get.put(JlptWordController(level: level));
    } else {
      kangiController = Get.put(KangiController(hangul: level));
    }
  }

  @override
  State<JlptBookStepScreen> createState() => _JlptBookStepScreenState();
}

class _JlptBookStepScreenState extends State<JlptBookStepScreen> {
  // AdController adController = Get.find<AdController>();
  NativeAd? _nativeAd;
  bool _nativeAdIsLoaded = false;
  AdUnitId adUnitId = AdUnitId();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _nativeAd = NativeAd(
      adUnitId: adUnitId.nativeAdvanced[GetPlatform.isIOS ? 'ios' : 'android']!,
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (Ad ad) {
          print('$NativeAd loaded.');
          _nativeAdIsLoaded = true;
          setState(() {});
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$NativeAd failedToLoad: $error');
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('$NativeAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$NativeAd onAdClosed.'),
      ),
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.medium,
        mainBackgroundColor: Colors.white12,
        callToActionTextStyle: NativeTemplateTextStyle(
          size: 16.0,
        ),
        primaryTextStyle: NativeTemplateTextStyle(
          textColor: Colors.black38,
          backgroundColor: Colors.white70,
        ),
      ),
    )..load();
    // adController.createNativeAd();
  }

  void goTo(int index, String chapter) {
    if (widget.isJlpt) {
      Get.toNamed(
        JLPT_CALENDAR_STEP_PATH,
        arguments: {'chapter': chapter, 'isJlpt': widget.isJlpt},
      );
    } else {
      Get.toNamed(
        JLPT_CALENDAR_STEP_PATH,
        arguments: {'chapter': chapter, 'isJlpt': widget.isJlpt},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find<UserController>();

    if (!widget.isJlpt) {
      print(
          'widget.kangiController.headTitleCount: ${widget.kangiController.headTitleCount}');
      int bookCount = widget.kangiController.headTitleCount;
      return Scaffold(
        appBar: AppBar(
          leading: const BackButton(
            color: Colors.white,
          ),
          title: Text('${widget.level} - 단어'),
          actions: const [HeartCount()],
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                widget.kangiController.headTitleCount,
                (index) {
                  String chapter = '${widget.level}-${index + 1}';
                  if (index != 0 && index % 4 == 0) {
                    return Column(
                      children: [
                        FadeInLeft(
                          delay: Duration(milliseconds: 200 * index),
                          child: BookCard(
                            level: chapter,
                            onTap: () => goTo(index, chapter),
                          ),
                        ),
                        if (GetPlatform.isWindows ||
                            _nativeAd != null && _nativeAdIsLoaded)
                          Align(
                            alignment: Alignment.center,
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(
                                minWidth: 300,
                                minHeight: 350,
                                maxHeight: 400,
                                maxWidth: 450,
                              ),
                              child: _nativeAd == null
                                  ? AdWidget(ad: _nativeAd!)
                                  : Container(
                                      color: Colors.red,
                                    ),
                            ),
                          ),
                      ],
                    );
                  }
                  return FadeInLeft(
                    delay: Duration(milliseconds: 200 * index),
                    child: BookCard(
                      level: chapter,
                      onTap: () => goTo(index, chapter),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      );
    }
    print(
        'widget.jlptWordController.headTitleCount: ${widget.jlptWordController.headTitleCount}');

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        title: Text('N${widget.level} 단어'),
        actions: const [HeartCount()],
      ),
      floatingActionButton: FloatingActionButton.small(onPressed: () {
        userController.useHeart();
      }),
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.jlptWordController.headTitleCount,
              (index) {
                String chapter = '챕터${index + 1}';
                return FadeInLeft(
                  delay: Duration(milliseconds: 200 * index),
                  child: BookCard(
                      level: chapter, onTap: () => goTo(index, chapter)),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
