import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:japanese_voca/ad_unit_id.dart';

const int maxFailedLoadAttempts = 3;

class AdController extends GetxController {
  InterstitialAd? _interstitialAd;
  RewardedInterstitialAd? rewardedInterstitialAd;
  int _numRewardedInterstitialLoadAttempts = 0;
  RewardedAd? rewardedAd;
  AdUnitId adUnitId = AdUnitId();
  NativeAd? nativeAd;
  bool nativeAdIsLoaded = false;

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
    );
  }

  int _numRewardedLoadAttempts = 0;
  BannerAd? homepageBanner;
  bool loadingBanner = false;

  AppOpenAd? appOpenAd;

  bool _isShowingAd = false;

  void createAppLoadAd() {
    AppOpenAd.load(
        adUnitId: adUnitId.appOpen[GetPlatform.isIOS ? 'ios' : 'android']!,
        request: const AdRequest(),
        adLoadCallback: AppOpenAdLoadCallback(
          onAdLoaded: (ad) {
            log('onAdLoaded');
          },
          onAdFailedToLoad: (error) {
            log('onAdFailedToLoad');
          },
        ),
        orientation: AppOpenAd.orientationPortrait);
  }

  bool get isAdAvailable {
    return appOpenAd != null;
  }

  void showAdIfAvailable() {
    if (GetPlatform.isWindows) {
      temp();
    }
    log('showAdIfAvailable');
    if (!isAdAvailable) {
      log('Tried to show ad before available.');
      createAppLoadAd();
      return;
    }
    if (_isShowingAd) {
      log('Tried to show ad while already showing an ad.');
      return;
    }
    // Set the fullScreenContentCallback and show the ad.
    appOpenAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) {
        _isShowingAd = true;
        log('$ad onAdShowedFullScreenContent');
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        log('$ad onAdFailedToShowFullScreenContent: $error');
        _isShowingAd = false;
        ad.dispose();
        appOpenAd = null;
      },
      onAdDismissedFullScreenContent: (ad) {
        log('$ad onAdDismissedFullScreenContent');
        _isShowingAd = false;
        ad.dispose();
        appOpenAd = null;
        createAppLoadAd();
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
    // if (!loadingBanner) {
    //   loadingBanner = true;
    //   createHomepageBanner();
    // }
    // createNativeAd();
    // createInterstitialAd();
    // createRewardedInterstitialAd();
    // createRewardedAd();
  }

  void createInterstitialAd() {
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
    if (GetPlatform.isWindows) {
      temp();
    }
    log('showIntersistialAd');
    if (_interstitialAd == null) return;

    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) => log('onAdShowedFullScreenContent'),
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

  Future<void> createHomepageBanner() async {
    BannerAd tempBanner = BannerAd(
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          log('onAdLoaded');
          homepageBanner = ad as BannerAd?;
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

  void createRewardedInterstitialAd() {
    log('createRewardedInterstitialAd');
    RewardedInterstitialAd.load(
        adUnitId: adUnitId
            .rewardedInterstitial[GetPlatform.isIOS ? 'ios' : 'android']!,
        request: const AdRequest(),
        rewardedInterstitialAdLoadCallback: RewardedInterstitialAdLoadCallback(
          onAdLoaded: (RewardedInterstitialAd ad) {
            log('$ad loaded.');
            rewardedInterstitialAd = ad;
            _numRewardedInterstitialLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            log('RewardedInterstitialAd failed to load: $error');
            rewardedInterstitialAd = null;
            _numRewardedInterstitialLoadAttempts += 1;
            if (_numRewardedInterstitialLoadAttempts < maxFailedLoadAttempts) {
              createRewardedInterstitialAd();
            }
          },
        ));
  }

  void showRewardedInterstitialAd() {
    if (GetPlatform.isWindows) {
      temp();
    }
    log('showRewardedInterstitialAd');
    if (rewardedInterstitialAd == null) {
      log('Warning: attempt to show rewarded interstitial before loaded.');
      return;
    }
    rewardedInterstitialAd!.fullScreenContentCallback =
        FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedInterstitialAd ad) =>
          log('$ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedInterstitialAd ad) {
        log('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        createRewardedInterstitialAd();
      },
      onAdFailedToShowFullScreenContent:
          (RewardedInterstitialAd ad, AdError error) {
        log('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createRewardedInterstitialAd();
      },
    );

    rewardedInterstitialAd!.setImmersiveMode(true);
    rewardedInterstitialAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      log('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
    });
    rewardedInterstitialAd = null;
  }

  void createRewardedAd() {
    log('createRewardedAd');
    RewardedAd.load(
        adUnitId: adUnitId.rewarded[GetPlatform.isIOS ? 'ios' : 'android']!,
        request: const AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            log('$ad loaded.');
            rewardedAd = ad;
            _numRewardedLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            log('RewardedAd failed to load: $error');
            rewardedAd = null;
            _numRewardedLoadAttempts += 1;
            if (_numRewardedLoadAttempts < maxFailedLoadAttempts) {
              createRewardedAd();
            }
          },
        ));
  }

  void showRewardedAd() {
    if (GetPlatform.isWindows) {
      temp();
    }
    log('showRewardedAd');
    if (rewardedAd == null) {
      log('Warning: attempt to show rewarded before loaded.');
      return;
    }
    rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          log('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        log('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        log('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        createRewardedAd();
      },
    );

    rewardedAd!.setImmersiveMode(true);
    rewardedAd!.show(onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
      log('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
    });
    rewardedAd = null;
  }

  @override
  void onClose() {
    super.onClose();
    homepageBanner?.dispose();
    _interstitialAd?.dispose();
    nativeAd?.dispose();
  }

  void temp() {
    Get.dialog(AlertDialog(
      title: Text('ADVERTSISEMENT'),
    ));
  }
}
