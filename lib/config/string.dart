import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          AppString.appName: AppString.appNameEn,
          AppString.searchHintText: AppString.searchHintTextEn,
          AppString.kindOfStudyBasic: AppString.kindOfStudyBasicEn,
          AppString.kindOfStudyMy: AppString.kindOfStudyMyEn,
          AppString.book: AppString.bookEn,
          AppString.vocabulary: AppString.vocabularyEn,

          AppString.japanese: AppString.japaneseEn,
          AppString.grammar: AppString.grammarEn,
          AppString.kanji: AppString.kanjiEn,
          AppString.hiragana: AppString.hiraganaEn,
          AppString.katakana: AppString.katakanaEn,
          AppString.hiraganaDescription: AppString.hiraganaDescriptionEn,
          AppString.katakanaDescription: AppString.katakanaDescriptionEn,
          AppString.setting: AppString.settingEn,
          AppString.initDatas: AppString.initDatasEn,
          AppString.tipOffMessage: AppString.tipOffMessageEn,
          AppString.toogleMeaning: AppString.toogleMeaningEn,
          AppString.toogleHowToRead: AppString.toogleHowToReadEn,
          AppString.loadingDatas: AppString.loadingDatasEn,
          //
          AppString.quiz: AppString.quizEn,
          AppString.selectAll: AppString.selectAllEn,
          AppString.chapter: AppString.chapterEn,
          AppString.yesBtn: AppString.yesBtnEn,
          AppString.noBtn: AppString.noBtnEn,

          AppString.previousTestRequiredMsg1:
              AppString.previousTestRequiredMsg1En,
          AppString.previousTestRequiredMsg2:
              AppString.previousTestRequiredMsg2En,
          AppString.previousTestRequiredMsg3:
              AppString.previousTestRequiredMsg3En,
          AppString.previousTestRequiredMsg4:
              AppString.previousTestRequiredMsg4En,

          AppString.askGoToMyVocaPageMsg1: AppString.askGoToMyVocaPageMsg1En,
          AppString.askGoToMyVocaPageMsg2: AppString.askGoToMyVocaPageMsg2En,
          AppString.askGoToMyVocaPageMsg3: AppString.askGoToMyVocaPageMsg3En,
          AppString.myBook: AppString.myBookEn,
          AppString.savedVoca: AppString.savedVocaEn,
          AppString.savedVocaSuffic: AppString.savedVocaSufficEn,
          AppString.myBook1Description: AppString.myBook1DescriptionEn,
          AppString.myBook2Description: AppString.myBook2DescriptionEn,
          AppString.deleteAllBtn: AppString.deleteAllBtnEn,
          AppString.addBtn: AppString.addBtnEn,
          AppString.doQuizBtn: AppString.doQuizBtnEn,
          AppString.allVoca: AppString.allVocaEn,

          AppString.onlyLearned: AppString.onlyLearnedEn,
          AppString.onlyUnLearned: AppString.onlyUnLearnedEn,
          AppString.fillter: AppString.fillterEn,
          AppString.mean: AppString.meanEn,
          AppString.inputManually: AppString.inputManuallyEn,
          AppString.importExcel: AppString.importExcelEn,
          AppString.textFieldRequried: AppString.textFieldRequriedEn,
          AppString.pronunciation: AppString.pronunciationEn,
          AppString.example: AppString.exampleEn,
          AppString.sentence: AppString.sentenceEn,
          AppString.saveBtn: AppString.saveBtnEn,
          AppString.delete: AppString.deleteEn,
          AppString.addExampleBtn: AppString.addExampleBtnEn,
          AppString.open: AppString.openEn,
          AppString.hold: AppString.holdEn,
          AppString.changeToLearn: AppString.changeToLearnEn,
          AppString.changeToUnLearn: AppString.changeToUnLearnEn,
          AppString.savedDate: AppString.savedDateEn,
          AppString.fnOrErorreport: AppString.fnOrErorreportEn,
          AppString.reportMsgContect: AppString.reportMsgContectEn,
          AppString.errorCreateEmail1: AppString.errorCreateEmail1En,
          AppString.errorCreateEmail2: AppString.errorCreateEmail2En,
          AppString.copyWordMsg: AppString.copyWordMsgEn,
          AppString.close: AppString.closeEn,
          AppString.shortAnswerQuestion: AppString.shortAnswerQuestionEn,
          AppString.shortAnswerHelp: AppString.shortAnswerHelpEn,
          AppString.shortAnswerToolTip: AppString.shortAnswerToolTipEn,
          AppString.finishSettingMgs: AppString.finishSettingMgsEn,

          AppString.howToUseMsg1: AppString.howToUseMsg1En,

          AppString.howToUseMsg2: AppString.howToUseMsg2En,
          AppString.howToUseMsg3: AppString.howToUseMsg3En,
          AppString.howToUseMsg4: AppString.howToUseMsg4En,
          AppString.howToUseMsg5: AppString.howToUseMsg5En,
          AppString.howToUseMsg6: AppString.howToUseMsg6En,
          AppString.howToUseMsg7: AppString.howToUseMsg7En,
          AppString.howToUseMsg8: AppString.howToUseMsg8En,

          AppString.howToUseMsg8: AppString.howToUseMsg8En,

          AppString.howToUseMsg9: AppString.howToUseMsg9En,
          AppString.howToUseMsg10: AppString.howToUseMsg10En,
          AppString.howToUseMsg11: AppString.howToUseMsg11En,
          AppString.howToUseMsg12: AppString.howToUseMsg12En,
          AppString.howToUseMsg14: AppString.howToUseMsg14En,
          AppString.howToUseMsg15: AppString.howToUseMsg15En,
          AppString.howToUseMsg16: AppString.howToUseMsg16En,
          AppString.howToUseMsg17: AppString.howToUseMsg17En,
          AppString.howToUseMsg18: AppString.howToUseMsg18En,
          AppString.howToUseMsg19: AppString.howToUseMsg19En,
          AppString.howToUseMsg20: AppString.howToUseMsg20En,
          AppString.howToUseMsg21: AppString.howToUseMsg21En,
          AppString.howToUseMsg22: AppString.howToUseMsg22En,
          AppString.howToUseMsg23: AppString.howToUseMsg23En,
          AppString.howToUseMsg24: AppString.howToUseMsg24En,
          AppString.howToUseMsg25: AppString.howToUseMsg25En,
          AppString.howToUseMsg26: AppString.howToUseMsg26En,
          AppString.howToUseMsg27: AppString.howToUseMsg27En,
          AppString.howToUseMsg28: AppString.howToUseMsg28En,
          AppString.howToUseMsg29: AppString.howToUseMsg29En,
          AppString.howToUseMsg30: AppString.howToUseMsg30En,
        },
        'ko_KR': {
          AppString.appName: AppString.appNameKr,
          AppString.searchHintText: AppString.searchHintTextKr,
          AppString.kindOfStudyBasic: AppString.kindOfStudyBasicKr,
          AppString.kindOfStudyMy: AppString.kindOfStudyMyKr,
          AppString.book: AppString.bookKr,
          AppString.vocabulary: AppString.vocabularyKr,
          AppString.japanese: AppString.japaneseKr,
          AppString.grammar: AppString.grammarKr,
          AppString.kanji: AppString.kanjiKr,
          AppString.hiragana: AppString.hiraganaKr,
          AppString.katakana: AppString.katakanaKr,
          AppString.hiraganaDescription: AppString.hiraganaDescriptionKr,
          AppString.katakanaDescription: AppString.katakanaDescriptionKr,
          AppString.setting: AppString.settingKr,
          AppString.initDatas: AppString.initDatasKr,
          AppString.tipOffMessage: AppString.tipOffMessageKr,
          AppString.toogleMeaning: AppString.toogleMeaningKr,
          AppString.toogleHowToRead: AppString.toogleHowToReadKr,
          AppString.loadingDatas: AppString.loadingDatasKr,
          AppString.quiz: AppString.quizKr,
          AppString.selectAll: AppString.selectAllKr,
          AppString.chapter: AppString.chapterKr,
          AppString.yesBtn: AppString.yesBtnKr,
          AppString.noBtn: AppString.noBtnKr,
          AppString.previousTestRequiredMsg1:
              AppString.previousTestRequiredMsg1Kr,
          AppString.previousTestRequiredMsg2:
              AppString.previousTestRequiredMsg2Kr,
          AppString.previousTestRequiredMsg3:
              AppString.previousTestRequiredMsg3Kr,
          AppString.previousTestRequiredMsg4:
              AppString.previousTestRequiredMsg4Kr,
          AppString.askGoToMyVocaPageMsg1: AppString.askGoToMyVocaPageMsg1Kr,
          AppString.askGoToMyVocaPageMsg2: AppString.askGoToMyVocaPageMsg2Kr,
          AppString.askGoToMyVocaPageMsg3: AppString.askGoToMyVocaPageMsg3Kr,
          AppString.myBook: AppString.myBookKr,
          AppString.savedVoca: AppString.savedVocaKr,
          AppString.savedVocaSuffic: AppString.savedVocaSufficKr,
          AppString.myBook1Description: AppString.myBook1DescriptionKr,
          AppString.myBook2Description: AppString.myBook2DescriptionKr
        },
        'ja_JP': {
          AppString.searchHintText: AppString.searchHintTextKr,
        },
      };
}

