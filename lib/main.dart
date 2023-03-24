import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/app.dart';
import 'package:japanese_voca/controller/word_controller.dart';
import 'package:japanese_voca/data_format.dart';
import 'package:japanese_voca/model/word.dart';
import 'package:japanese_voca/repository/localRepository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const App());
}
