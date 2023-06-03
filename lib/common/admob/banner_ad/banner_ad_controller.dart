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

  // CALENDAR Banner
  BannerAd? calendarBanner;
  bool loadingCalendartBanner = false;

  Future<void> createCalendarBanner() async {
    calendarBanner = BannerAd(
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          log('onCalendarAdLoaded');
          loadingCalendartBanner = true;
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          log('onCalendarAdFailedToLoad');
          ad.dispose();
        },
        onAdOpened: (ad) => log('onCalendarAdOpened'),
        onAdClosed: (ad) => log('onCalendarAdClosed'),
      ),
      size: AdSize.banner,
      adUnitId: adUnitId.banner[GetPlatform.isIOS ? 'ios' : 'android']!,
      request: const AdRequest(),
    )..load();
  }

  BannerAd? studyBanner;
  bool loadingStudyBanner = false;

  Future<void> createStudyBanner() async {
    studyBanner = BannerAd(
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          log('onStudyAdLoaded');
          loadingStudyBanner = true;
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          log('onStudyAdFailedToLoad');
          ad.dispose();
        },
        onAdOpened: (ad) => log('onStudyAdOpened'),
        onAdClosed: (ad) => log('onStudyAdClosed'),
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

  BannerAd? scoreBanner;
  bool loadingScoreBanner = false;

  Future<void> createScoreBanner() async {
    scoreBanner = BannerAd(
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          log('onTestAdLoaded');
          loadingScoreBanner = true;
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

  BannerAd? bookBanner;
  bool loadingBookBanner = false;

  Future<void> createBookBanner() async {
    bookBanner = BannerAd(
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          log('onTestAdLoaded');
          loadingBookBanner = true;
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

  BannerAd? settingBanner;
  bool loadingSettingBanner = false;

  Future<void> createSettingBanner() async {
    settingBanner = BannerAd(
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          log('onTestAdLoaded');
          loadingSettingBanner = true;
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
