import 'package:flutter/material.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/config/theme.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  late TextEditingController japanController;
  late TextEditingController yomikataController;
  late TextEditingController meanController;

  @override
  void initState() {
    super.initState();
    japanController = TextEditingController();
    yomikataController = TextEditingController();
    meanController = TextEditingController();
  }

  @override
  void dispose() {
    japanController.dispose();
    yomikataController.dispose();
    meanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SafeArea(
        child: Dialog(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Responsive.width16 * 2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InputForms(
                  japanController: japanController,
                  yomikataController: yomikataController,
                  meanController: meanController,
                ),
                SizedBox(
                  height: Responsive.height10,
                ),
                Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.red,
                  ),
                  child: Text('저장!'),
                  // child: ElevatedButton(
                  //   onPressed: () {},
                  //   child: Text('저장!'),
                  // ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text('저장!'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InputForms extends StatelessWidget {
  const InputForms({
    super.key,
    required this.japanController,
    required this.yomikataController,
    required this.meanController,
  });

  final TextEditingController japanController;
  final TextEditingController yomikataController;
  final TextEditingController meanController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyWordTextFormField(
          label: '일본어',
          controller: japanController,
        ),
        MyWordTextFormField(
          label: '읽는 법 (임의)',
          controller: yomikataController,
        ),
        MyWordTextFormField(
          label: '의미',
          controller: meanController,
        ),
      ],
    );
  }
}

class MyWordTextFormField extends StatelessWidget {
  const MyWordTextFormField({
    super.key,
    required this.label,
    required this.controller,
  });

  final String label;
  final TextEditingController controller;
  OutlineInputBorder textFieldBorder() {
    return OutlineInputBorder(
      borderSide: BorderSide(
        color: AppColors.mainColor,
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(Responsive.height10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Responsive.height8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: Responsive.width10,
              bottom: Responsive.height10 / 2,
            ),
            child: Text(
              label,
              style: TextStyle(
                fontSize: Responsive.height14,
                fontFamily: AppFonts.gMaretFont,
              ),
            ),
          ),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              // labelStyle: ,
              contentPadding: EdgeInsets.all(Responsive.height16),
              errorBorder: textFieldBorder(),
              focusedBorder: textFieldBorder(),
              focusedErrorBorder: textFieldBorder(),
              disabledBorder: textFieldBorder(),
              enabledBorder: textFieldBorder(),
              border: textFieldBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
