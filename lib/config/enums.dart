enum TextInputEnum { JAPANESE, YOMIKATA, MEAN, EXAMPLE_JAPANESE, EXAMPLE_MEAN }

extension TextInputEnumExtensions on TextInputEnum {
  String get name {
    switch (this) {
      case TextInputEnum.JAPANESE:
        return '일본어';
      case TextInputEnum.YOMIKATA:
        return '읽는 법';
      case TextInputEnum.MEAN:
        return '의미';

      case TextInputEnum.EXAMPLE_JAPANESE:
        return '예제 (예문)';
      case TextInputEnum.EXAMPLE_MEAN:
        return '예제 (의미)';
    }
  }
}

enum MyVocaPageFilter1 { ALL_VOCA, KNOWN_VOCA, UNKNOWN_VOCA }

enum MyVocaPageFilter2 { JAPANESE, MEAN }

extension Filter1Extension on MyVocaPageFilter1 {
  String get id {
    switch (this) {
      case MyVocaPageFilter1.ALL_VOCA:
        return '모든 단어';
      case MyVocaPageFilter1.KNOWN_VOCA:
        return '암기 단어';
      case MyVocaPageFilter1.UNKNOWN_VOCA:
        return '미암기 단어';
    }
  }
}

extension Filter2Extension on MyVocaPageFilter2 {
  String get id {
    switch (this) {
      case MyVocaPageFilter2.JAPANESE:
        return '일본어';
      case MyVocaPageFilter2.MEAN:
        return '의미';
    }
  }
}
