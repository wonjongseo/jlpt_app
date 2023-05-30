import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:japanese_voca/ad_controller.dart';

const Map<String, String> UNIT_ID = kReleaseMode
    ? {
        'ios-banner': 'ca-app-pub-9712392194582442~6290044081',
        'android-banner': 'ca-app-pub-9712392194582442~5947338319',
      }
    : {
        'ios-banner': 'ca-app-pub-3940256099942544/2934735716',
        'android-banner': 'ca-app-pub-3940256099942544/6300978111',
      };

class AdMobScreen extends StatefulWidget {
  const AdMobScreen({super.key});

  @override
  State<AdMobScreen> createState() => _AdMobScreenState();
}

class _AdMobScreenState extends State<AdMobScreen> {
  AdController adUnitController = Get.put(AdController());
  @override
  void initState() {
    super.initState();
    adUnitController.createInterstitialAd();
    adUnitController.createBanner();
  }

  @override
  Widget build(BuildContext context) {
    if (!adUnitController.loadingBanner) {
      adUnitController.loadingBanner = true;
      adUnitController.createBanner();
    }
    return Scaffold(
      appBar: AppBar(title: Text('aa')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          adUnitController.showIntersistialAd();
        },
        child: Text('OPEN AD'),
      ),
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Container(),
          if (adUnitController.banner != null)
            Container(
              color: Colors.green,
              width: adUnitController.banner!.size.width.toDouble(),
              height: adUnitController.banner!.size.height.toDouble(),
              child: AdWidget(
                ad: adUnitController.banner!,
              ),
            ),
        ],
      ),
    );
  }
}
