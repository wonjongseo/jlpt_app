import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/admob/banner_ad/global_banner_admob.dart';
import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/features/grammar_step/services/grammar_controller.dart';
import 'package:japanese_voca/repository/local_repository.dart';

// ignore: must_be_immutable
class GrammarStepSceen extends StatefulWidget {
  GrammarStepSceen({super.key, required this.level});

  final String level;

  @override
  State<GrammarStepSceen> createState() => _GrammarStepSceenState();
}

class _GrammarStepSceenState extends State<GrammarStepSceen> {
  CarouselController carouselController = CarouselController();

  late GrammarController grammarController;

  int isProgrssing = 1;
  @override
  void initState() {
    super.initState();

    grammarController = Get.put(GrammarController(level: widget.level));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      bottomNavigationBar: const GlobalBannerAdmob(),
      body: _body(width, context),
    );
  }

  Widget _body(double width, BuildContext context) {
    return CarouselSlider(
        carouselController: carouselController,
        options: CarouselOptions(
          height: 400,
          enableInfiniteScroll: false,
          initialPage: 0,
          enlargeCenterPage: true,
          onPageChanged: (index, reason) {
            // isProgrssing = index;
          },
          scrollDirection: Axis.horizontal,
        ),
        items: List.generate(grammarController.grammers.length, (index) {
          return InkWell(
            onTap: () {
              grammarController.goToSturyPage(index);
            },
            child: Card(
              child: SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Center(
                          child: Text(
                            'Chapter ${(index + 1)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Responsive.height10 * 3,
                              color: Colors.cyan.shade700,
                            ),
                          ),
                        ),
                        if (isProgrssing == index)
                          Positioned(
                            bottom: 5,
                            right: 5,
                            child: Card(
                              shape: const CircleBorder(),
                              child: Container(
                                height: Responsive.height10 * 3,
                                width: Responsive.height10 * 3,
                                decoration: BoxDecoration(
                                  color: AppColors.lightGreen,
                                  borderRadius: BorderRadius.circular(
                                    Responsive.height10 * 1.5,
                                  ),
                                ),
                              ),
                            ),
                          )
                      ],
                    ),
                  )),
            ),
          );
        }));

    return GetBuilder<GrammarController>(
      builder: (controller) {
        return ListView.builder(
          itemCount: controller.grammers.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                ;
              },
              child: Container(
                height: 50,
                padding: const EdgeInsets.all(8),
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  color: Colors.transparent,
                ),
                child: Text(
                  'Chapter${(controller.grammers[index].step + 1)}. (${controller.grammers[index].scores.toString()} / ${controller.grammers[index].grammars.length})',
                ),
              ),
            );
          },
        );
      },
    );
  }
}
