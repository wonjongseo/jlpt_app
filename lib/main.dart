import 'package:flutter/material.dart';
import 'package:japanese_voca/app.dart';
import 'package:japanese_voca/repository/localRepository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalReposotiry.init();
  runApp(const App());
}
