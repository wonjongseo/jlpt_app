import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:japanese_voca/common/admob/ad_unit_id.dart';

int NATVICE_AD_COUNT_PER_CONTENT_COUNT = 5;

class NativeAdController extends GetxController {
  // NativeAdController({required this.totalContentSize}) {
  //   for (int i = 0;
  //       i < totalContentSize / NATVICE_AD_COUNT_PER_CONTENT_COUNT;
  //       i++) {
  //     nativeAdIsLoadeds.add(false);
  //   }
  // }

  // List<NativeAd?> nativeAds = [];
  // List<bool> nativeAdIsLoadeds = [];
  // bool isCompleted = false;
  // AdUnitId adUnitId = AdUnitId();
  // int currentIndex = 0;
  // int currentIndex2 = 0;

  // NativeAd? getNativeAd() {
  //   int index = currentIndex;
  //   currentIndex++;

  //   NativeAd? a = nativeAds[index];
  //   a!.load();
  //   return a;
  // }

  // bool getNativeAdIsLoaded() {
  //   int index = currentIndex2;
  //   currentIndex2++;

  //   return nativeAdIsLoadeds[index];
  // }

  // final int totalContentSize;

  // void createNativeAd() {
  //   log('nativeAdvanced');

  //   for (int i = 0;
  //       i < totalContentSize / NATVICE_AD_COUNT_PER_CONTENT_COUNT;
  //       i++) {
  //     NativeAd temp = NativeAd(
  //       adUnitId:
  //           adUnitId.nativeAdvanced[GetPlatform.isIOS ? 'ios' : 'android']!,
  //       request: const AdRequest(),
  //       listener: NativeAdListener(
  //         onAdLoaded: (Ad ad) {
  //           log('${i + 1} $NativeAd loaded. ');
  //           nativeAdIsLoadeds[i] = true;
  //         },
  //         onAdFailedToLoad: (Ad ad, LoadAdError error) {
  //           log('$NativeAd failedToLoad: $error');
  //           ad.dispose();
  //         },
  //         onAdOpened: (Ad ad) => log('$NativeAd onAdOpened.'),
  //         onAdClosed: (Ad ad) => log('$NativeAd onAdClosed.'),
  //       ),
  //       nativeTemplateStyle: NativeTemplateStyle(
  //         templateType: TemplateType.medium,
  //         mainBackgroundColor: Colors.white12,
  //         callToActionTextStyle: NativeTemplateTextStyle(
  //           size: 16.0,
  //         ),
  //         primaryTextStyle: NativeTemplateTextStyle(
  //           textColor: Colors.black38,
  //           backgroundColor: Colors.white70,
  //         ),
  //       ),
  //     );
  //     nativeAds.add(temp);
  //   }

  //   // for (int i = 0; i < nativeAds.length; i++) {
  //   //   nativeAds[i]!.load();
  //   // }
  //   isCompleted = true;
  // }

  // @override
  // void onClose() {
  //   super.onClose();

  //   for (int i = 0; i < nativeAds.length; i++) {
  //     nativeAds[i]!.dispose();
  //   }
  // }

  NativeAd? nativeAd;
  bool nativeAdIsLoaded = false;
  AdUnitId adUnitId = AdUnitId();

  void createNativeAd() {
    log('nativeAdvanced');
    nativeAd = NativeAd(
      adUnitId: adUnitId.nativeAdvanced[GetPlatform.isIOS ? 'ios' : 'android']!,
      request: const AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (Ad ad) {
          log('$NativeAd loaded.');
          nativeAdIsLoaded = true;
          update();
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          log('$NativeAd failedToLoad: $error');
          ad.dispose();
        },
        onAdOpened: (Ad ad) => log('$NativeAd onAdOpened.'),
        onAdClosed: (Ad ad) => log('$NativeAd onAdClosed.'),
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
  }
}
