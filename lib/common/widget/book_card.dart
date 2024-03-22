import 'package:flutter/material.dart';

class BookCard extends StatelessWidget {
  const BookCard({
    Key? key,
    required this.level,
    required this.onTap,
  }) : super(key: key);

  final String level;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: onTap,
        child: Card(
          color: Colors.white,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            height: 45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                    text: TextSpan(
                  text: 'Day $level  ',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  children: const [
                    TextSpan(
                      text: ' (0 /30)',
                      style: TextStyle(color: Colors.grey, fontSize: 13),
                    ),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
  //   return Column(
  //     mainAxisSize: MainAxisSize.min,
  //     children: [
  //       IconButton(
  //         onPressed: onTap,
  //         padding: EdgeInsets.zero,
  //         style: IconButton.styleFrom(
  //           padding: EdgeInsets.zero,
  //         ),
  //         icon: const Icon(
  //           Icons.book,
  //           color: Colors.white,
  //           size: 220,
  //         ),
  //       ),
  //       Text(
  //         level,
  //         style: const TextStyle(
  //           color: AppColors.whiteGrey,
  //           fontWeight: FontWeight.bold,
  //           fontSize: 25,
  //         ),
  //       ),
  //       const SizedBox(height: 15),
  //     ],
  //   );
  // }
}