class AppString {
  static String appName = "appNameTr";
  static String appNameKr = "JLPT종각";
  static String appNameEn = "Jong's JLPT";

  static String searchHintText = "searchHintTextTr";
  static String searchHintTextKr = " 일본어/한자/문법 검색...";
  static String searchHintTextEn = " Search Any Japanese/Kangi/Grammar...";

  static String kindOfStudyBasic = "kindOfStudyBasicTr";
  static String kindOfStudyBasicKr = "왕초보";
  static String kindOfStudyBasicEn = "Newbies";

  static String kindOfStudyMy = "kindOfStudyMyTr";
  static String kindOfStudyMyKr = "나만의";
  static String kindOfStudyMyEn = "My";

  static String book = "bookTr";
  static String bookKr = "단어장";
  static String bookEn = "Book";

  static String vocabulary = "vocabularyTr";
  static String vocabularyKr = "단어";
  static String vocabularyEn = "vocabulary";

  static String japanese = "japaneseTr";
  static String japaneseKr = "일본어";
  static String japaneseEn = "japanese";

  static String grammar = "grammarTr";
  static String grammarKr = "문법";
  static String grammarEn = "grammar";

  static String kanji = "kanjiTr";
  static String kanjiKr = "한자";
  static String kanjiEn = "kanji";

