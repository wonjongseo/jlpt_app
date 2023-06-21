import 'dart:developer';

import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:japanese_voca/common/admob/ad_unit_id.dart';

class BannerAdController extends GetxController {
  // HOME Banner
  BannerAd? homepageBanner;
  bool loadingHomepageBanner = false;

  AdUnitId adUnitId = AdUnitId();

  Future<void> createHomepageBanner() async {
    homepageBanner = BannerAd(
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          log('onHomeBannerAdLoaded');
          loadingHomepageBanner = true;
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          log('onHomeBannerFailedToLoad');
          ad.dispose();
        },
        onAdOpened: (ad) => log('onHomeBannerAdLoadedOpend'),
        onAdClosed: (ad) => log('onHomeBannerAdLoadedClosed'),
      ),
      size: AdSize.banner,
      adUnitId: adUnitId.banner[GetPlatform.isIOS ? 'ios' : 'android']!,
      request: const AdRequest(),
    )..load();
  }

  BannerAd? testBanner;
  bool loadingTestBanner = false;

  Future<void> createTestBanner() async {
    testBanner = BannerAd(
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          log('onTestAdLoaded');
          loadingTestBanner = true;
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          log('onTestAdFailedToLoad');
          ad.dispose();
        },
        onAdOpened: (ad) => log('onTestAdOpened'),
        onAdClosed: (ad) => log('onTestAdClosed'),
      ),
      size: AdSize.banner,
      adUnitId: adUnitId.banner[GetPlatform.isIOS ? 'ios' : 'android']!,
      request: const AdRequest(),
    )..load();
  }
}
