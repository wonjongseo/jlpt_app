import 'package:flutter/material.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';

// N1~N5, My Word 등 카드
class LevelCategoryCard extends StatelessWidget {
  // Studying Card
  const LevelCategoryCard({
    super.key,
    required this.onTap,
    required this.title,
    this.body,
    this.foot,
    this.extraInfo,
    required this.titleSize,
  });
  final VoidCallback onTap;
  final String title;
  final Widget? body;
  final Widget? foot;
  final Widget? extraInfo;
  final double titleSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: Responsive.width15),
      child: InkWell(
        onTap: onTap,
        child: Card(
          child: Container(
            padding: const EdgeInsets.all(4),
            child: Padding(
              padding: EdgeInsets.only(
                top: Responsive.height16 / 2.0,
                bottom: Responsive.height16,
                right: Responsive.width24 / 2,
                left: Responsive.width24 / 2,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontFamily: "GMarket",
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: titleSize,
                        ),
                      ),
                      const Divider(),
                      const SizedBox(height: 10),
                      if (body != null) body!,
                      if (extraInfo != null) extraInfo!
                    ],
                  ),
                  if (foot != null) foot!
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