  static String hiragana = "hiraganaTr";
  static String hiraganaKr = "히라가나";
  static String hiraganaEn = "Hiragana";

  static String katakana = "katakanaTr";
  static String katakanaKr = "카타카나";
  static String katakanaEn = "Katakana";

  static String hiraganaDescription = "hiraganaDescriptionTr";
  static String hiraganaDescriptionKr = '왕초보를 위한 히라가나 단어장';
  static String hiraganaDescriptionEn = "A hiragana vocabulary for newbies";

  static String katakanaDescription = "katakanaDescriptionTr";
  static String katakanaDescriptionKr = '왕초보를 위한 히라가나 단어장';
  static String katakanaDescriptionEn = "A hiragana vocabulary for newbies";

  static String setting = "settingTr";
  static String settingKr = '설정';
  static String settingEn = "Settings";

  static String initDatas = "initDatasTr";
  static String initDatasKr = '데이터 초기화';
  static String initDatasEn = "Initialize data";

  static String tipOffMessage = "tipOffMessageTr";
  static String tipOffMessageKr = '제보는 개발자에게 아주 큰 힘이 됩니다!';
  static String tipOffMessageEn = "The tip-off is a huge boost for developers!";

  static String toogleMeaning = "toogleMeaningTr";
  static String toogleMeaningKr = '뜻 가리기';
  static String toogleMeaningEn = "Toogle Mean";

  static String toogleHowToRead = "toogleHowToReadTr";
  static String toogleHowToReadKr = '읽는 법 가리기';
  static String toogleHowToReadEn = "Toogle Pron";

  static String loadingDatas = "loadingDatasTr";
  static String loadingDatasKr = '데이터를 불러오는 중 입니다.';
  static String loadingDatasEn = "Loading Data.";

  static String quiz = "quizTr";
  static String quizKr = '퀴즈!';
  static String quizEn = "Quiz!";

  static String selectAll = "selectAllTr";
  static String selectAllKr = '전체 선택';
  static String selectAllEn = "Select All";

  static String chapter = "chapterTr";
  static String chapterKr = '챕터';
  static String chapterEn = "Chapter";

