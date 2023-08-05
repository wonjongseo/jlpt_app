import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/screen/grammar/grammar_step_screen.dart';
import 'package:japanese_voca/screen/home/components/welcome_widget.dart';
import 'package:japanese_voca/screen/home/services/home_controller.dart';
import 'package:japanese_voca/screen/home/services/home_tutorial_service.dart';
import 'package:japanese_voca/screen/my_voca/my_voca_sceen.dart';
import 'package:japanese_voca/screen/user/controller/user_controller.dart';
import 'package:japanese_voca/screen/home/components/users_word_button.dart';
import 'package:kanji_drawing_animation/kanji_drawing_animation.dart';

import '../../common/admob/banner_ad/global_banner_admob.dart';
import '../../common/widget/part_of_information.dart';
import '../../config/colors.dart';
import '../../config/theme.dart';
import '../../how_to_use_screen.dart';
import '../my_voca/controller/my_voca_controller.dart';
import '../setting/setting_screen.dart';

const String HOME_PATH = '/home2';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    return Scaffold(
      key: homeController.scaffoldKey,
      endDrawer: _endDrawer(),
      body: _body(context, homeController),
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Drawer _endDrawer() {
    return Drawer(
      // backgroundColor: Colors.transparent,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            child: Text(
              '모두 일본어 공부 화이팅 !',
              style: TextStyle(
                color: AppColors.scaffoldBackground,
                fontFamily: AppFonts.nanumGothic,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.message),
            title: TextButton(
              onPressed: () {
                Get.back();
                Get.to(() => const HowToUseScreen());
              },
              child: const Text(
                '앱 설명 보기',
                style: TextStyle(
                  fontFamily: AppFonts.nanumGothic,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: AppColors.scaffoldBackground,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: TextButton(
              onPressed: () {
                Get.back();
                Get.toNamed(SETTING_PATH, arguments: {
                  'isSettingPage': true,
                });
              },
              child: const Text(
                '설정 페이지',
                style: TextStyle(
                  fontFamily: AppFonts.nanumGothic,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: AppColors.scaffoldBackground,
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.remove),
            title: TextButton(
              onPressed: () {
                Get.back();
                Get.toNamed(SETTING_PATH, arguments: {
                  'isSettingPage': false,
                });
              },
              child: const Text(
                '데이터 초기화',
                style: TextStyle(
                  fontFamily: AppFonts.nanumGothic,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: AppColors.scaffoldBackground,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  SafeArea _body(BuildContext context, HomeController homeController) {
    if (!homeController.isSeenTutorial) {
      homeController.homeTutorialService = HomeTutorialService();
      homeController.homeTutorialService?.initTutorial();
      homeController.homeTutorialService?.showTutorial(context);
      homeController.isSeenTutorial = true;
    }

    return SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: WelcomeWidget(
                isUserPremieum: homeController.userController.isUserPremieum(),
                settingKey: homeController.homeTutorialService?.settingKey,
                scaffoldKey: homeController.scaffoldKey),
          ),
          Expanded(
            flex: 9,
            child: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 5,
              controller: homeController.pageController,
              itemBuilder: (context, index) {
                const edgeInsets = EdgeInsets.symmetric(horizontal: 20 * 0.7);
                return GetBuilder<UserController>(
                  builder: (userController) {
                    // if (index == 5) {
                    //   //왕초보
                    //   return Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //     children: [
                    //       InkWell(
                    //           onTap: () {
                    //             Get.to(() => SiroutoScreen(text: '히리가나'));
                    //           },
                    //           child: const SiroutoBox(text: '히라가나')),
                    //       // const SizedBox(width: 30),
                    //       InkWell(
                    //           onTap: () {},
                    //           child: const SiroutoBox(text: '카타카나')),
                    //     ],
                    //   );
                    // }

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          PartOfInformation(
                            goToSutdy: () => homeController
                                .goToJlptStudy((index + 1).toString()),
                            text: 'JLPT 단어',
                            currentProgressCount: userController
                                .user.currentJlptWordScroes[index],
                            totalProgressCount:
                                userController.user.jlptWordScroes[index],
                            edgeInsets: edgeInsets,
                            homeTutorialService:
                                homeController.homeTutorialService,
                          ),
                          if (index < 3)
                            PartOfInformation(
                              goToSutdy: () => Get.to(() => GrammarStepSceen(
                                  level: (index + 1).toString())),
                              text: 'JLPT 문법',
                              currentProgressCount: userController
                                  .user.currentGrammarScores[index],
                              totalProgressCount:
                                  userController.user.grammarScores[index],
                              edgeInsets: edgeInsets,
                            ),
                          PartOfInformation(
                            goToSutdy: () => homeController
                                .goToKangiScreen((index + 1).toString()),
                            text: 'JLPT 한자',
                            currentProgressCount:
                                userController.user.currentKangiScores[index],
                            totalProgressCount:
                                userController.user.kangiScores[index],
                            edgeInsets: edgeInsets,
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Expanded(
                    child: FadeInLeft(
                      child: UserWordButton(
                        textKey: homeController.homeTutorialService?.myVocaKey,
                        text: '나만의 단어장',
                        onTap: () {
                          Get.toNamed(
                            MY_VOCA_PATH,
                            arguments: {MY_VOCA_TYPE: MyVocaEnum.MY_WORD},
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: FadeInLeft(
                      child: UserWordButton(
                        textKey:
                            homeController.homeTutorialService?.wrongWordKey,
                        text: '자주 틀리는 단어',
                        onTap: () {
                          Get.toNamed(
                            MY_VOCA_PATH,
                            arguments: {
                              MY_VOCA_TYPE: MyVocaEnum.WRONG_WORD,
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _bottomNavigationBar() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GetBuilder<HomeController>(builder: (homeController) {
          return BottomNavigationBar(
            currentIndex: homeController.currentPageIndex,
            onTap: homeController.pageChange,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            items: [
              BottomNavigationBarItem(
                  icon: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: homeController.currentPageIndex == 0
                          ? AppColors.primaryColor
                          : AppColors.whiteGrey,
                    ),
                    child: Text(
                      key: homeController
                          .homeTutorialService?.bottomNavigationBarKey,
                      'N1',
                      style: const TextStyle(
                        color: AppColors.scaffoldBackground,
                      ),
                    ),
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: homeController.currentPageIndex == 1
                            ? AppColors.primaryColor
                            : AppColors.whiteGrey),
                    child: const Text(
                      'N2',
                      style: TextStyle(
                        color: AppColors.scaffoldBackground,
                      ),
                    ),
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: homeController.currentPageIndex == 2
                            ? AppColors.primaryColor
                            : AppColors.whiteGrey),
                    child: const Text(
                      'N3',
                      style: TextStyle(
                        color: AppColors.scaffoldBackground,
                      ),
                    ),
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: homeController.currentPageIndex == 3
                              ? AppColors.primaryColor
                              : AppColors.whiteGrey),
                      child: const Text(
                        'N4',
                        style: TextStyle(
                          color: AppColors.scaffoldBackground,
                        ),
                      )),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: homeController.currentPageIndex == 4
                            ? AppColors.primaryColor
                            : AppColors.whiteGrey),
                    child: const Text(
                      'N5',
                      style: TextStyle(
                        color: AppColors.scaffoldBackground,
                      ),
                    ),
                  ),
                  label: ''),
              // BottomNavigationBarItem(
              //     icon: Container(
              //       padding: const EdgeInsets.all(14),
              //       decoration: BoxDecoration(
              //           shape: BoxShape.circle,
              //           color: homeController.currentPageIndex == 4
              //               ? AppColors.primaryColor
              //               : AppColors.whiteGrey),
              //       child: const Text(
              //         '왕초보',
              //         style: TextStyle(
              //           color: AppColors.scaffoldBackground,
              //         ),
              //       ),
              //     ),
              //     label: ''),
            ],
          );
        }),
        const GlobalBannerAdmob()
      ],
    );
  }
}

class SiroutoBox extends StatelessWidget {
  const SiroutoBox({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 35),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        color: AppColors.whiteGrey,
        boxShadow: [
          const BoxShadow(
            color: Colors.white,
            offset: Offset(1, 1),
          ),
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            offset: const Offset(3, 3),
          ),
        ],
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.scaffoldBackground,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class SiroutoScreen extends StatefulWidget {
  const SiroutoScreen({super.key, required this.text});

  final String text;
  @override
  State<SiroutoScreen> createState() => _SiroutoScreenState();
}

class _SiroutoScreenState extends State<SiroutoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.text),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              hiraganas.length,
              (index) {
                return HiraganaCard(hiragana: hiraganas[index]);
              },
            ),
            // child: GridView.builder(
            //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //     crossAxisCount: 2,
            //     crossAxisSpacing: 10.0,
            //     mainAxisSpacing: 5.0,
            //   ),
            //   itemCount: hiraganas.length,
            //   itemBuilder: (context, index) {
            //     return Center(child: Text(hiraganas[index]['hiragana']));
            //   },
            // ),
          ),
        ));
  }
}

class HiraganaCard extends StatefulWidget {
  const HiraganaCard({
    super.key,
    required this.hiragana,
  });
  final Map hiragana;

  @override
  State<HiraganaCard> createState() => _HiraganaCardState();
}

class _HiraganaCardState extends State<HiraganaCard> {
  bool isClicked = false;
  late String value;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    value = widget.hiragana['related'][0];
  }

  @override
  Widget build(BuildContext context) {
    print('value: ${value}');
    return DecoratedBox(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.redAccent,
              Colors.blueAccent,
              Colors.purpleAccent
              //add more colors
            ]),
            borderRadius: BorderRadius.circular(5),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                  blurRadius: 5) //blur radius of shadow
            ]),
        child: Padding(
            padding: EdgeInsets.only(left: 30, right: 30),
            child: DropdownButton(
              value: "menuone",
              items: [
                DropdownMenuItem(
                  child: Text("Menu One"),
                  value: "menuone",
                )
              ],
              onChanged: (value) {},
              isExpanded: true, //make true to take width of parent widget
              underline: Container(), //empty line
              style: TextStyle(fontSize: 18, color: Colors.white),
              dropdownColor: Colors.green,
              iconEnabledColor: Colors.white, //Icon color
            )));
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          margin: const EdgeInsets.symmetric(vertical: 10),
          width: 180,
          child: OutlinedButton(
            onPressed: isClicked
                ? null
                : () {
                    setState(() {
                      isClicked = !isClicked;
                    });
                  },
            child: !isClicked
                ? Text(
                    widget.hiragana['hiragana'],
                    style: const TextStyle(
                      color: AppColors.lightGrey,
                    ),
                  )
                : Container(
                    width: 220,
                    // padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                        color: Colors
                            .lightGreen, //background color of dropdown button
                        border: Border.all(
                            color: Colors.black38,
                            width: 3), //border of dropdown button
                        borderRadius: BorderRadius.circular(
                            50), //border raiuds of dropdown button
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Color.fromRGBO(
                                  0, 0, 0, 0.57), //shadow for button
                              blurRadius: 5) //blur radius of shadow
                        ]),
                    child: DropdownButton<String>(
                        value: value,
                        items: List.generate(
                          (widget.hiragana['related'] as List).length,
                          (index) => DropdownMenuItem(
                            value: widget.hiragana['related'][index],
                            child: Text(
                              widget.hiragana['related'][index],
                              style: TextStyle(color: Colors.blueAccent),
                            ),
                          ),
                        ),
                        icon: Padding(
                            //Icon at tail, arrow bottom is default icon
                            padding: EdgeInsets.only(left: 20),
                            child: Icon(Icons.arrow_circle_down_sharp)),
                        iconEnabledColor: Colors.white, //Icon color
                        style: TextStyle(
                            //te
                            color: Colors.white, //Font color
                            fontSize: 20 //font size on dropdown button
                            ),
                        dropdownColor:
                            Colors.redAccent, //dropdown background color
                        underline: Container(), //remove underline
                        isExpanded: true,
                        onChanged: (String? a) {
                          setState(() {
                            value = a!;
                          });
                          print('a: ${a}');
                        }),
                  ),
          ),
        ),
        if (isClicked)
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Get.bottomSheet(SizedBox(
                        width: double.infinity,
                        child: KanjiDrawingAnimation(value, speed: 60),
                      ));
                    },
                    child: Text('획순'))
              ],
            ),
          )
      ],
    );
  }
}

