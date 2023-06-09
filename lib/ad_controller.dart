import 'dart:developer';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:japanese_voca/common/admob/ad_unit_id.dart';
import 'package:japanese_voca/controller/user_controller.dart';

const int maxFailedLoadAttempts = 3;

class AdController extends GetxController {
  InterstitialAd? _interstitialAd;
  RewardedInterstitialAd? rewardedInterstitialAd;
  int _numRewardedInterstitialLoadAttempts = 0;
  RewardedAd? rewardedAd;
  UserController userController = Get.find<UserController>();
  AdUnitId adUnitId = AdUnitId();
  // UserController userController = Get.find<UserController>();

  int _numRewardedLoadAttempts = 0;

  AppOpenAd? appOpenAd;

  bool get isAdAvailable {
    return appOpenAd != null;
  }

  @override
  void onInit() {
    super.onInit();
    if (!userController.user.isPremieum) {
      createInterstitialAd();
      createRewardedInterstitialAd();
      createRewardedAd();
    }
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
    if (userController.user.isPremieum) {
      return;
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

  void createRewardedInterstitialAd() {
    if (userController.user.isPremieum) {
      return;
    }
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
    if (userController.user.isPremieum) {
      return;
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
      // userController.plusHeart(plusHeartCount: 2);
      log('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
    });
    rewardedInterstitialAd = null;
  }

  void createRewardedAd() {
    if (userController.user.isPremieum) {
      return;
    }
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
    if (userController.user.isPremieum) {
      return;
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
      // userController.plusHeart(plusHeartCount: 2);
      log('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
    });
    rewardedAd = null;
  }

  @override
  void onClose() {
    super.onClose();
    // homepageBanner?.dispose();
    _interstitialAd?.dispose();
    // nativeAd?.dispose();
  }
}
