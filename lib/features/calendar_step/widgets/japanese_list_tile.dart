import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/config/theme.dart';
import 'package:japanese_voca/features/jlpt_and_kangi/jlpt/controller/jlpt_step_controller.dart';
import 'package:japanese_voca/features/jlpt_and_kangi/kangi/controller/kangi_step_controller.dart';
import 'package:japanese_voca/features/jlpt_study/screens/jlpt_study_sceen.dart';
import 'package:japanese_voca/features/kangi_study/widgets/screens/kangi_study_sceen.dart';
import 'package:japanese_voca/model/kangi.dart';
import 'package:japanese_voca/model/word.dart';
import 'package:japanese_voca/user/controller/user_controller.dart';

class JapaneseListTile extends StatefulWidget {
  const JapaneseListTile({
    Key? key,
    required this.isSaved,
    required this.index,
    required this.word,
  }) : super(key: key);
  final bool isSaved;
  final int index;
  final Word word;

  @override
  State<JapaneseListTile> createState() => _JapaneseListTileState();
}

class _JapaneseListTileState extends State<JapaneseListTile> {
  UserController userController = Get.find<UserController>();
  JlptStepController controller = Get.find<JlptStepController>();
  bool isWantToSeeMean = false;
  bool isWantToSeeYomikata = false;

  @override
  Widget build(BuildContext context) {
    String mean = widget.word.mean;
    String changedWord = widget.word.word;

    if (widget.word.mean.contains('1. ')) {
      mean = '${(widget.word.mean.split('\n')[0]).split('1. ')[1]}...';
    }
    if (widget.word.word.contains('·')) {
      changedWord = widget.word.word.split('·')[0];
    }

    return InkWell(
      onTap: () => Get.to(() => JlptStudyScreen(currentIndex: widget.index)),
      child: Container(
        decoration: BoxDecoration(border: Border.all(width: 0.3)),
        child: ListTile(
          isThreeLine: true,
          minLeadingWidth: 80,
          subtitle: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: SizedBox(
              height: 30,
              child: isWantToSeeYomikata || controller.isSeeYomikata
                  ? Text(
                      widget.word.yomikata,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: AppFonts.descriptionFont,
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        isWantToSeeYomikata = true;
                        setState(() {});
                      },
                      child: Container(
                        height: 20,
                        decoration: BoxDecoration(color: Colors.grey.shade400),
                      ),
                    ),
            ),
          ),
          title: SizedBox(
            height: 30,
            child: isWantToSeeMean || controller.isSeeMean
                ? Text(
                    mean,
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: AppFonts.descriptionFont,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                : InkWell(
                    onTap: () {
                      isWantToSeeMean = true;
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(color: Colors.grey.shade400),
                    ),
                  ),
          ),
          leading: Text(
            changedWord,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              fontFamily: AppFonts.japaneseFont,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          trailing: IconButton(
            style: IconButton.styleFrom(
              padding: const EdgeInsets.all(2),
              minimumSize: const Size(0, 0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            icon: FaIcon(
              widget.isSaved
                  ? FontAwesomeIcons.solidBookmark
                  : FontAwesomeIcons.bookmark,
              color: widget.isSaved ? AppColors.mainBordColor : null,
              size: 22,
            ),
            onPressed: () => controller.toggleSaveWord(widget.word),
          ),
        ),
      ),
    );
  }
}
