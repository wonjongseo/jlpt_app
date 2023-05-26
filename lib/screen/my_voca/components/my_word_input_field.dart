import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyWordInputField extends StatelessWidget {
  const MyWordInputField({
    super.key,
    required this.wordFocusNode,
    required this.wordController,
    required this.yomikataFocusNode,
    required this.yomikataController,
    required this.meanFocusNode,
    required this.meanController,
    required this.saveWord,
  });

  final Function() saveWord;
  final FocusNode wordFocusNode;
  final TextEditingController wordController;
  final FocusNode yomikataFocusNode;
  final TextEditingController yomikataController;
  final FocusNode meanFocusNode;
  final TextEditingController meanController;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double responsiveInputBoxHeight = size.width > 700 ? 32 : 16;
    double responsiveSaveButtonHeight = size.width > 700 ? 50 : 40;
    double responsiveMargin = size.width > 700 ? 20 : 5;
    double responsiveTextFieldFontSize = size.width > 700 ? 16 : 13;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 3,
              offset: const Offset(1, 1),
            ),
          ]),
      padding: EdgeInsets.symmetric(
          vertical: responsiveInputBoxHeight, horizontal: 32),
      child: Form(
        child: Column(
          children: [
            TextFormField(
              autofocus: true,
              focusNode: wordFocusNode,
              onFieldSubmitted: (value) => saveWord(),
              controller: wordController,
              decoration: InputDecoration(
                label: Text(
                  '일본어',
                  style: TextStyle(
                    fontSize: responsiveTextFieldFontSize,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: responsiveMargin),
            TextFormField(
              focusNode: yomikataFocusNode,
              onFieldSubmitted: (value) => saveWord(),
              controller: yomikataController,
              decoration: InputDecoration(
                label: Text(
                  '읽는 법',
                  style: TextStyle(
                    fontSize: responsiveTextFieldFontSize,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(height: responsiveMargin),
            TextFormField(
              focusNode: meanFocusNode,
              onFieldSubmitted: (value) => saveWord(),
              controller: meanController,
              decoration: InputDecoration(
                label: Text(
                  '의미',
                  style: TextStyle(
                    fontSize: responsiveTextFieldFontSize,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: responsiveSaveButtonHeight,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: saveWord,
                child: const Text('저장'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
