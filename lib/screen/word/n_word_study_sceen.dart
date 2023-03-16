import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/custom_page_button.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/model/word.dart';

class NWordStudyScreen extends StatefulWidget {
  const NWordStudyScreen({super.key, required this.words});

  final List<Word> words;

  @override
  State<NWordStudyScreen> createState() => _NWordStudyScreenState();
}

class _NWordStudyScreenState extends State<NWordStudyScreen> {
  int currentIndex = 0;
  bool isShownMean = false;
  bool isShownYomikata = false;

  void nextWord() {
    isShownMean = false;
    isShownYomikata = false;
    currentIndex++;

    if (currentIndex >= widget.words.length) {
      Get.back();

      return;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              SizedBox(
                child: Expanded(
                  child: Text(
                    widget.words[currentIndex].yomikata,
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                        color: isShownYomikata
                            ? Colors.black
                            : AppColors.whiteGrey),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Expanded(
                    child: Text(
                  widget.words[currentIndex].word,
                  style: Theme.of(context).textTheme.headline3,
                  textAlign: TextAlign.center,
                )),
              ),
              const SizedBox(height: 15),
              SizedBox(
                child: Expanded(
                  child: Text(
                    widget.words[currentIndex].mean,
                    style: Theme.of(context).textTheme.headline6?.copyWith(
                        color:
                            isShownMean ? Colors.black : AppColors.whiteGrey),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                text: '의미',
                onTap: () {
                  isShownMean = !isShownMean;
                  setState(() {});
                },
              ),
              const SizedBox(width: 16),
              CustomButton(
                text: '읽는 법',
                onTap: () {
                  isShownYomikata = !isShownYomikata;
                  setState(() {});
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                text: '몰라요',
                onTap: () {
                  nextWord();
                },
              ),
              const SizedBox(width: 16),
              CustomButton(
                text: '알아요',
                onTap: () {
                  nextWord();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  final String text;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 120,
        height: 50,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: const [
              BoxShadow(
                  offset: Offset(0, 1), color: Colors.grey, blurRadius: 0.5),
            ]),
        child: Center(child: Text(text)),
      ),
    );
  }
}
