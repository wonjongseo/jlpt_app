import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/admob/controller/ad_controller.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/common/widget/heart_count.dart';
import 'package:japanese_voca/config/size.dart';
import 'package:japanese_voca/features/grammar_step/services/grammar_controller.dart';
import 'package:japanese_voca/features/grammar_step/widgets/grammar_description_card.dart';
import 'package:japanese_voca/features/grammar_test/components/grammar_example_card.dart';
import 'package:japanese_voca/model/grammar.dart';
import 'package:japanese_voca/user/controller/user_controller.dart';

class GrammarCardDetails extends StatefulWidget {
  const GrammarCardDetails({
    super.key,
    required this.index,
    required this.grammars,
  });
  final int index;
  final List<Grammar> grammars;
  @override
  State<GrammarCardDetails> createState() => _GrammarCardDetailsState();
}

class _GrammarCardDetailsState extends State<GrammarCardDetails> {
  late PageController pageController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    _currentPageIndex = widget.index;
    pageController = PageController(initialPage: _currentPageIndex);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  UserController userController = Get.find<UserController>();
  AdController adController = Get.find<AdController>();
  bool isShowMoreExample = false;

  PreferredSize _appBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(appBarHeight),
      child: AppBar(
        actions: const [HeartCount()],
        title: RichText(
          text: TextSpan(
            style: TextStyle(color: Colors.black, fontSize: appBarTextSize),
            children: [
              TextSpan(
                text: '${_currentPageIndex + 1}',
                style: TextStyle(
                  color: Colors.cyan.shade500,
                  fontSize: Responsive.height10 * 2.5,
                ),
              ),
              const TextSpan(text: ' / '),
              TextSpan(text: '${widget.grammars.length}')
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: SafeArea(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: PageView.builder(
              itemCount: widget.grammars.length,
              controller: pageController,
              onPageChanged: (value) {
                setState(() {
                  _currentPageIndex = value;
                  isShowMoreExample = false;
                });
              },
              itemBuilder: (context, index) {
                return SizedBox(
                  height: double.infinity,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.grammars[index].grammar,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Responsive.height10 * 3,
                              ),
                            ),
                            if (widget
                                .grammars[index].connectionWays.isNotEmpty) ...[
                              SizedBox(height: Responsive.height10 * 2),
                              GrammarDescriptionCard(
                                  fontSize: Responsive.height10 * 1.8,
                                  title: '접속 형태',
                                  content: widget
                                      .grammars[widget.index].connectionWays),
                              SizedBox(height: Responsive.height10 * 2),
                            ],
                            if (widget
                                .grammars[widget.index].means.isNotEmpty) ...[
                              GrammarDescriptionCard(
                                  fontSize: Responsive.height10 * 1.8,
                                  title: '뜻',
                                  content: widget.grammars[index].means),
                              SizedBox(height: Responsive.height10 * 2),
                            ],
                            if (widget
                                .grammars[index].description.isNotEmpty) ...[
                              GrammarDescriptionCard(
                                  fontSize: Responsive.height10 * 1.8,
                                  title: '설명',
                                  content: widget
                                      .grammars[widget.index].description),
                            ],
                            const Divider(),
                            SizedBox(height: Responsive.height10 * 2),
                            Text(
                              '문법 예제',
                              style: TextStyle(
                                  color: Colors.cyan.shade700,
                                  fontSize: Responsive.height10 * 1.8,
                                  fontWeight: FontWeight.bold),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...List.generate(
                                    isShowMoreExample
                                        ? widget.grammars[index].examples.length
                                        : 2, (index) {
                                  return GrammarExampleCard(
                                    index: index,
                                    example: widget
                                        .grammars[widget.index].examples[index],
                                  );
                                }),
                                if (!isShowMoreExample)
                                  TextButton(
                                    onPressed: () {
                                      isShowMoreExample = true;
                                      setState(() {});
                                    },
                                    style: TextButton.styleFrom(
                                      padding: EdgeInsets.zero,
                                      minimumSize: const Size(0, 0),
                                      tapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                    ),
                                    child: Text(
                                      '예제 더보기...',
                                      style: TextStyle(
                                          color: Colors.cyan.shade700,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            )),
      ),
    );
  }
}
