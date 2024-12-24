import 'package:flutter/material.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/config/enums.dart';
import 'package:japanese_voca/config/theme.dart';
import 'package:japanese_voca/features/my_voca/screens/save_voca_screen.dart';

class CustomTextForm extends StatelessWidget {
  const CustomTextForm({
    super.key,
    required this.textController,
    required this.focusNode,
    required this.textInputEnum,
    required this.isFocus,
    this.validator,
  });

  final TextInputEnum textInputEnum;
  final TextEditingController textController;
  final FocusNode focusNode;
  final String? Function(String?)? validator;
  final bool isFocus;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Responsive.height16 / 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            textInputEnum.name,
            style: isFocus ? accentTextStyle : null,
          ),
          TextFormField(
            textInputAction: textInputEnum == TextInputEnum.MEAN ||
                    textInputEnum == TextInputEnum.EXAMPLE_MEAN
                ? TextInputAction.done
                : TextInputAction.next,
            style: const TextStyle(
              fontFamily: AppFonts.japaneseFont,
              fontWeight: FontWeight.w500,
            ),
            onChanged: validator,
            validator: validator,
            autofocus: textInputEnum == TextInputEnum.JAPANESE,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(left: Responsive.width10, top: 0),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColors.mainColor,
                  width: 2.5,
                ),
              ),
              enabledBorder: const OutlineInputBorder(),
              focusedErrorBorder: outlineErrorBorder(),
              errorBorder: outlineErrorBorder(),
            ),
            controller: textController,
            focusNode: focusNode,
          ),
        ],
      ),
    );
  }

  OutlineInputBorder outlineErrorBorder() {
    return const OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.redAccent,
        width: 3,
      ),
    );
  }
}
