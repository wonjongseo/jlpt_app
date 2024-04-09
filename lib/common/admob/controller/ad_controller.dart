import 'dart:developer';
import 'dart:math' as Math;
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:japanese_voca/common/admob/ad_unit_id.dart';
import 'package:japanese_voca/common/app_constant.dart';
import 'package:japanese_voca/user/controller/user_controller.dart';

const int maxFailedLoadAttempts = 3;

enum KIND_OF_AD { JLPT, GRAMMAR, KANGI }

class AdController extends GetxController {
  InterstitialAd? _interstitialAd;
  RewardedInterstitialAd? rewardedInterstitialAd;
  int _numRewardedInterstitialLoadAttempts = 0;
  RewardedAd? rewardedAd;
  UserController userController = Get.find<UserController>();
  AdUnitId adUnitId = AdUnitId();

  AppOpenAd? appOpenAd;

  bool get isAdAvailable {
    return appOpenAd != null;
  }

  @override
  void onInit() {
    super.onInit();
    // if (!userController.user.isPremieum) {
    // createInterstitialAd();
    createRewardedInterstitialAd();
    // createRewardedAd();
    // }
  }

  Math.Random random = Math.Random();

  bool randomlyPassAd() {
    int randomNumber = random.nextInt(AppConstant.PROBABILITY_PASS_AD);

    return randomNumber == 0;
  }

  Future<void> createInterstitialAd(KIND_OF_AD kindOfAd) async {
    String stringAdUnitId = '';

    switch (kindOfAd) {
      case KIND_OF_AD.JLPT:
        stringAdUnitId =
            adUnitId.jlptInterstitial[GetPlatform.isIOS ? 'ios' : 'android']!;
        break;
      case KIND_OF_AD.GRAMMAR:
        stringAdUnitId = adUnitId
            .grammarInterstitial[GetPlatform.isIOS ? 'ios' : 'android']!;
        break;
      case KIND_OF_AD.KANGI:
        stringAdUnitId =
            adUnitId.jlptInterstitial[GetPlatform.isIOS ? 'ios' : 'android']!;
        break;
    }

    await InterstitialAd.load(
      // adUnitId: adUnitId.interstitial[GetPlatform.isIOS ? 'ios' : 'android']!,
      adUnitId: stringAdUnitId,
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

  void showIntersistialAd(KIND_OF_AD kindOfAd) async {
    // if (userController.isUserPremieum()) {
    //   return;
    // }

    log('${kindOfAd.name} showIntersistialAd');

    await createInterstitialAd(kindOfAd);
    if (_interstitialAd == null) return;

    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (ad) => log('onAdShowedFullScreenContent'),
      onAdDismissedFullScreenContent: (ad) {
        log('onAdDismissedFullScreenContent');
        ad.dispose();
        createInterstitialAd(kindOfAd);
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        log('onAdFailedToShowFullScreenContent');

        ad.dispose();

        createInterstitialAd(kindOfAd);
      },
    );

    _interstitialAd!.show();
    _interstitialAd = null;
  }

  void createRewardedInterstitialAd() {
    // if (userController.user.isPremieum) {
    //   return;
    // }
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

  // void createRewardedAd() {
  //   if (userController.user.isPremieum) {
  //     return;
  //   }
  //   log('createRewardedAd');
  //   RewardedAd.load(
  //       adUnitId: adUnitId.rewarded[GetPlatform.isIOS ? 'ios' : 'android']!,
  //       request: const AdRequest(),
  //       rewardedAdLoadCallback: RewardedAdLoadCallback(
  //         onAdLoaded: (RewardedAd ad) {
  //           log('$ad loaded.');
  //           rewardedAd = ad;
  //           _numRewardedLoadAttempts = 0;
  //         },
  //         onAdFailedToLoad: (LoadAdError error) {
  //           log('RewardedAd failed to load: $error');
  //           rewardedAd = null;
  //           _numRewardedLoadAttempts += 1;
  //           if (_numRewardedLoadAttempts < maxFailedLoadAttempts) {
  //             createRewardedAd();
  //           }
  //         },
  //       ));
  // }

  // void showRewardedAd() {
  //   if (userController.user.isPremieum) {
  //     return;
  //   }
  //   log('showRewardedAd');
  //   if (rewardedAd == null) {
  //     log('Warning: attempt to show rewarded before loaded.');
  //     return;
  //   }
  //   rewardedAd!.fullScreenContentCallback = FullScreenContentCallback(
  //     onAdShowedFullScreenContent: (RewardedAd ad) =>
  //         log('ad onAdShowedFullScreenContent.'),
  //     onAdDismissedFullScreenContent: (RewardedAd ad) {
  //       log('$ad onAdDismissedFullScreenContent.');
  //       ad.dispose();
  //       createRewardedAd();
  //     },
  //     onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
  //       log('$ad onAdFailedToShowFullScreenContent: $error');
  //       ad.dispose();
  //       createRewardedAd();
  //     },
  //   );

  //   rewardedAd!.setImmersiveMode(true);
  //   rewardedAd!.show(onUserEarnedReward: (AdWithoutView ad, RewardItem reward) {
  //     log('$ad with reward $RewardItem(${reward.amount}, ${reward.type})');
  //   });
  //   rewardedAd = null;
  // }

  @override
  void onClose() {
    super.onClose();
    _interstitialAd?.dispose();
  }
}