  static String yesBtn = "yesBtnTr";
  static String yesBtnKr = '네!';
  static String yesBtnEn = "Yes!";

  static String noBtn = "noBtnTr";
  static String noBtnKr = '아뇨!';
  static String noBtnEn = "No!";

  static String previousTestRequiredMsg1 = "previousTestRequiredMsg1Tr";
  static String previousTestRequiredMsg1Kr = '다음 단계로 넘어가기 위해서 해당 챕터의\n퀴즈에서';
  static String previousTestRequiredMsg1En = "You need to get";

  static String previousTestRequiredMsg2 = "previousTestRequiredMsg2Tr";
  static String previousTestRequiredMsg2Kr = ' 100점';
  static String previousTestRequiredMsg2En = " 100 points";

  static String previousTestRequiredMsg3 = "previousTestRequiredMsg3Tr";
  static String previousTestRequiredMsg3Kr = '을 맞으셔야 합니다!';
  static String previousTestRequiredMsg3En =
      " on the quiz in that chapter to move on!";

  static String previousTestRequiredMsg4 = "previousTestRequiredMsg4Tr";
  static String previousTestRequiredMsg4Kr = '해당 챕터의 퀴즈를 보시겠습니까?';
  static String previousTestRequiredMsg4En =
      "Would you like to take a quiz for that chapter?";

  static String askGoToMyVocaPageMsg1 = "askGoToMyVocaPageMsg1Tr";
  static String askGoToMyVocaPageMsg1Kr = '단어가 ';
  static String askGoToMyVocaPageMsg1En = "More than ";

  static String askGoToMyVocaPageMsg2 = "askGoToMyVocaPageMsg2Tr";
  static String askGoToMyVocaPageMsg2Kr = '개 이상이나 저장되었어요!';
  static String askGoToMyVocaPageMsg2En = " vocabularies have been saved!";

  static String askGoToMyVocaPageMsg3 = "askGoToMyVocaPageMsg3Tr";
  static String askGoToMyVocaPageMsg3Kr = '나만의 단어장 1에서 저장했던 단어를 학습하시겠습니까?';
  static String askGoToMyVocaPageMsg3En =
      "Would you like to learn the vocas you saved in 'My Book 1'? ";

  static String myBook = "myBookTr";
  static String myBookKr = '나만의 단어장';
  static String myBookEn = "My Book";

  static String savedVoca = "savedVocaTr";
  static String savedVocaKr = '저장된 단어';
  static String savedVocaEn = "Saved";

  static String savedVocaSuffic = "savedVocaSufficTr";
  static String savedVocaSufficKr = '개';
  static String savedVocaSufficEn = " voca";

  static String myBook1Description = "myBook1DescriptionTr";
  static String myBook1DescriptionKr = '종각 앱에서 저장한 단어들을\n학습하는 단어장';
  static String myBook1DescriptionEn =
      "Book for learning the vocas saved by Jong's JLPT";

  static String myBook2Description = "myBook2DescriptionTr";
  static String myBook2DescriptionKr = '사용자가 직접 저장한 단어들을\n학습하는 단어장';
  static String myBook2DescriptionEn =
      "Book that users learn the vocas they save themselves";

  static String deleteAllBtn = "deleteAllBtnTr";
  static String deleteAllBtnKr = '전체 삭제';
  static String deleteAllBtnEn = "Delete All";

  static String addBtn = "addBtnTr";
  static String addBtnKr = '단어 추가';
  static String addBtnEn = "Add Voca";

  static String doQuizBtn = "doQuizBtnTr";
  static String doQuizBtnKr = '퀴즈 풀기';
  static String doQuizBtnEn = "Do Quiz";

  static String allVoca = "allVocaTr";
  static String allVocaKr = '모든 단어';
  static String allVocaEn = "All Vocas";

  static String onlyLearned = "onlyLearnedTr";
  static String onlyLearnedKr = '암기 단어';
  static String onlyLearnedEn = "Learned";

  static String onlyUnLearned = "onlyUnLearnedTr";
  static String onlyUnLearnedKr = '미암기 단어';
  static String onlyUnLearnedEn = "UnLearned";

  static String fillter = "fillterTr";
  static String fillterKr = '필터 ';
  static String fillterEn = "Filter ";

