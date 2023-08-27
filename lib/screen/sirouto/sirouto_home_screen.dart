import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:japanese_voca/screen/sirouto/components/hiragana_card.dart';

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
