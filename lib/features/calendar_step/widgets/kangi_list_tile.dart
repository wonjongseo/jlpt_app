import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/config/theme.dart';
import 'package:japanese_voca/features/jlpt_and_kangi/kangi/controller/kangi_step_controller.dart';
import 'package:japanese_voca/features/kangi_study/widgets/screens/kangi_study_sceen.dart';
import 'package:japanese_voca/model/kangi.dart';
import 'package:japanese_voca/user/controller/user_controller.dart';

class KangiListTile extends StatefulWidget {
  const KangiListTile({
    super.key,
    required this.kangi,
    required this.index,
    required this.isSaved,
  });
  final int index;
  final Kangi kangi;
  final bool isSaved;
  @override
  State<KangiListTile> createState() => _KangiListTileState();
}

class _KangiListTileState extends State<KangiListTile> {
  bool isWantToSeeMean = false;
  bool isWantToSeeUndoc = false;
  bool isWantToSeeHundoc = false;
  UserController userController = Get.find<UserController>();
  KangiStepController controller = Get.find<KangiStepController>();
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => KangiStudySceen(currentIndex: widget.index)),
      child: Container(
        decoration: BoxDecoration(border: Border.all(width: 0.3)),
        child: ListTile(
          dense: true,
          minLeadingWidth: 50,
          isThreeLine: true,
          subtitle: Column(
            children: [
              SizedBox(
                height: 20,
                child: Row(
                  children: [
                    const Text(
                      '옴독: ',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: AppFonts.japaneseFont,
                      ),
                    ),
                    if (isWantToSeeUndoc || !controller.isHidenUndoc)
                      Flexible(
                        child: Text(
                          widget.kangi.undoc,
                          style: const TextStyle(
                            fontSize: 16,
                            overflow: TextOverflow.ellipsis,
                            fontFamily: AppFonts.japaneseFont,
                          ),
                        ),
                      )
                    else
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            isWantToSeeUndoc = true;
                            setState(() {});
                          },
                          child: Container(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SizedBox(
                  height: 20,
                  child: Row(
                    children: [
                      const Text(
                        '훈독: ',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: AppFonts.japaneseFont,
                        ),
                      ),
                      if (isWantToSeeHundoc || !controller.isHidenHundoc)
                        Flexible(
                          child: Text(
                            widget.kangi.hundoc,
                            style: const TextStyle(
                              fontSize: 16,
                              overflow: TextOverflow.ellipsis,
                              fontFamily: AppFonts.japaneseFont,
                            ),
                          ),
                        )
                      else
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              isWantToSeeHundoc = true;
                              setState(() {});
                            },
                            child: Container(
                              height: 20,
                              color: Colors.grey,
                            ),
                          ),
                        )
                    ],
                  ),
                ),
              ),
            ],
          ),
          title: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: SizedBox(
              height: 20,
              child: isWantToSeeMean || !controller.isHidenMean
                  ? Text(
                      widget.kangi.korea,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontFamily: AppFonts.japaneseFont,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        isWantToSeeMean = true;
                        setState(() {});
                      },
                      child: Container(
                        width: double.infinity,
                        height: 15,
                        color: Colors.grey,
                      ),
                    ),
            ),
          ),
          leading: Text(
            widget.kangi.japan,
            style: const TextStyle(
              fontSize: 30,
              color: Colors.black,
              fontFamily: AppFonts.japaneseFont,
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
              onPressed: () => controller.toggleSaveWord(widget.kangi)),
        ),
      ),
    );
  }
}
