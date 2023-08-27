import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:kanji_drawing_animation/kanji_drawing_animation.dart';

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
