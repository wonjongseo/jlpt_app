import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:japanese_voca/common/controller/tts_controller.dart';
import 'package:japanese_voca/new_app/new_study/components/new_custom_appbar.dart';
import 'package:japanese_voca/new_app/new_study/components/new_study_card.dart';
import 'package:japanese_voca/new_app/models/new_japanese.dart';

class NewStudyScreen extends StatefulWidget {
  const NewStudyScreen(
      {super.key,
      this.isRelated = false,
      required this.newJapaneses,
      required this.index});
  final bool isRelated;
  final List<NewJapanese> newJapaneses;
  final int index;
  @override
  State<NewStudyScreen> createState() => _NewStudyScreenState();
}

class _NewStudyScreenState extends State<NewStudyScreen> {
  int pageIndex = 0;
  // List<NewJapanese> vocas = [];
  TtsController ttsController = Get.put(TtsController());
  late PageController pageController;
  @override
  void initState() {
    super.initState();
    pageIndex = widget.index;
    pageController = PageController(initialPage: pageIndex);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  onPageChange(int newPage) {
    print('object');
    pageIndex = newPage;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: widget.isRelated ? AppBar() : null,
      body: SafeArea(
          child: Column(
        children: [
          const SizedBox(height: 20),
          CustomAppBar(currentIndex: pageIndex),
          const SizedBox(height: 10),
          Expanded(
            child: PageView.builder(
              onPageChanged: onPageChange,
              controller: pageController,
              itemCount: widget.newJapaneses.length,
              itemBuilder: (context, index) {
                return NewStudyCard(
                  japanese: widget.newJapaneses[index],
                );
              },
            ),
          ),
        ],
      )),
    );
  }
}
