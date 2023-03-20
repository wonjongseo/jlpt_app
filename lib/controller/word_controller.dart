import 'package:get/get.dart';
import 'package:japanese_voca/model/word.dart';
import 'package:japanese_voca/repository/localRepository.dart';

class WordController extends GetxController {
  List<List<Word>> words = [];
  late LocalReposotiry localReposotiry;

  WordController() {
    localReposotiry = LocalReposotiry();

    words = localReposotiry.getWord();

    print('words[0]: ${words[0]}');
  }
}
