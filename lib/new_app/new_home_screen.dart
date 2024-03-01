import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/app_bar_progress_bar.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/new_app/new_study/components/search_widget.dart';
import 'package:japanese_voca/new_app/new_study/new_study_screen.dart';
import 'package:japanese_voca/new_app/new_study_category/new_study_category_screen.dart';

List<String> aa = [
  "冷ややか",
  "不思議",
  "不便",
  "平気",
  "下手",
  "変",
  "便利",
  "本気",
  "もとも",
  "稀",
  "身軽",
  "見事",
];

class NewHomeScreen extends StatefulWidget {
  const NewHomeScreen({super.key});

  @override
  State<NewHomeScreen> createState() => _NewHomeScreenState();
}

class _NewHomeScreenState extends State<NewHomeScreen> {
  late TextEditingController textEditingController;

  List<String> searchWords = [];
  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  onChanged(String value) {
    String aaa = "漢字";
    List<String> aaaa = aaa.split('');

    print(aaaa);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey.shade200,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
            icon: const FaIcon(FontAwesomeIcons.magnifyingGlass,
                color: Colors.grey),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: const FaIcon(FontAwesomeIcons.comment),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: const FaIcon(FontAwesomeIcons.book),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: const FaIcon(FontAwesomeIcons.user),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '',
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Hi, Jongseo Won',
                      style: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'What would you like to train today?\nSearch below.',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 16, color: Colors.grey.shade700),
                    )
                  ],
                ),
                const SizedBox(height: 40),
                NewSearchWidget(
                    textEditingController: textEditingController,
                    onChanged: onChanged),
                const SizedBox(height: 10),
                const SizedBox(height: 50),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'STDUYING',
                    // textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 22,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(5, (index) {
                      return StudyCard(level: index + 1);
                    }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class StudyCard extends StatelessWidget {
  final int level;
  const StudyCard({
    super.key,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Card(
        color: Colors.white,
        child: InkWell(
          onTap: () {
            Get.to(
              () => NewStudyCategoryScreen(
                level: level,
              ),
            );
          },
          child: Container(
            width: 220,
            height: 250,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'N$level',
                    style: const TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Divider(),
                  const StudyCardDetails(
                    category: '単語',
                    maxValue: 2000,
                    currentValue: 20,
                  ),
                  const StudyCardDetails(
                    category: '漢字',
                    maxValue: 2000,
                    currentValue: 20,
                  ),
                  const StudyCardDetails(
                    category: '文法',
                    maxValue: 2000,
                    currentValue: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class StudyCardDetails extends StatelessWidget {
  const StudyCardDetails({
    super.key,
    required this.maxValue,
    required this.currentValue,
    required this.category,
  });

  final int maxValue;
  final int currentValue;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$category ($currentValue/$maxValue)',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        FAProgressBar(
          currentValue: 20,
          maxValue: 100,
          displayText: '%',
          size: 15,
          formatValueFixed: 0,
          backgroundColor: Colors.grey.shade700,
          progressColor: Colors.cyan.shade700,
          borderRadius: BorderRadius.circular(2),
          displayTextStyle:
              const TextStyle(color: Color(0xFFFFFFFF), fontSize: 10),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
