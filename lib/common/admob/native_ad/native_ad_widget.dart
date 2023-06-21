import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/platform/platform.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:japanese_voca/common/widget/book_card.dart';

import '../../../config/colors.dart';
import '../ad_unit_id.dart';

class NativeAdWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => NativeAdState();
}

class NativeAdState extends State<NativeAdWidget> {
  NativeAd? _nativeAd;
  final Completer<NativeAd> nativeAdCompleter = Completer<NativeAd>();
  AdUnitId adUnitId = AdUnitId();

  @override
  void initState() {
    super.initState();
    _nativeAd = NativeAd(
      adUnitId: adUnitId.nativeAdvanced[GetPlatform.isIOS ? 'ios' : 'android']!,
      request: const AdRequest(nonPersonalizedAds: true),
      customOptions: <String, Object>{},
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.medium,
        mainBackgroundColor: Colors.white12,
        callToActionTextStyle: NativeTemplateTextStyle(
          size: 16.0,
        ),
        primaryTextStyle: NativeTemplateTextStyle(
          textColor: AppColors.scaffoldBackground,
          backgroundColor: Colors.white70,
        ),
      ),
      listener: NativeAdListener(
        onAdLoaded: (Ad ad) {
          nativeAdCompleter.complete(ad as NativeAd);
        },
        onAdFailedToLoad: (Ad ad, LoadAdError err) {
          ad.dispose();
          nativeAdCompleter.completeError('Err');
        },
        onAdOpened: (Ad ad) => print('$ad onAdOpened.'),
        onAdClosed: (Ad ad) => print('$ad onAdClosed.'),
      ),
    );

    _nativeAd?.load();
  }

  @override
  void dispose() {
    super.dispose();
    _nativeAd?.dispose();
    _nativeAd = null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NativeAd>(
      future: nativeAdCompleter.future,
      builder: (BuildContext context, AsyncSnapshot<NativeAd> snapshot) {
        Widget child;

        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            child = BookCard(level: '', onTap: () {});
            break;
          case ConnectionState.done:
            if (snapshot.hasData) {
              child = AdWidget(ad: _nativeAd!);
            } else {
              child = Text('Error loading ad');
            }
        }
        // return child != null ?  Container(
        //   height: 330,
        //   child: child,
        //   color: const Color(0xFFFFFFFF),
        // ) : BookCard(level: '', onTap: () {}) ;
        return Container(
          height: 330,
          child: child,
          color: const Color(0xFFFFFFFF),
        );
      },
    );
  }
}
