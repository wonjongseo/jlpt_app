import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:japanese_voca/ad_unit_id.dart';

class AdController extends GetxController {
  // AdUnitId adUnitId = AdUnitId();
  InterstitialAd? _interstitialAd;
  AdUnitId adUnitId = AdUnitId();
  void createInterstitialAd() {
    print('GetPlatform.isIOS : ${GetPlatform.isIOS}');
    // String adUnitId =

    InterstitialAd.load(
      adUnitId: adUnitId.interstitial[GetPlatform.isIOS ? 'ios' : 'android']!,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          log('onAdLoaded');
          _interstitialAd = ad;
        },
        onAdFailedToLoad: (error) {
          log('error: $error');
        },
      ),
    );
  }

  void showIntersistialAd() {
    if (_interstitialAd == null) return;

    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) => print('onAdShowedFullScreenContent'),
      onAdDismissedFullScreenContent: (ad) {
        log('onAdDismissedFullScreenContent');
        ad.dispose();
        createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        log('onAdFailedToShowFullScreenContent');

        ad.dispose();

        createInterstitialAd();
      },
    );

    _interstitialAd!.show();
    _interstitialAd = null;
  }

  BannerAd? banner;
  bool loadingBanner = false;

  Future<void> createBanner(BuildContext context) async {
    // final AnchoredAdaptiveBannerAdSize? size =
    //     await AdSize.getAnchoredAdaptiveBannerAdSize(
    //   Orientation.portrait,
    //   MediaQuery.of(context).size.width.truncate(),
    // );

    // if (size == null) {
    //   return;
    // }

    BannerAd tempBanner = BannerAd(
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          log('onAdLoaded');
          banner = ad as BannerAd?;
          update();
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          log('onAdFailedToLoad');
          ad.dispose();
        },
        onAdOpened: (ad) => log('onAdOpened'),
        onAdClosed: (ad) => log('onAdClosed'),
      ),
      size: AdSize.banner,
      adUnitId: adUnitId.banner[GetPlatform.isIOS ? 'ios' : 'android']!,
      request: const AdRequest(),
    );
    return tempBanner.load();
  }

  @override
  void onClose() {
    super.onClose();
    banner?.dispose();
    _interstitialAd?.dispose();
  }
}
