import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:japanese_voca/common/widget/cusomt_button.dart';

class App2 extends StatefulWidget {
  const App2({super.key});

  @override
  State<App2> createState() => _App2State();
}

class _App2State extends State<App2> {
  String selectedAnswer = '';
  bool isClick = false;
  bool? isCorrent1 = null;
  bool? isCorrent2 = null;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ZoomIn(
                child: Text(
                  '100',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w600,
                    fontSize: 40,
                    letterSpacing: 1.5,
                    fontFamily: 'ScoreStd',
                    fontStyle: FontStyle.italic,
                    shadows: [
                      const Shadow(
                        color: Colors.black,
                        offset: Offset(0, 1),
                        blurRadius: 2,
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, bottom: 8),
                child: Row(
                  children: [
                    if (isClick)
                      Stack(
                        alignment: AlignmentDirectional.centerStart,
                        children: [
                          if (isCorrent2 != null && isCorrent2!)
                            Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.red, width: 3),
                              ),
                            )
                          else
                            SvgPicture.asset(
                              'assets/svg/incorrect-icon.svg',
                              height: 25,
                              width: 25,
                            ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              '1.',
                              style: TextStyle(fontSize: 25),
                            ),
                          ),
                        ],
                      ),
                    // if (!isClick)
                    //   Padding(
                    //     padding: const EdgeInsets.symmetric(horizontal: 8),
                    //     child: const Text(
                    //       '1.',
                    //       style: TextStyle(fontSize: 25),
                    //     ),
                    //   ),
                    Text(
                      '仕事がまでまでで、花火に行______行けない.',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: isCorrent1 != null && isCorrent1!
                            ? Colors.red
                            : null,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              if (isClick)
                Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 8),
                  child: Text('일이 아직 남아서, 불꽃축제에 가려고해도 갈 수 없다.'),
                ),
              Column(
                children: [
                  ListTile(
                    title: Text('1. AA'),
                    leading: Radio<String>(
                      groupValue: selectedAnswer,
                      value: '1. AA',
                      activeColor: Colors.black,
                      focusColor: Colors.black,
                      onChanged: (String? value) {
                        setState(() {
                          selectedAnswer = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('2. BB'),
                    leading: Radio<String>(
                      groupValue: selectedAnswer,
                      value: '2. BB',
                      activeColor: Colors.black,
                      focusColor: Colors.black,
                      onChanged: (String? value) {
                        setState(() {
                          selectedAnswer = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('3. CC'),
                    leading: Radio<String>(
                      groupValue: selectedAnswer,
                      value: '3. CC',
                      activeColor: Colors.black,
                      focusColor: Colors.black,
                      onChanged: (String? value) {
                        setState(() {
                          selectedAnswer = value!;
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: Text('4. DD'),
                    leading: Radio<String>(
                      groupValue: selectedAnswer,
                      value: '4. DD',
                      activeColor: Colors.black,
                      focusColor: Colors.black,
                      onChanged: (String? value) {
                        setState(() {
                          selectedAnswer = value!;
                        });
                      },
                    ),
                  )
                ],
              ),
              CustomButton(
                  text: 'Click',
                  onTap: () {
                    if (isCorrent1 == null) {
                      isCorrent1 = true;
                    } else {
                      isCorrent1 = !isCorrent1!;
                    }
                    isCorrent2 = false;
                    setState(() {
                      isClick = !isClick;
                    });
                  })
            ],
          ),
        ),
      )),
    );
  }
}
