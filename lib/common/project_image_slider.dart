import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:japanese_voca/common/Images.dart';

class ProjectImageSlider extends StatefulWidget {
  const ProjectImageSlider({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;
  @override
  State<ProjectImageSlider> createState() => _ProjectImageSliderState();
}

class _ProjectImageSliderState extends State<ProjectImageSlider> {
  CarouselController carouselController = CarouselController();
  int currentIndex = 0;
  ProjectImage projectImage = ProjectImage();
  void changeIndexOfSlider(int newIndex) {
    setState(() {
      currentIndex = newIndex;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (width > 450)
              IconButton(
                  style: IconButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  onPressed: () {
                    carouselController.previousPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut);
                  },
                  icon: const Icon(Icons.arrow_left)),
            SizedBox(
              width: width > 450 ? 1000 : 250,
              height: width > 450 ? 600 : 500,
              child: Column(
                children: [
                  CarouselSlider(
                    carouselController: carouselController,
                    options: CarouselOptions(
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 4),
                      aspectRatio: 2.0,
                      enlargeCenterPage: true,
                      height: width > 450 ? 550 : 450,
                      onPageChanged: (index, reason) {
                        changeIndexOfSlider(index);
                      },
                    ),
                    items: List.generate(
                      projectImage.jlptWordimages[widget.index].length,
                      (index) => Container(
                        margin: const EdgeInsets.all(5.0),
                        child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5.0)),
                            child: Stack(
                              children: <Widget>[
                                Image.asset(projectImage
                                    .jlptWordimages[widget.index][index]),
                                Positioned(
                                  bottom: 0.0,
                                  left: 0.0,
                                  right: 0.0,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color.fromARGB(200, 0, 0, 0),
                                          Color.fromARGB(0, 0, 0, 0)
                                        ],
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.topCenter,
                                      ),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10.0, horizontal: 20.0),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: projectImage.jlptWordimages[widget.index]
                        .asMap()
                        .entries
                        .map((entry) {
                      return Expanded(
                        child: GestureDetector(
                          onTap: () =>
                              carouselController.animateToPage(entry.key),
                          child: Container(
                            width: 12.0,
                            height: 12.0,
                            margin: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 4.0),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black)
                                    .withOpacity(
                                        currentIndex == entry.key ? 0.9 : 0.4)),
                          ),
                        ),
                      );
                    }).toList(),
                  )
                ],
              ),
            ),
            if (width > 450)
              IconButton(
                  onPressed: () {
                    carouselController.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut);
                  },
                  icon: const Icon(Icons.arrow_right)),
          ],
        ),
        Text(
          projectImage.jlptWorddesciprions[widget.index][currentIndex],
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(fontSize: 20, color: Colors.white),
        )
      ],
    );
  }
}
