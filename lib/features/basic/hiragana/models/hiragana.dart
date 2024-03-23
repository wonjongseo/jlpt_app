import 'package:japanese_voca/model/example.dart';

class Hiragana {
  final String hiragana;

  final List<SubHiragana> subHiragana;
  Hiragana({
    required this.hiragana,
    required this.subHiragana,
  });
}

class SubHiragana {
  final String hiragana;
  final String kSound;
  final String eSound;
  final List<Example>? examples;
  SubHiragana({
    required this.hiragana,
    required this.kSound,
    this.examples,
    required this.eSound,
  });
}

List<Hiragana> hiraganas = [
  Hiragana(
    hiragana: 'あ단',
    subHiragana: [
      SubHiragana(
        hiragana: 'あ',
        kSound: '아',
        eSound: 'a',
        examples: [
          Example(yomikata: 'あい', word: '愛', mean: '사랑'),
          Example(yomikata: 'あおい', word: '青い', mean: '파랗다'),
          Example(yomikata: 'あう', word: '会う', mean: '만나다'),
          Example(yomikata: 'あし', word: '足', mean: '발'),
        ],
      ),
      SubHiragana(
        hiragana: 'い',
        kSound: '이',
        eSound: 'i',
        examples: [
          Example(yomikata: 'いえ', word: '家', mean: '집'),
          Example(yomikata: '-', word: 'いす', mean: '의자'),
          Example(yomikata: 'いく', word: '行く', mean: '가다'),
          Example(yomikata: 'いま', word: '今', mean: '지금')
        ],
      ),
      SubHiragana(
        hiragana: 'う',
        kSound: '우',
        eSound: 'u',
        examples: [
          Example(yomikata: 'うた', word: '歌', mean: '노래'),
          Example(yomikata: 'うまれる', word: '生まれる', mean: '태어나다'),
          Example(yomikata: 'うみ', word: '海', mean: '바다'),
        ],
      ),
      SubHiragana(
        hiragana: 'え',
        kSound: '에',
        eSound: 'e',
        examples: [
          Example(yomikata: 'えいが', word: '映画', mean: '영화'),
          Example(yomikata: 'えいご', word: '英語', mean: '영어'),
          Example(yomikata: 'えき', word: '駅', mean: '역'),
        ],
      ),
      SubHiragana(
        hiragana: 'お',
        kSound: '오',
        eSound: 'o',
        examples: [
          Example(yomikata: 'おいしい', word: '美味しい', mean: '맛있다'),
          Example(yomikata: 'おかあさん', word: 'お母さん', mean: '어머니'),
          Example(yomikata: 'おさら', word: 'お皿', mean: '접시'),
        ],
      ),
    ],
  ),
  Hiragana(
    hiragana: 'か단',
    subHiragana: [
      SubHiragana(
        hiragana: 'か',
        kSound: '카',
        eSound: 'ka',
        examples: [],
      ),
      SubHiragana(
        hiragana: 'き',
        kSound: '키',
        eSound: 'ki',
        examples: [
          Example(yomikata: 'き', word: '木', mean: '나무'),
          Example(yomikata: 'きょう', word: '今日', mean: '오늘'),
          Example(yomikata: 'きる', word: '切る', mean: '자르다'),
          Example(yomikata: 'きらい', word: '嫌い', mean: '싫어하다'),
        ],
      ),
      SubHiragana(
        hiragana: 'く',
        kSound: '쿠',
        eSound: 'ku',
        examples: [
          Example(yomikata: 'くに', word: '国', mean: '나라'),
          Example(yomikata: 'くる', word: '来る', mean: '오다'),
          Example(yomikata: 'くち', word: '口', mean: '입'),
        ],
      ),
      SubHiragana(
        hiragana: 'け',
        kSound: '케',
        eSound: 'ke',
        examples: [
          Example(yomikata: 'けす', word: '消す', mean: '지우다'),
          Example(yomikata: 'けっこん', word: '結婚', mean: '결혼'),
        ],
      ),
      SubHiragana(
        hiragana: 'こ',
        kSound: '코',
        eSound: 'ko',
        examples: [
          Example(yomikata: 'こえ', word: '声', mean: '목소리,소리'),
          Example(yomikata: 'こまる', word: '困る', mean: '곤란해지다'),
          Example(yomikata: 'こたえる', word: '答える', mean: '대답하다'),
        ],
      ),
    ],
  ),
  Hiragana(
    hiragana: 'さ단',
    subHiragana: [
      SubHiragana(
        hiragana: 'さ',
        kSound: '사',
        eSound: 'sa',
        examples: [
          Example(yomikata: 'さき', word: '先', mean: '선두,먼저'),
          Example(yomikata: 'さんぽ', word: '散歩', mean: '산책'),
        ],
      ),
      SubHiragana(
        hiragana: 'し',
        kSound: '시',
        eSound: 'shi',
        examples: [
          Example(yomikata: 'しごと', word: '仕事', mean: '일'),
          Example(yomikata: 'しお', word: '塩', mean: '소금'),
          Example(yomikata: 'しぬ', word: '死ぬ', mean: '죽다'),
        ],
      ),
      SubHiragana(
        hiragana: 'す',
        kSound: '스',
        eSound: 'su',
        examples: [
          Example(yomikata: 'すこし', word: '少し', mean: '조금'),
          Example(yomikata: 'すき', word: '好き', mean: '좋아하다'),
          Example(yomikata: 'すわる', word: '座る', mean: '앉다'),
        ],
      ),
      SubHiragana(
        hiragana: 'せ',
        kSound: '세',
        eSound: 'se',
        examples: [
          Example(yomikata: 'せん', word: '千', mean: '1000'),
          Example(yomikata: 'せんせい', word: '先生', mean: '선생'),
          Example(yomikata: 'せんたく', word: '洗濯', mean: '세탁'),
        ],
      ),
      SubHiragana(
        hiragana: 'そ',
        kSound: '소',
        eSound: 'so',
        examples: [
          Example(yomikata: 'そうじ', word: '掃除', mean: '청소'),
          Example(yomikata: 'そら', word: '空', mean: '하늘'),
        ],
      ),
    ],
  ),
  Hiragana(
    hiragana: 'た단',
    subHiragana: [
      SubHiragana(
        hiragana: 'た',
        kSound: '타',
        eSound: 'ta',
        examples: [
          Example(yomikata: 'たつ', word: '立つ', mean: '서다'),
          Example(yomikata: 'たまご', word: '卵', mean: '계란'),
          Example(yomikata: 'たいせつ', word: '大切', mean: '중요함'),
        ],
      ),
      SubHiragana(
        hiragana: 'ち',
        kSound: '치',
        eSound: 'chi',
        examples: [
          Example(yomikata: 'ちゅう', word: '中', mean: '중'),
          Example(yomikata: 'ちかい', word: '近い', mean: '가깝다'),
          Example(yomikata: 'ちいさい', word: '小さい', mean: '작다'),
        ],
      ),
      SubHiragana(
        hiragana: 'つ',
        kSound: '츠',
        eSound: 'tsu',
        examples: [
          Example(yomikata: 'つくる', word: '作る', mean: '만들다'),
          Example(yomikata: 'つぎ', word: '次', mean: '다음'),
          Example(yomikata: 'つかれる', word: '疲れる', mean: '피곤하다'),
        ],
      ),
      SubHiragana(
        hiragana: 'て',
        kSound: '테',
        eSound: 'te',
        examples: [
          Example(yomikata: 'て', word: '手', mean: '손'),
          Example(yomikata: 'てつ', word: '鉄', mean: '철'),
        ],
      ),
      SubHiragana(
        hiragana: 'と',
        kSound: '토',
        eSound: 'to',
        examples: [
          Example(yomikata: 'とり', word: '鳥', mean: '새'),
          Example(yomikata: 'とき', word: '時', mean: '시간, 시각'),
          Example(yomikata: 'とおい', word: '遠い', mean: '멀다'),
        ],
      ),
    ],
  ),
  Hiragana(
    hiragana: 'な단',
    subHiragana: [
      SubHiragana(
        hiragana: 'な',
        kSound: '나',
        eSound: 'na',
        examples: [
          Example(yomikata: 'なつ', word: '夏', mean: '여름'),
          Example(yomikata: 'なまえ', word: '名前', mean: '이름'),
          Example(yomikata: 'ならう', word: '習う', mean: '배우다'),
        ],
      ),
      SubHiragana(
        hiragana: 'に',
        kSound: '니',
        eSound: 'ni',
        examples: [
          Example(yomikata: 'にく', word: '肉', mean: '고기'),
          Example(yomikata: 'にわ', word: '庭', mean: '정원'),
          Example(yomikata: 'にちようび', word: '日曜日', mean: '일요일'),
        ],
      ),
      SubHiragana(
        hiragana: 'ぬ',
        kSound: '누',
        eSound: 'nu',
        examples: [
          Example(yomikata: 'ぬぐ', word: '脱ぐ', mean: '빼다'),
          Example(yomikata: 'ぬし', word: '主', mean: '주인'),
          Example(yomikata: 'ぬま', word: '沼', mean: '늪'),
        ],
      ),
      SubHiragana(
        hiragana: 'ね',
        kSound: '네',
        eSound: 'ne',
        examples: [
          Example(yomikata: 'ねる', word: '寝る', mean: '자다'),
          Example(yomikata: 'ねこ', word: '猫', mean: '고양이'),
          Example(yomikata: 'ねつ', word: '熱', mean: '열'),
        ],
      ),
      SubHiragana(
        hiragana: 'の',
        kSound: '노',
        eSound: 'no',
        examples: [
          Example(yomikata: 'のぼる', word: '登る', mean: '오르다'),
          Example(yomikata: 'のむ', word: '飲む', mean: '마시다'),
          Example(yomikata: 'のる', word: '乗る', mean: '타다'),
        ],
      ),
    ],
  ),
  Hiragana(
    hiragana: 'は단',
    subHiragana: [
      SubHiragana(
        hiragana: 'は',
        kSound: '하',
        eSound: 'ha',
        examples: [
          Example(yomikata: 'はしる', word: '走る', mean: '달리다'),
          Example(yomikata: 'はじめる', word: '始める', mean: '시작되다'),
          Example(yomikata: 'はたらく', word: '働く', mean: '일하다'),
        ],
      ),
      SubHiragana(
        hiragana: 'ひ',
        kSound: '히',
        eSound: 'hi',
        examples: [
          Example(yomikata: 'ひま', word: '暇', mean: '한가함'),
          Example(yomikata: 'ひろい', word: '広い', mean: '넓다'),
        ],
      ),
      SubHiragana(
        hiragana: 'ふ',
        kSound: '후',
        eSound: 'fu',
        examples: [
          Example(yomikata: 'ふく', word: '服', mean: '옷'),
          Example(yomikata: 'ふね', word: '船', mean: '배 (탈 것)'),
          Example(yomikata: 'ふとい', word: '太い', mean: '두껍다'),
        ],
      ),
      SubHiragana(
        hiragana: 'へ',
        kSound: '헤',
        eSound: 'he',
        examples: [
          Example(yomikata: 'へそ', word: '臍', mean: '배꼽'),
          Example(yomikata: 'へいわ', word: '平和', mean: '평화'),
        ],
      ),
      SubHiragana(
        hiragana: 'ほ',
        kSound: '호',
        eSound: 'ho',
        examples: [
          Example(yomikata: 'ほし', word: '星', mean: '별'),
          Example(yomikata: 'ほん', word: '本', mean: '첵'),
          Example(yomikata: 'ほしい', word: '欲しい', mean: '하고싶다'),
        ],
      ),
    ],
  ),
  Hiragana(
    hiragana: 'や단',
    subHiragana: [
      SubHiragana(
        hiragana: 'や',
        kSound: '야',
        eSound: 'ya',
        examples: [
          Example(yomikata: 'やくそく', word: '約束', mean: '별'),
        ],
      ),
      SubHiragana(
        hiragana: 'ゆ',
        kSound: '유',
        eSound: 'yu',
        examples: [
          Example(yomikata: 'ゆうしょく', word: '夕食', mean: '첵'),
        ],
      ),
      SubHiragana(
        hiragana: 'よ',
        kSound: '요',
        eSound: 'yo',
        examples: [],
      ),
    ],
  ),
  Hiragana(
    hiragana: 'ら단',
    subHiragana: [
      SubHiragana(
        hiragana: 'ら',
        kSound: '라',
        eSound: 'ra',
        examples: [
          Example(yomikata: 'あたらしい', word: '新しい', mean: '새롭다'),
          Example(word: "来週", yomikata: "らいしゅう", mean: "내주, 다음 주"),
          Example(word: "来る", yomikata: "きたる", mean: "오다")
        ],
      ),
      SubHiragana(
        hiragana: 'り',
        kSound: '리',
        eSound: 'ri',
        examples: [],
      ),
      SubHiragana(
        hiragana: 'る',
        kSound: '루',
        eSound: 'ru',
        examples: [],
      ),
      SubHiragana(
        hiragana: 'れ',
        kSound: '레',
        eSound: 're',
        examples: [],
      ),
      SubHiragana(
        hiragana: 'ろ',
        kSound: '로',
        eSound: 'ro',
        examples: [],
      ),
    ],
  ),
  Hiragana(
    hiragana: 'わ단',
    subHiragana: [
      SubHiragana(
        hiragana: 'わ',
        kSound: '와',
        eSound: 'wa',
        examples: [],
      ),
      SubHiragana(
        hiragana: 'を',
        kSound: '오',
        eSound: 'wo',
        examples: [],
      ),
      SubHiragana(
        hiragana: 'ん',
        kSound: '응',
        eSound: 'n',
        examples: [],
      ),
    ],
  ),
];
