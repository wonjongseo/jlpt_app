// import 'package:flutter/material.dart';
// import 'package:japanese_voca/config/colors.dart';
// import 'package:japanese_voca/data/kangis_data.dart';

// class KangiNavigator extends StatefulWidget {
//   const KangiNavigator({
//     super.key,
//     required this.pageController,
//     required this.currentPage,
//     required this.scrollController,
//     required this.navigateScroll,
//   });

//   final PageController pageController;
//   final int currentPage;
//   final ScrollController scrollController;
//   final Function() navigateScroll;

//   @override
//   State<KangiNavigator> createState() => _KangiNavigatorState();
// }

// class _KangiNavigatorState extends State<KangiNavigator> {
//   int previousIndex = 0;
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 48),
//       child: SingleChildScrollView(
//         controller: widget.scrollController,
//         scrollDirection: Axis.horizontal,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ...List.generate(hanguls.length, (index) {
//               return InkWell(
//                 onTap: () {
//                   if (6 == index && 6 > previousIndex) {
//                     widget.navigateScroll();
//                   }
//                   widget.pageController.animateToPage(
//                     index,
//                     duration: const Duration(milliseconds: 300),
//                     curve: Curves.easeInOut,
//                   );
//                   previousIndex = index;
//                 },
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8),
//                   child: Icon(
//                     Icons.circle,
//                     size: 22,
//                     color: index == widget.currentPage
//                         ? AppColors.whiteGrey
//                         : Colors.grey.withOpacity(0.3),
//                   ),
//                 ),
//               );
//             }),
//           ],
//         ),
//       ),
//     );
//   }
// }
