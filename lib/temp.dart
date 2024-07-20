// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
// import 'package:in_app_review/in_app_review.dart';

// class AppReviewRequest {
//   static final InAppReview _inAppReview = InAppReview.instance;
//   static Box<int> appUsageCountBox = Hive.box('appUsageCountBox');
//   static Box<bool> isReviewedBox = Hive.box('isReviewedBox');

//   static Future<void> checkReviewRequest() async {
//     _inAppReview.isAvailable();
//     int usageCount = appUsageCountBox.get('usageCount', defaultValue: 0)! + 1;
//     appUsageCountBox.put('usageCount', usageCount);

//     bool hasReviewed = isReviewedBox.get('hasReviewed', defaultValue: false)!;

//     if (!hasReviewed) {
//       // 등비수열 (10, 30, 60, 100, ...)
//       if (_shouldRequestReview(usageCount)) {
//         await _requestReview();
//       }
//     }
//   }

//   static bool _shouldRequestReview(int count) {
//     // 등비수열 조건
//     int n = 1;
//     while (true) {
//       int geometricTerm =
//           n * (n + 1) * 5; // 등비수열: 5 * n(n + 1) (10, 30, 60, 100, ...)
//       if (count == geometricTerm) {
//         return true;
//       } else if (count < geometricTerm) {
//         return false;
//       }
//       n++;
//     }
//   }

//   static Future<void> _requestReview() async {
//     if (await _inAppReview.isAvailable()) {
//       await _inAppReview.requestReview();
//       isReviewedBox.put('hasReviewed', true);
//     }
//   }
// }

// // class HomeScreen extends StatefulWidget {
// //   @override
// //   _HomeScreenState createState() => _HomeScreenState();
// // }

// // class _HomeScreenState extends State<HomeScreen> {
// //   final InAppReview _inAppReview = InAppReview.instance;
// //   late Box<int> appUsageCountBox;
// //   late Box<bool> isReviewedBox;

// //   @override
// //   void initState() {
// //     super.initState();
// //     appUsageCountBox = Hive.box<int>('appUsageCountBox');
// //     isReviewedBox = Hive.box<bool>('isReviewedBox');
// //     _checkReviewRequest();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Home Screen'),
// //       ),
// //       body: Center(
// //         child: Text('Welcome to the app!'),
// //       ),
// //     );
// //   }
// // }
