import 'package:flutter/material.dart';
import 'package:japanese_voca/common/admob/banner_ad/global_banner_admob.dart';
import 'package:japanese_voca/common/widget/custom_appbar.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/size.dart';
import 'package:japanese_voca/features/jlpt_study/widgets/word_card.dart';
import 'package:japanese_voca/model/word.dart';

class SearchedWordDetailScreen extends StatefulWidget {
  const SearchedWordDetailScreen(
      {super.key, required this.index, required this.searchedWords});
  final int index;
  final List<Word> searchedWords;

  @override
  State<SearchedWordDetailScreen> createState() =>
      _SearchedWordDetailScreenState();
}

class _SearchedWordDetailScreenState extends State<SearchedWordDetailScreen> {
  late PageController pageController;

  int _currentPageIndex = 0;
  @override
  void initState() {
    super.initState();
    _currentPageIndex = widget.index;
    pageController = PageController(initialPage: _currentPageIndex);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(appBarHeight),
        child: AppBar(
          title: CustomAppBarTitle(
            curIndex: _currentPageIndex + 1,
            totalIndex: widget.searchedWords.length,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: PageView.builder(
            controller: pageController,
            onPageChanged: onPageChanged,
            itemCount: widget.searchedWords.length,
            itemBuilder: (context, index) {
              return WordCard(word: widget.searchedWords[_currentPageIndex]);
            },
          ),
        ),
      ),
      bottomNavigationBar: const GlobalBannerAdmob(),
    );
  }

  void onPageChanged(v) {
    _currentPageIndex = v;
    setState(() {});
  }
}
