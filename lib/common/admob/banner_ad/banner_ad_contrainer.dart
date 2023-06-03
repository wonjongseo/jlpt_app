import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BannerContainer extends StatelessWidget {
  const BannerContainer({super.key, this.bannerAd});
  final BannerAd? bannerAd;
  @override
  Widget build(BuildContext context) {
    return bannerAd != null
        ? SizedBox(
            width: bannerAd!.size.width.toDouble(),
            height: bannerAd!.size.height.toDouble(),
            child: AdWidget(
              ad: bannerAd!,
            ),
          )
        : Container(height: 0);
  }
}
