import 'package:get/get.dart';
import 'package:japanese_voca/model/word.dart';
import 'package:japanese_voca/repository/localRepository.dart';

class WordController extends GetxController {
  List<List<Word>> words = [];
  List<List<int>> scores = [];
  late LocalReposotiry localReposotiry;

  WordController() {
    localReposotiry = LocalReposotiry();

    words = localReposotiry.getWord();

    for (List<Word> aa in words) {
      print('aa[0].headTitle: ${aa[0].headTitle}');
    }
  }
}
