import 'package:hive/hive.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:japanese_voca/repository/local_repository.dart';

class AppReviewRequest {
  static final InAppReview _inAppReview = InAppReview.instance;
  static final appUsageCountBox = Hive.box<int>('usageCount');
  static final isReviewedBox = Hive.box<bool>('hasReviewed');

  static Future<void> checkReviewRequest() async {
    _inAppReview.isAvailable();
    // int usageCount = appUsageCountBox.get('usageCount', defaultValue: 0)! + 1;
    // appUsageCountBox.put('usageCount', usageCount);

    int usageCount = LocalReposotiry.aaa();
    // bool hasReviewed = isReviewedBox.get('hasReviewed', defaultValue: false)!;
    bool hasReviewed = LocalReposotiry.bbb();

    print('hasReviewed : ${hasReviewed}');

    if (!hasReviewed) {
      // 등비수열 (10, 30, 60, 100, ...)
      if (_shouldRequestReview(usageCount)) {
        await _requestReview();
      }
    }
  }

  static bool _shouldRequestReview(int count) {
    // 등비수열 조건
    int n = 1;
    while (true) {
      int geometricTerm =
          n * (n + 1) * 5; // 등비수열: 5 * n(n + 1) (10, 30, 60, 100, ...)
      if (count == geometricTerm) {
        return true;
      } else if (count < geometricTerm) {
        return false;
      }
      n++;
    }
  }

  static Future<void> _requestReview() async {
    if (await _inAppReview.isAvailable()) {
      await _inAppReview.requestReview();
      LocalReposotiry.ccc();
      // isReviewedBox.put('hasReviewed', true);
    }
  }
}
