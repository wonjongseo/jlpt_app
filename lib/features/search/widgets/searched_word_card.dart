import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/theme.dart';
import 'package:japanese_voca/features/search/screens/searched_word_detail_screen.dart';
import 'package:japanese_voca/model/word.dart';

class SearchedWordCard extends StatelessWidget {
  const SearchedWordCard({
    super.key,
    required this.searchedWords,
    required this.index,
  });
  final int index;
  final List<Word> searchedWords;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: Responsive.height16 / 2),
      child: InkWell(
        onTap: () => Get.to(
          () => SearchedWordDetailScreen(
            searchedWords: searchedWords,
            index: index,
          ),
        ),
        child: Card(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.height10,
              vertical: Responsive.height16 / 4,
            ),
            child: Text(
              searchedWords[index].word,
              style: TextStyle(
                fontSize: Responsive.height18,
                fontWeight: FontWeight.w800,
                fontFamily: AppFonts.japaneseFont,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
