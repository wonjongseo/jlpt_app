import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:japanese_voca/screen/home/components/home_navigator_button.dart';

class FoolWordScreen extends StatelessWidget {
  const FoolWordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    GlobalKey key = GlobalKey();
    return Stack(
      children: [
        Opacity(
          opacity: 0.5,
          child: Frame(size: size, key1: key),
        ),
        Positioned(
            top: 100,
            left: 100,
            child: Text(
              'HEKLLLELELLE',
              style: TextStyle(color: Colors.yellow),
            ))
      ],
    );
  }
}

class Frame extends StatelessWidget {
  const Frame({
    super.key,
    required this.size,
    required this.key1,
  });

  final Size size;
  final GlobalKey key1;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: size.height * 0.18,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 16, bottom: 16, left: 32, right: 16),
            child: FadeInDown(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        'こんにちは！',
                        style: GoogleFonts.abel(
                            fontSize: 22, fontWeight: FontWeight.w600),
                      ),
                      Row(
                        children: [
                          Text(
                            'ようこそ',
                            style: GoogleFonts.abel(
                                fontSize: 22, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            ' JLPT 종각 APP',
                            style: GoogleFonts.abel(
                                color: Colors.red,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.settings,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HomeNaviatorButton(
                key: key1,
                text: 'N1 단어',
                wordsCount: '2,466',
              ),
              HomeNaviatorButton(
                wordsCount: '2,618',
                text: 'N2 단어',
              ),
              HomeNaviatorButton(
                wordsCount: '1,532',
                text: 'N3 단어',
              ),
              HomeNaviatorButton(
                wordsCount: '1,029',
                text: 'N4 단어',
              ),
              HomeNaviatorButton(
                wordsCount: '737',
                text: 'N5 단어',
              ),
            ],
          ),
        )
      ],
    );
  }
}