  static String mean = "meanTr";
  static String meanKr = '의미';
  static String meanEn = "Mean";

  static String inputManually = "inputManuallyTr";
  static String inputManuallyKr = '의미';
  static String inputManuallyEn = "Input manually";

  static String importExcel = "importExcelTr";
  static String importExcelKr = '의미';
  static String importExcelEn = "Import Excel File";

  static String textFieldRequried = "textFieldRequriedTr";
  static String textFieldRequriedKr = '을 입력해주세요.';
  static String textFieldRequriedEn = " is required";

  static String pronunciation = "pronunciationTr";
  static String pronunciationKr = '읽는 법';
  static String pronunciationEn = "Pronunciation";

  static String example = "exampleTr";
  static String exampleKr = '예제';
  static String exampleEn = "example";

  static String sentence = "sentenceTr";
  static String sentenceKr = '예문';
  static String sentenceEn = "sentence";

  static String saveBtn = "saveBtnTr";
  static String saveBtnKr = '단어 저장';
  static String saveBtnEn = "Save Voca";

  static String delete = "deleteTr";
  static String deleteKr = '삭제';
  static String deleteEn = "Delete";

  static String addExampleBtn = "addExampleBtnTr";
  static String addExampleBtnKr = '예제 추가';
  static String addExampleBtnEn = "Add Example";

  static String open = "openTr";
  static String openKr = '펼치기';
  static String openEn = "Open";

  static String hold = "holdTr";
  static String holdKr = '접기';
  static String holdEn = "Hold";

  static String changeToLearn = "changeToLearnTr";
  static String changeToLearnKr = '암기로 변경';
  static String changeToLearnEn = "Change to Learned";

  static String changeToUnLearn = "changeToUnLearnTr";
  static String changeToUnLearnKr = '암기로 변경';
  static String changeToUnLearnEn = "Change to UnLearned";

  static String savedDate = "savedDateTr";
  static String savedDateKr = '에 저장됨 ';
  static String savedDateEn = "Saved at ";

  static String fnOrErorreport = "fnOrErorreportTr";
  static String fnOrErorreportKr = '희망 기능 또는 에러 제보';
  static String fnOrErorreportEn = "Desired function\n or error report";

  static String reportMsgContect = "reportMsgContectTr";
  static String reportMsgContectKr =
      """

⭐️ [희망 기능 제보]


==========================

⭐️ [버그・오류 제보]

🔸 버그・오류 페이지 :　  
   예) 일본어 학습장 페이지 또는 나만의 단어장 페이지 

🔸 버그・오류 내용 :　
   예) 나만의 단어장에서 단어 추가를 하면 에러 발생


==========================

▪️이미지를 함께 첨부해주시면 버그・오류를 수정하는데 큰 도움이 됩니다!!▪️
""";
  static String reportMsgContectEn =
      """

⭐️ [희망 기능 제보]


==========================

⭐️ [Bug/Error report]

🔸Bug/Error page:　
    e.g.) Japanese book page or My book page

🔸Bug/Error Contents:　
    e.g.) Error occurs when adding vocas in My Book page


==========================

▪️If you attach the image together,
it will be very helpful in correcting bugs and errors! ▪️
""";
  static String errorCreateEmail1 = "errorCreateEmail1Tr";
  static String errorCreateEmail1Kr = '종각 앱에서 이메일을 작성하는데 실패하였습니다.';
  static String errorCreateEmail1En =
      "Jong's JLPT App failed to create an email";

  static String errorCreateEmail2 = "errorCreateEmail2Tr";
  static String errorCreateEmail2Kr =
      '핸드폰에 이메일 등록이 되어 있지 않으면 종각 앱에서 이메일을 작성하는데 어려움이 있습니다.\n별도의 이메일 앱에서 문의 해주시면 감사하겠습니다.\n\n이메일 visionwill3322@gmail.com을 복사하시겠습니까?';
  static String errorCreateEmail2En =
      "If you don't have an email account on your phone, it's difficult to write an email on the Jong's JLPT App.\nWe would appreciate it if you could contact us on another email app.\n\nAre you sure you want to copy email visionwill3322@gmail.com ";

  static String copyWordMsg = "copyWordMsgTr";
  static String copyWordMsgKr = '가\n 복사(Ctrl + C) 되었습니다.';
  static String copyWordMsgEn = " has been copied.";

