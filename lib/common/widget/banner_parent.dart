// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:japanese_voca/ad_controller.dart';

// class BannerContainer extends StatelessWidget {
//   BannerContainer({super.key, required this.child});

//   final AdController adController = Get.find<AdController>();
//   final Widget child;
//   @override
//   Widget build(BuildContext context) {
//     if (!adController.loadingBanner) {
//       print('adController.loadingBanner');
//       adController.loadingBanner = true;
//       adController.createBanner();
//     }
//     print('2');
//     return Column(
//       children: [
//         Expanded(child: child),
//         if (adController.banner != null)
//           SizedBox(
//             // color: Colors.green,
//             width: adController.banner!.size.width.toDouble(),
//             height: adController.banner!.size.height.toDouble(),
//             child: AdWidget(
//               ad: adController.banner!,
//             ),
//           ),
//       ],
//     );
//     // return GetBuilder<AdController>(builder: (controller) {

//     // });
//   }
// }
