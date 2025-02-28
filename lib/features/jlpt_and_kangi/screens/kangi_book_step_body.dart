import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:japanese_voca/common/commonDialog.dart';
import 'package:japanese_voca/config/theme.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/features/calendar_step/kangi_calendar_step_body.dart';
import 'package:japanese_voca/features/jlpt_and_kangi/kangi/controller/kangi_step_controller.dart';
import 'package:japanese_voca/features/jlpt_home/screens/jlpt_home_screen.dart';
import 'package:japanese_voca/repository/local_repository.dart';
import 'package:japanese_voca/user/controller/user_controller.dart';

class KangiBookStepBody extends StatefulWidget {
  final String level;

  const KangiBookStepBody({super.key, required this.level});
  @override
  State<KangiBookStepBody> createState() => _KangiBookStepBodyState();
}

class _KangiBookStepBodyState extends State<KangiBookStepBody> {
  late KangiStepController kangiController;
  int progrssingIndex = 0;
  UserController userController = Get.find<UserController>();
  CarouselSliderController carouselController = CarouselSliderController();

  @override
  void initState() {
    kangiController = Get.put(KangiStepController(level: widget.level));

    progrssingIndex = LocalReposotiry.getCurrentProgressing(
        '${CategoryEnum.Grammars.name}-${widget.level}');

    super.initState();
  }

  void goTo(String chapter) {
    Get.to(() => KangiCalendarStepBody(chapter: chapter));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(builder: (controller) {
      return CarouselSlider(
        carouselController: carouselController,
        options: CarouselOptions(
          enableInfiniteScroll: false,
          disableCenter: true,
          initialPage: progrssingIndex,
          enlargeCenterPage: true,
          onPageChanged: (index, reason) {
            progrssingIndex = index;
          },
          scrollDirection: Axis.horizontal,
        ),
        items: List.generate(
          kangiController.headTitleCount,
          (index) {
            bool isAllAccessable = !(widget.level == '1' && index > 2) ||
                controller.user.isPremieum ||
                controller.user.isTrik;

            return InkWell(
              onLongPress: () {
                if (isAllAccessable) {
                  return;
                }
                userController.changeUserAuth();
              },
              onTap: () {
                if (!isAllAccessable) {
                  CommonDialog.appealDownLoadThePaidVersion();
                  return;
                }
                if (progrssingIndex == index) {
                  LocalReposotiry.putCurrentProgressing(
                      '${CategoryEnum.Grammars.name}-${widget.level}',
                      progrssingIndex);
                  goTo('챕터${index + 1}');
                } else if (progrssingIndex < index) {
                  progrssingIndex++;
                  carouselController.animateToPage(progrssingIndex);
                } else {
                  progrssingIndex--;
                  carouselController.animateToPage(progrssingIndex);
                }
                setState(() {});
              },
              child: Card(
                color: !isAllAccessable ? Colors.grey.shade400 : Colors.white,
                child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(
                        children: [
                          Center(
                            child: RichText(
                              text: TextSpan(
                                text: '${CategoryEnum.Grammars.id}\n',
                                children: [
                                  TextSpan(
                                    text: 'Chapter ${(index + 1)}',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                    ),
                                  )
                                ],
                                style: TextStyle(
                                  fontFamily: AppFonts.gMaretFont,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23,
                                  color: isAllAccessable
                                      ? AppColors.mainBordColor
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                          if (!isAllAccessable)
                            const Align(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.lock,
                                size: 100,
                              ),
                            ),
                          if (progrssingIndex == index)
                            Positioned(
                              bottom: 10,
                              right: 10,
                              child: Card(
                                shape: const CircleBorder(),
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                    color: AppColors.lightGreen,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                            )
                        ],
                      ),
                    )),
              ),
            );
          },
        ),
      );
    });
  }
}
