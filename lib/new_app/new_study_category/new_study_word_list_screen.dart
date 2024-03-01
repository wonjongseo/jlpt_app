import 'package:flutter/material.dart';
import 'package:japanese_voca/new_app/models/new_japanese.dart';
import 'package:japanese_voca/new_app/new_study/components/search_widget.dart';
import 'package:japanese_voca/new_app/new_study_category/new_study_category_screen.dart';
import 'package:japanese_voca/new_app/temp_data.dart';

class NewStudyWordListScreen extends StatefulWidget {
  final int chapterNumber;
  const NewStudyWordListScreen({super.key, required this.chapterNumber});

  @override
  State<NewStudyWordListScreen> createState() => _NewStudyWordListScreenState();
}

class _NewStudyWordListScreenState extends State<NewStudyWordListScreen> {
  late TextEditingController textEditingController;
  List<NewJapanese> newJapaneses = [];
  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
    newJapaneses = List.generate(
        temp_words.length, (index) => NewJapanese.fromMap(temp_words[index]));
  }

  @override
  void dispose() {
    textEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade200,
        title: Text(
          'JLPT N${widget.chapterNumber}',
          style: const TextStyle(fontWeight: FontWeight.w900),
        ),
      ),
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                NewSearchWidget(
                  textEditingController: textEditingController,
                  onChanged: (String v) {},
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: SingleChildScrollView(
                      child: Column(
                        children: List.generate(
                          newJapaneses.length,
                          (index) => NewChapterCard(
                            index: index,
                            newJapaneses: newJapaneses,
                          ),
                        ),
                      ),
                    ),
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
