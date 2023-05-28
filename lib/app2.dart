import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'admob_screen.dart';

class App2 extends StatefulWidget {
  const App2({super.key});

  @override
  State<App2> createState() => _App2State();
}

class _App2State extends State<App2> {
  BannerAd? _banner;
  bool _loadingBanner = false;

  Future<void> _createBanner(BuildContext context) async {
    TargetPlatform os = Theme.of(context).platform;

    final AnchoredAdaptiveBannerAdSize? size =
        await AdSize.getAnchoredAdaptiveBannerAdSize(
      Orientation.portrait,
      MediaQuery.of(context).size.width.truncate(),
    );

    if (size == null) {
      return;
    }

    BannerAd banner = BannerAd(
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          print('onAdLoaded');
          setState(() {
            _banner = ad as BannerAd?;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('onAdFailedToLoad');
          ad.dispose();
        },
        onAdOpened: (ad) => print('onAdOpened'),
        onAdClosed: (ad) => print('onAdClosed'),
      ),
      size: AdSize.banner,
      adUnitId: UNIT_ID[os == TargetPlatform.iOS ? 'ios' : 'android']!,
      request: AdRequest(),
    );
    return banner.load();
  }

  @override
  void dispose() {
    super.dispose();
    _banner?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_loadingBanner) {
      _loadingBanner = true;
      _createBanner(context);
    }

    return GetMaterialApp(
      home: AdMobScreen(),
      // home: Scaffold(
      //   appBar: AppBar(
      //     title: Text('MEMO APP'),
      //   ),
      //   body: Stack(
      //     alignment: AlignmentDirectional.bottomCenter,
      //     children: [
      //       Container(),
      //       if (_banner != null)
      //         Container(
      //           color: Colors.green,
      //           width: _banner!.size.width.toDouble(),
      //           height: _banner!.size.height.toDouble(),
      //           child: AdWidget(
      //             ad: _banner!,
      //           ),
      //         ),
      //     ],
      //   ),
      // ),
    );
  }
}