  static String close = "closeTr";
  static String closeKr = '단기';
  static String closeEn = " Close";

  static String shortAnswerQuestion = "shortAnswerQuestionTr";
  static String shortAnswerQuestionKr = '주관식 문제';
  static String shortAnswerQuestionEn = "short-answer";

  static String shortAnswerHelp = "shortAnswerHelpTr";
  static String shortAnswerHelpKr = '읽는 법을 먼저 입력해주세요.';
  static String shortAnswerHelpEn = "Please enter the pronunciation first.";

  static String shortAnswerToolTip = "shortAnswerToolTipTr";
  static String shortAnswerToolTipKr =
      '1. 읽는 법을 입력하면 사지선다가 표시됩니다.\n2. 장음 (-, ー) 은 생략해도 됩니다.';
  static String shortAnswerToolTipEn =
      "1. If you enter pronunciation, you'll see the multiple choice.\n2. You can skip the long vowel. (-, ー).";

  static String finishSettingMgs = "finishSettingMgsTr";
  static String finishSettingMgsKr =
      '초기 설정이 완료 되었습니다.\n해당 설정들은 설정 페이지에서 재설정 할 수 있습니다.';
  static String finishSettingMgsEn =
      'The first settings are complete. You can be reset on the settings page.';

  static String howToUseMsg1 = "howToUseMsg1Tr";
  static String howToUseMsg1Kr = 'JLPT 종각 앱 사용 방법에 앞서.';
  static String howToUseMsg1En = "Before using the Jong's JLPT";

  static String howToUseMsg2 = "howToUseMsg2Tr";
  static String howToUseMsg2Kr = ' 개발자 본인은 일본어뿐만 아니라 모든 외국어의 학습에 가장 중요한 부분은 ';
  static String howToUseMsg2En = " The developer himself thing that ";

  static String howToUseMsg3 = "howToUseMsg3Tr";
  static String howToUseMsg3Kr = '어휘력';
  static String howToUseMsg3En = "vocabulary";

  static String howToUseMsg4 = "howToUseMsg4Tr";
  static String howToUseMsg4Kr = "이라고 생각합니다.\n\n";
  static String howToUseMsg4En =
      ' is the most important part of learning not only Japanese but also all foreign languages.\n\n';

  static String howToUseMsg5 = "howToUseMsg5Tr";
  static String howToUseMsg5Kr =
      " 많은 블로그나 유튜브에서 외국어 공부법 혹은 외국어 단어 암기법이라고 검색하면 ";

  static String howToUseMsg5En =
      ' Many blogs and YouTube videos emphasize that vocabulary is important ';

  static String howToUseMsg6 = "howToUseMsg6Tr";
  static String howToUseMsg6Kr = '어휘력이 중요하다고 강조하고 있고, 어휘력은 단순 암기이기 때문에 ';
  static String howToUseMsg6En =
      "when you search for foreign language study or foreign word memorization, and that repeated learning is important so that ";

  static String howToUseMsg7 = "howToUseMsg7Tr";
  static String howToUseMsg7Kr = "잊어 버리지 않도록 반복 학습";
  static String howToUseMsg7En = "you don't forget it ";

  static String howToUseMsg8 = "howToUseMsg8Tr";
  static String howToUseMsg8Kr = "이 중요하다는 것도 강조하고 있는 것을 볼 수 있습니다.\n\n";

  static String howToUseMsg8En =
      'because vocabulary is simple memorization.\n\n';

  //

  static String howToUseMsg9 = "howToUseMsg9Tr";
  static String howToUseMsg9Kr = " 그래서 ";
  static String howToUseMsg9En = ' So ';

  static String howToUseMsg10 = "howToUseMsg10Tr";
  static String howToUseMsg10Kr = "JLPT 종각";
  static String howToUseMsg10En = "Jongs's JLPT ";

  static String howToUseMsg11 = "howToUseMsg11Tr";
  static String howToUseMsg11Kr = "은 ";
  static String howToUseMsg11En = 'focused on ';

  static String howToUseMsg12 = "howToUseMsg12Tr";
  static String howToUseMsg12Kr = "반복 학습";
  static String howToUseMsg12En = 'iterative learning';

