import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';

class App2 extends StatefulWidget {
  const App2({super.key});

  @override
  State<App2> createState() => _App2State();
}

class _App2State extends State<App2> {
  List<Color> colors = const [
    Color(0xFFD21312),
    Color(0xFFFC4F00),
    Color(0xFFF9F54B),
    Color(0xFF16FF00),
    Color(0xFF0008C1),
    Color(0xFF3C486B),
    Color(0xFFAA77FF),
    Color(0xFF191825),
    Color(0xFFFEFBF6),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate((colors.length / 2).floor(), (index) {
            int tempIndex = index;
            index++;
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Box(color: colors[tempIndex], index: tempIndex),
                const SizedBox(width: 10),
                Box(
                    color: colors[(colors.length / 2).toInt() + index],
                    index: (colors.length / 2).toInt() + index),
              ],
            );
          }),
        ),
      ),
    ));
  }
}

class Box extends StatelessWidget {
  const Box({super.key, required this.color, required this.index});
  final Color color;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(index.toString()),
        SvgPicture.asset(
          'assets/svg/calender.svg',
          width: 150,
          height: 150,
          color: color,
        ),
      ],
    );
  }
}
