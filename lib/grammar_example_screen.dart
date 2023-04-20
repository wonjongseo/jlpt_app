import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:japanese_voca/common/widget/kangi_text.dart';
import 'package:japanese_voca/model/example.dart';
import 'package:japanese_voca/model/grammar.dart';

class GrammarExampleScreen extends StatefulWidget {
  const GrammarExampleScreen({super.key, required this.grammar});
  final Grammar grammar;
  @override
  State<GrammarExampleScreen> createState() => _GrammarExampleScreenState();
}

class _GrammarExampleScreenState extends State<GrammarExampleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        // padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
        padding:
            const EdgeInsets.only(top: 50, bottom: 16, right: 32, left: 32),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                widget.grammar.grammar,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 22,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(widget.grammar.means),
            ),
            const Divider(
              height: 20,
              thickness: 2,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      List.generate(widget.grammar.examples.length, (index) {
                    return GrammarExampleCard(
                      example: widget.grammar.examples[index],
                    );
                  }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class GrammarExampleCard extends StatefulWidget {
  const GrammarExampleCard({super.key, required this.example});
  final Example example;
  @override
  State<GrammarExampleCard> createState() => _GrammarExampleCardState();
}

class _GrammarExampleCardState extends State<GrammarExampleCard> {
  bool isClick = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: TouchableJapanese(
                  color: Colors.black,
                  japanese: widget.example.word,
                  clickTwice: false,
                  fontSize: 16,
                ),
              ),
              IconButton(
                onPressed: () {
                  isClick = !isClick;
                  setState(() {});
                },
                icon: SvgPicture.asset(
                  'assets/svg/eye.svg',
                  color: Colors.black,
                  height: 20,
                  width: 20,
                ),
              )
            ],
          ),
          if (isClick)
            Text(
              widget.example.mean,
              style: TextStyle(color: Colors.grey),
            ),
        ],
      ),
    );
  }
}
