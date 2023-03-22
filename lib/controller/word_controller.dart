import 'package:get/get.dart';
import 'package:japanese_voca/data_format.dart';
import 'package:japanese_voca/model/step.dart';
import 'package:japanese_voca/model/word.dart';
import 'package:japanese_voca/repository/localRepository.dart';

class WordController extends GetxController {
  // List<List<Word>> words = [];
  List<StepHive> step = [];
  late List<List<StepHive>> splitedStep;
  // List<List<int>> scores = [];
  late LocalReposotiry localReposotiry;

  WordController() {
    splitedStep = List.generate(hiragas.length, (index) => []);

    localReposotiry = LocalReposotiry();

    step = localReposotiry.getAllStep();

    for (int i = 0; i < step.length; i++) {
      String headTitle = step[i].id.split('-')[0];
      print('headTitle: ${headTitle}');
      int index = hiragas.indexOf(headTitle);
      print('index: ${index}');

      splitedStep[hiragas.indexOf(headTitle)].add(step[i]);
    }
  }
}
