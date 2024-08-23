import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/theme.dart';
import 'package:japanese_voca/features/search/screens/searched_word_detail_screen.dart';
import 'package:japanese_voca/model/grammar.dart';
import 'package:japanese_voca/model/kangi.dart';
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
            child: Column(
              children: [
                Text(
                  searchedWords[index].word,
                  style: TextStyle(
                    fontSize: Responsive.height18,
                    fontWeight: FontWeight.w600,
                    fontFamily: AppFonts.japaneseFont,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SearchedKangiCard extends StatelessWidget {
  const SearchedKangiCard({
    super.key,
    required this.searchedKangis,
    required this.index,
  });
  final int index;
  final List<Kangi> searchedKangis;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: Responsive.height16 / 2),
      child: InkWell(
        onTap: () => Get.to(
          () => SearchedKangiDetailScreen(
            searchedKangis: searchedKangis,
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
              searchedKangis[index].korea,
              style: TextStyle(
                fontSize: Responsive.height18,
                fontWeight: FontWeight.w600,
                fontFamily: AppFonts.japaneseFont,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SearchedGrammarCard extends StatelessWidget {
  const SearchedGrammarCard({
    super.key,
    required this.searchedGrammar,
    required this.index,
  });
  final int index;
  final List<Grammar> searchedGrammar;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: Responsive.height16 / 2),
      child: InkWell(
        onTap: () => Get.to(
          () => SearchedGrammarDetailScreen(
            searchedGrammar: searchedGrammar,
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
              searchedGrammar[index].grammar,
              style: TextStyle(
                fontSize: Responsive.height18,
                fontWeight: FontWeight.w600,
                fontFamily: AppFonts.japaneseFont,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