List<Map<String, dynamic>> hiraganas = [
  {
    'hiragana': 'あ',
    'related': [
      'あ',
      'あ1',
      'あ2',
      'あ3',
      'あ4',
    ]
  },
  {
    'hiragana': 'か',
    'related': [
      'か',
      'あ1',
      'あ2',
      'あ3',
      'あ4',
    ]
  },
  {
    'hiragana': 'さ',
    'related': [
      'さ',
      'あ1',
      'あ2',
      'あ3',
      'あ4',
    ]
  },
  {
    'hiragana': 'た',
    'related': [
      'た',
      'あ1',
      'あ2',
      'あ3',
      'あ4',
    ]
  },
  {
    'hiragana': 'な',
    'related': [
      'な',
      'あ1',
      'あ2',
      'あ3',
      'あ4',
    ]
  },
  {
    'hiragana': 'は',
    'related': [
      'は',
      'あ1',
      'あ2',
      'あ3',
      'あ4',
    ]
  },
  {
    'hiragana': 'ま',
    'related': [
      'ま',
      'あ1',
      'あ2',
      'あ3',
      'あ4',
    ]
  },
  {
    'hiragana': 'や',
    'related': [
      'や',
      'あ1',
      'あ2',
      'あ3',
      'あ4',
    ]
  },
  {
    'hiragana': 'ら',
    'related': [
      'ら',
      'あ1',
      'あ2',
      'あ3',
      'あ4',
    ]
  },
  {
    'hiragana': 'わ',
    'related': [
      'わ',
      'あ1',
      'あ2',
      'あ3',
      'あ4',
    ]
  },
  {
    'hiragana': 'ん',
    'related': [
      'ん',
      'あ1',
      'あ2',
      'あ3',
      'あ4',
    ]
  },
];
