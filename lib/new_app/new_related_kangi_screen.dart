import 'package:flutter/material.dart';
import 'package:japanese_voca/new_app/models/new_kangi.dart';
import 'package:japanese_voca/new_app/new_study/components/new_study_card.dart';
import 'package:japanese_voca/new_app/models/new_japanese.dart';

class NewRelatedKangiScreen extends StatefulWidget {
  const NewRelatedKangiScreen({super.key, required this.voca});

  final NewKangi voca;
  @override
  State<NewRelatedKangiScreen> createState() => _NewRelatedKangiScreenState();
}

class _NewRelatedKangiScreenState extends State<NewRelatedKangiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
            // child: NewStudyCard(japanese: widget.voca),
            ),
      ),
    );
  }
}
