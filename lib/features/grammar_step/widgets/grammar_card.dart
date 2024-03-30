import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:japanese_voca/common/widget/dimentions.dart';
import 'package:japanese_voca/features/grammar_step/services/grammar_controller.dart';
import 'package:japanese_voca/features/grammar_step/widgets/gammar_card_details.dart';
import 'package:japanese_voca/model/grammar.dart';

import '../../../common/admob/controller/ad_controller.dart';

// ignore: must_be_immutable
class GrammarCard extends StatefulWidget {
  const GrammarCard({
    Key? key,
    required this.index,
    required this.grammars,
  }) : super(key: key);
  final int index;
  final List<Grammar> grammars;

  @override
  State<GrammarCard> createState() => _GrammarCardState();
}

class _GrammarCardState extends State<GrammarCard> {
  late PageController pageController;
  bool isWantToSee = false;
  AdController adController = Get.find<AdController>();

  void toggleWantToSee() {
    isWantToSee = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    GrammarController controller = Get.find<GrammarController>();
    return InkWell(
      onTap: () => Get.to(() =>
          GrammarCardDetails(grammars: widget.grammars, index: widget.index)),
      child: Container(
        decoration: BoxDecoration(border: Border.all(width: 0.3)),
        child: ListTile(
          isThreeLine: true,
          minLeadingWidth: 150,
          title: Text(
            widget.grammars[widget.index].grammar,
            style: TextStyle(
              fontSize: Responsive.height16,
              fontWeight: FontWeight.w600,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          subtitle: isWantToSee || controller.isSeeMean
              ? Text(
                  widget.grammars[widget.index].means,
                )
              : InkWell(
                  onTap: toggleWantToSee,
                  child: Container(
                    height: 16,
                    width: double.infinity,
                    color: Colors.grey,
                  ),
                ),
        ),
      ),
    );
  }
}
