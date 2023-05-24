import 'package:flutter/material.dart';

class HomeNaviatorButton extends StatelessWidget {
  const HomeNaviatorButton({
    Key? key,
    required this.text,
    this.onTap,
    this.wordsCount,
    this.jlptN1Key,
  }) : super(key: key);

  final GlobalKey? jlptN1Key;
  final String text;
  final String? wordsCount;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13),
      child: SizedBox(
        width: size.width * 0.7,
        height: 50,
        child: ElevatedButton(
          onPressed: onTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                key: jlptN1Key,
                text,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
              ),
              if (wordsCount != null)
                Text(
                  '$wordsCount개',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.black,
                      ),
                ),
            ],
          ),
        ),
      ),
      // child: InkWell(
      //   onTap: onTap,
      //   child: Container(
      //       height: 50,
      //       width: size.width * 0.7,
      //       decoration: const BoxDecoration(
      //           color: Colors.white,
      //           borderRadius: BorderRadius.all(
      //             Radius.circular(5),
      //           ),
      //           boxShadow: [
      //             BoxShadow(
      //               color: Colors.grey,
      //               offset: Offset(1, 1),
      //             ),
      //           ]),
      //       child: Padding(
      //         padding: const EdgeInsets.symmetric(horizontal: 16),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             Text(
      //               key: jlptN1Key,
      //               text,
      //               style: Theme.of(context).textTheme.labelLarge!.copyWith(
      //                     fontWeight: FontWeight.w700,
      //                   ),
      //             ),
      //             if (wordsCount != null)
      //               Text(
      //                 '$wordsCount개',
      //                 style: Theme.of(context).textTheme.bodySmall!.copyWith(
      //                       color: Colors.black,
      //                     ),
      //               ),
      //           ],
      //         ),
      //       )),
      // ),
    );
  }
}