  static String howToUseMsg13 = "howToUseMsg13Tr";
  static String howToUseMsg13Kr = "에 중점을 두었습니다.\n\n\n";
  static String howToUseMsg13En = '.\n\n\n';

  static String howToUseMsg14 = "howToUseMsg14Tr";
  static String howToUseMsg14Kr = "또한 일본어 학습에는 ";
  static String howToUseMsg14En = '';

  static String howToUseMsg15 = "howToUseMsg15Tr";
  static String howToUseMsg15Kr = "한자";
  static String howToUseMsg15En = 'Kanji ';

  static String howToUseMsg16 = "howToUseMsg16Tr";
  static String howToUseMsg16Kr = "도 중요합니다.\n\n";
  static String howToUseMsg16En = 'are also important for learning Japanese. ';

  static String howToUseMsg17 = "howToUseMsg17Tr";
  static String howToUseMsg17Kr = " 일본어를 그대로 학습하는 것보다도 ";
  static String howToUseMsg17En = ' I think that memorizing ';

  static String howToUseMsg18 = "howToUseMsg18Tr";
  static String howToUseMsg18Kr = "한자";
  static String howToUseMsg18En = 'Kangi';

  static String howToUseMsg19 = "howToUseMsg19Tr";
  static String howToUseMsg19Kr = "를 먼저 암기하고 일본어를 학습하면  ";
  static String howToUseMsg19En = 'first and learning Japanese more than, ';

  static String howToUseMsg20 = "howToUseMsg20Tr";
  static String howToUseMsg20Kr = "학습도이 2배 이상";
  static String howToUseMsg20En = 'doubles the learning level';

  static String howToUseMsg21 = "howToUseMsg21Tr";
  static String howToUseMsg21Kr = " 증가한다고 생각합니다.\n\n";
  static String howToUseMsg21En =
      ', rather than learning Japanese as it is.\n\n';

  static String howToUseMsg22 = "howToUseMsg22Tr";
  static String howToUseMsg22Kr =
      "  처음 보는 일본어라도 해당 일본어의 한자를 알고 있다면, 그 뜻을 추측할 수 있기 때문에 ";
  static String howToUseMsg22En =
      " Even if it's the first time you've seen Japanese, if you know the Kangi of that Japanese language, you can guess the meaning, so it will be a great advantage in ";

  static String howToUseMsg23 = "howToUseMsg23Tr";
  static String howToUseMsg23Kr = " 독해";
  static String howToUseMsg23En = 'reading.';

  static String howToUseMsg24 = "howToUseMsg24Tr";
  static String howToUseMsg24Kr = " 에서도";
  static String howToUseMsg24En = '';

  static String howToUseMsg25 = "howToUseMsg25Tr";
  static String howToUseMsg25Kr = " 큰 이점";
  static String howToUseMsg25En = '';

  static String howToUseMsg26 = "howToUseMsg26Tr";
  static String howToUseMsg26Kr = "이 될 것입니다.\n\n";
  static String howToUseMsg26En = '\n\n';

  static String howToUseMsg27 = "howToUseMsg27Tr";
  static String howToUseMsg27Kr =
      " 그래서 JLPT 종각은 일본어뿐만 아니라, N5급부터 N1급의 한자를 별도로 학습할 수 있고, JLPT N5급부터 N1급의 단어를 학습하면서도 ";
  static String howToUseMsg27En =
      " Therefore, Jong's JLPT is designed to learn not only Japanese but also N5 to N1 Kangi separately, and to learn the meaning, admonition, and reading of the Kangi by ";

  static String howToUseMsg28 = "howToUseMsg28Tr";
  static String howToUseMsg28Kr = "한자를 클릭해서 바로바로 ";
  static String howToUseMsg28En = 'clicking on them ';

  static String howToUseMsg29 = "howToUseMsg29Tr";
  static String howToUseMsg29Kr = "해당 한자의 의미와 훈독과 음독을 학습할 수 있게 제작하였습니다.";
  static String howToUseMsg29En = 'while learning words from JLPT N5 to N1.';

  static String howToUseMsg30 = "howToUseMsg30Tr";
  static String howToUseMsg30Kr = "\n해당 한자의 의미와 훈독과 음독을 학습할 수 있게 제작하였습니다.";
  static String howToUseMsg30En = '\n(There are Kangi that are not prepared),';

  //

  //
}
