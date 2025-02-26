import 'package:get/get.dart';
import 'package:japanese_voca/config/string.dart';

enum JlptCategoryEnum { Japaneses, Grammars, Kangis }

extension CategoryEnumExtension on JlptCategoryEnum {
  String get id {
    switch (this) {
      case JlptCategoryEnum.Japaneses:
        return AppString.japanese.tr;
      case JlptCategoryEnum.Grammars:
        return AppString.grammar.tr;
      case JlptCategoryEnum.Kangis:
        return AppString.kanji.tr;
    }
  }
}

enum TextInputEnum { JAPANESE, YOMIKATA, MEAN, EXAMPLE_JAPANESE, EXAMPLE_MEAN }

extension TextInputEnumExtensions on TextInputEnum {
  String get name {
    switch (this) {
      case TextInputEnum.JAPANESE:
        return AppString.japanese.tr;
      case TextInputEnum.YOMIKATA:
        return AppString.pronunciation.tr;
      case TextInputEnum.MEAN:
        return AppString.mean.tr;

      case TextInputEnum.EXAMPLE_JAPANESE:
        return '${AppString.example.tr} (${AppString.sentence.tr})';
      case TextInputEnum.EXAMPLE_MEAN:
        return '${AppString.example.tr} (${AppString.mean.tr})';
    }
  }
}

enum MyVocaPageFilter1 { ALL_VOCA, KNOWN_VOCA, UNKNOWN_VOCA }

enum MyVocaPageFilter2 { JAPANESE, MEAN }

extension Filter1Extension on MyVocaPageFilter1 {
  String get id {
    switch (this) {
      case MyVocaPageFilter1.ALL_VOCA:
        return AppString.allVoca.tr;
      case MyVocaPageFilter1.KNOWN_VOCA:
        return AppString.onlyLearned.tr;
      case MyVocaPageFilter1.UNKNOWN_VOCA:
        return AppString.onlyUnLearned.tr;
    }
  }
}

extension Filter2Extension on MyVocaPageFilter2 {
  String get id {
    switch (this) {
      case MyVocaPageFilter2.JAPANESE:
        return AppString.japanese.tr;
      case MyVocaPageFilter2.MEAN:
        return AppString.mean.tr;
    }
  }
}
