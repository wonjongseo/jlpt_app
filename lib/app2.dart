import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class App2 extends StatefulWidget {
  const App2({super.key});

  @override
  State<App2> createState() => _App2State();
}

class _App2State extends State<App2> {
  late PageController pageController;
  late Timer timer;
  List<String> words = ['Hello', 'AAA', 'BBB', "CCCC", 'DDDD'];

  int _currentPage = 0;
  Future<int> sumStream(Stream<int> stream) async {
    var sum = 0;
    await for (var value in stream) {
      print('value: ${value}');

      sum += value;
    }
    return sum;
  }

  Stream<int> countStream(int to) async* {
    for (int i = 1; i <= to; i++) {
      await Future.delayed(const Duration(seconds: 1));
      yield i;
    }
  }

  void setTimer() {
    timer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
      if (_currentPage < words.length) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      // if (pageController.hasClients) {
      pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
      // }
    });
  }

  @override
  void initState() {
    pageController = PageController(initialPage: 0);
    // setTimer();
    super.initState();
  }

  void onPageChange(int value) {
    _currentPage = value;
    setState(() {});
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              // StreamBuilder(
              //   initialData: '',
              //   builder: (context, snapshot) {
              //     return Text('${snapshot.data}');
              //   },
              // ),
              // Expanded(
              //   child: PageView.builder(
              //     onPageChanged: onPageChange,
              //     controller: pageController,
              //     itemCount: words.length,
              //     itemBuilder: (context, index) {
              //       return Column(
              //         children: [
              //           Padding(
              //             padding: const EdgeInsets.all(8.0),
              //             child: Container(
              //                 color: Colors.red,
              //                 width: 100,
              //                 height: 100,
              //                 child: Text(words[index])),
              //           ),
              //         ],
              //       );
              //     },
              //   ),
              // ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      var stream = countStream(10);
                      var sum = await sumStream(stream);
                      print(sum);
                    },
                    child: Text('STOP'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      timer.cancel();
                    },
                    child: Text('Start'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
