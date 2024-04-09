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

List<Hiragana> katakana = [
  Hiragana(
    hiragana: 'ア행',
    subHiragana: [
      SubHiragana(
        hiragana: 'ア',
        kSound: '아',
        eSound: 'a',
        examples: [
          Example(yomikata: '-', word: 'アイスクリーム', mean: '아이스크림'),
          Example(yomikata: '-', word: 'アルバイト', mean: '아르바이트'),
          Example(yomikata: '-', word: 'アイロン', mean: '다리미'),
          Example(yomikata: '-', word: 'アジア', mean: '아시아'),
        ],
      ),
      SubHiragana(
        hiragana: 'イ',
        kSound: '이',
        eSound: 'i',
        examples: [
          Example(yomikata: '-', word: 'イタリア', mean: '이탈리아'),
          Example(yomikata: '-', word: 'インク', mean: '잉크'),
          Example(yomikata: '-', word: 'イアホン', mean: '이어폰'),
          Example(yomikata: '-', word: 'インターネット', mean: '인터넷'),
        ],
      ),
      SubHiragana(hiragana: 'ウ', kSound: '우', eSound: 'u', examples: [
        Example(yomikata: '-', word: 'ウクレレ', mean: '우쿠렐레'),
        Example(yomikata: '-', word: 'ウイルス', mean: '바이러스'),
        Example(yomikata: '-', word: 'ウェブ', mean: '웹'),
        Example(yomikata: '-', word: 'ウィスキー', mean: '위스키'),
      ]),
      SubHiragana(hiragana: 'エ', kSound: '에', eSound: 'e', examples: [
        Example(yomikata: '-', word: 'エンジン', mean: '엔진'),
        Example(yomikata: '-', word: 'エアコン', mean: '에어컨'),
        Example(yomikata: '-', word: 'エプロン', mean: '앞치마'),
        Example(yomikata: '-', word: 'エラー', mean: '에라'),
      ]),
      SubHiragana(hiragana: 'オ', kSound: '오', eSound: 'o', examples: [
        Example(yomikata: '-', word: 'オーストラリア', mean: '호주'),
        Example(yomikata: '-', word: 'オイル', mean: '오일'),
        Example(yomikata: '-', word: 'オレンジ', mean: '오렌지'),
        Example(yomikata: '-', word: 'オーブン', mean: '오븐'),
      ]),
    ],
  ),
  Hiragana(
    hiragana: 'カ행',
    subHiragana: [
      SubHiragana(hiragana: 'カ', kSound: '카', eSound: 'ka', examples: [
        Example(yomikata: '-', word: 'カーディガン', mean: '가디건'),
        Example(yomikata: '-', word: 'カラオケ', mean: '노래방'),
        Example(yomikata: '-', word: 'カカオ', mean: '카카오'),
        Example(yomikata: '-', word: 'カメラ', mean: '카메라'),
      ]),
      SubHiragana(hiragana: 'キ', kSound: '키', eSound: 'ki', examples: [
        Example(yomikata: '-', word: 'キウイ', mean: '키위'),
        Example(yomikata: '-', word: 'キツツキ', mean: '딱따구리'),
        Example(yomikata: '-', word: 'キーホルダー', mean: '열쇠고리'),
        Example(yomikata: '-', word: 'キッチン', mean: '주방'),
      ]),
      SubHiragana(hiragana: 'ク', kSound: '쿠', eSound: 'ku', examples: [
        Example(yomikata: '-', word: 'クッション', mean: '쿠션'),
        Example(yomikata: '-', word: 'クッキー', mean: '쿠키'),
        Example(yomikata: '-', word: 'クーポン', mean: '쿠폰'),
        Example(yomikata: '-', word: 'クレヨン', mean: '크레용'),
      ]),
      SubHiragana(hiragana: 'ケ', kSound: '케', eSound: 'ke', examples: [
        Example(yomikata: '-', word: 'ケース', mean: '케이스'),
        Example(yomikata: '-', word: 'ケーキ', mean: '케이크'),
      ]),
      SubHiragana(hiragana: 'コ', kSound: '코', eSound: 'ko', examples: [
        Example(yomikata: '-', word: 'ココア', mean: '코코아'),
        Example(yomikata: '-', word: 'コーラ', mean: '콜라'),
        Example(yomikata: '-', word: 'コンテンツ', mean: '콘텐츠'),
        Example(yomikata: '-', word: 'コーヒー', mean: '커피'),
      ]),
    ],
  ),
  Hiragana(
    hiragana: 'サ행',
    subHiragana: [
      SubHiragana(hiragana: 'サ', kSound: '사', eSound: 'sa', examples: [
        Example(yomikata: '-', word: 'サービス', mean: '서비스'),
        Example(yomikata: '-', word: 'サッカー', mean: '축가'),
        Example(yomikata: '-', word: 'サウナ', mean: '사우나'),
      ]),
      SubHiragana(hiragana: 'シ', kSound: '시', eSound: 'shi', examples: [
        Example(yomikata: '-', word: 'シーツ', mean: '시트'),
        Example(yomikata: '-', word: 'シングル', mean: '싱글'),
        Example(yomikata: '-', word: 'シナリオ', mean: '시나리오'),
      ]),
      SubHiragana(hiragana: 'ス', kSound: '스', eSound: 'su', examples: [
        Example(yomikata: '-', word: 'スキー', mean: '스키'),
        Example(yomikata: '-', word: 'スノーボード', mean: '스노우보드'),
        Example(yomikata: '-', word: 'スイカ', mean: '수박'),
        Example(yomikata: '-', word: 'スパイ', mean: '스파이'),
      ]),
      SubHiragana(hiragana: 'セ', kSound: '세', eSound: 'se', examples: [
        Example(yomikata: '-', word: 'セール', mean: '세일'),
        Example(yomikata: '-', word: 'セキュリティ', mean: '보안'),
        Example(yomikata: '-', word: 'セーター', mean: '스웨터'),
      ]),
      SubHiragana(hiragana: 'ソ', kSound: '소', eSound: 'so', examples: [
        Example(yomikata: '-', word: 'ソース', mean: '소스'),
        Example(yomikata: '-', word: 'ソファー', mean: '소파'),
        Example(yomikata: '-', word: 'ソーセージ', mean: '소세지'),
      ]),
    ],
  ),
  Hiragana(
    hiragana: 'タ행',
    subHiragana: [
      SubHiragana(hiragana: 'タ', kSound: '타', eSound: 'ta', examples: [
        Example(yomikata: '-', word: 'タクシー', mean: '택시'),
        Example(yomikata: '-', word: 'タイヤ', mean: '타이어'),
        Example(yomikata: '-', word: 'タヌキ', mean: '너구리'),
        Example(yomikata: '-', word: 'タワー', mean: '타워'),
      ]),
      SubHiragana(hiragana: 'チ', kSound: '치', eSound: 'chi', examples: [
        Example(yomikata: '-', word: 'チーター', mean: '치타'),
        Example(yomikata: '-', word: 'チーズ', mean: '치즈'),
        Example(yomikata: '-', word: 'チキン', mean: '치킨'),
        Example(yomikata: '-', word: 'チケット', mean: '티켓'),
      ]),
      SubHiragana(hiragana: 'ツ', kSound: '츠', eSound: 'tsu', examples: [
        Example(yomikata: '-', word: 'ツアー', mean: '투어'),
        Example(yomikata: '-', word: 'ツリー', mean: '트리'),
        Example(yomikata: '-', word: 'ツンデレ', mean: '츤데레'),
      ]),
      SubHiragana(hiragana: 'テ', kSound: '테', eSound: 'te', examples: [
        Example(yomikata: '-', word: 'テニス', mean: '테니스'),
        Example(yomikata: '-', word: 'テスト', mean: '테스트'),
        Example(yomikata: '-', word: 'テキスト', mean: '텍스트'),
        Example(yomikata: '-', word: 'ティーシャツ', mean: '티셔츠'),
      ]),
      SubHiragana(hiragana: 'ト', kSound: '토', eSound: 'to', examples: [
        Example(yomikata: '-', word: 'トースト', mean: '토스트'),
        Example(yomikata: '-', word: 'トマト', mean: '토마토'),
        Example(yomikata: '-', word: 'トイレ', mean: '화장실'),
        Example(yomikata: '-', word: 'トンネル', mean: '터널'),
      ]),
    ],
  ),
  Hiragana(
    hiragana: 'ナ행',
    subHiragana: [
      SubHiragana(hiragana: 'ナ', kSound: '나', eSound: 'na', examples: [
        Example(yomikata: '-', word: 'ナイフ', mean: '나이프'),
        Example(yomikata: '-', word: 'ナプキン', mean: '냅킨'),
        Example(yomikata: '-', word: 'ナチュラル', mean: '내츄럴'),
      ]),
      SubHiragana(hiragana: 'ニ', kSound: '니', eSound: 'ni', examples: [
        Example(yomikata: '-', word: 'ニート', mean: ''),
        Example(yomikata: '-', word: 'ニキビ', mean: '여드름'),
        Example(yomikata: '-', word: 'ニラ', mean: '부추'),
        Example(yomikata: '-', word: 'ニュース', mean: '뉴스'),
      ]),
      SubHiragana(hiragana: 'ヌ', kSound: '누', eSound: 'nu', examples: [
        Example(yomikata: '-', word: 'ヌテラ', mean: '누텔라'),
      ]),
      SubHiragana(hiragana: 'ネ', kSound: '네', eSound: 'ne', examples: [
        Example(yomikata: '-', word: 'ネクタイ', mean: '넥타이'),
        Example(yomikata: '-', word: 'ネパール', mean: '네팔'),
        Example(yomikata: '-', word: 'ネックレス', mean: '목걸이'),
      ]),
      SubHiragana(hiragana: 'ノ', kSound: '노', eSound: 'no', examples: [
        Example(yomikata: '-', word: 'ノート', mean: '노트'),
        Example(yomikata: '-', word: 'ノイズ', mean: '소음'),
        Example(yomikata: '-', word: 'ノック', mean: '노크'),
      ]),
    ],
  ),
  Hiragana(
    hiragana: 'ハ행',
    subHiragana: [
      SubHiragana(hiragana: 'ハ', kSound: '하', eSound: 'ha', examples: [
        Example(yomikata: '-', word: 'ハウス', mean: '하우스'),
        Example(yomikata: '-', word: 'ハサミ', mean: '가위'),
        Example(yomikata: '-', word: 'ハンバーグ', mean: '햄버그'),
        Example(yomikata: '-', word: 'ハイキング', mean: '하이킹'),
      ]),
      SubHiragana(hiragana: 'ヒ', kSound: '히', eSound: 'hi', examples: [
        Example(yomikata: '-', word: 'ヒーター', mean: '히터'),
        Example(yomikata: '-', word: 'ヒント', mean: '힌트'),
        Example(yomikata: '-', word: 'ヒーロー', mean: '히어로'),
      ]),
      SubHiragana(hiragana: 'フ', kSound: '후', eSound: 'fu', examples: [
        Example(yomikata: '-', word: 'フード', mean: '후드(티)'),
        Example(yomikata: '-', word: 'フットボール', mean: '풋볼'),
        Example(yomikata: '-', word: 'フォーク', mean: '포크'),
        Example(yomikata: '-', word: 'ファイル', mean: '파일'),
      ]),
      SubHiragana(hiragana: 'ヘ', kSound: '헤', eSound: 'he', examples: [
        Example(yomikata: '-', word: 'ヘリコプター', mean: '헬리콥터'),
        Example(yomikata: '-', word: 'ヘラクレス', mean: '헤라클레스'),
      ]),
      SubHiragana(hiragana: 'ホ', kSound: '호', eSound: 'ho', examples: [
        Example(yomikata: '-', word: 'ホテル', mean: '호텔'),
        Example(yomikata: '-', word: 'ホラー', mean: '호러'),
        Example(yomikata: '-', word: 'ホーム', mean: '홈'),
        Example(yomikata: '-', word: 'ホットドック', mean: '핫도그'),
      ]),
    ],
  ),
  Hiragana(
    hiragana: 'ヤ행',
    subHiragana: [
      SubHiragana(hiragana: 'ヤ', kSound: '야', eSound: 'ya', examples: [
        Example(yomikata: '-', word: 'ヤカン', mean: '주전자'),
        Example(yomikata: '-', word: 'ヤクルト', mean: '야쿠르트'),
      ]),
      SubHiragana(hiragana: 'ユ', kSound: '유', eSound: 'yu', examples: [
        Example(yomikata: '-', word: 'ユーザー', mean: '유저'),
        Example(yomikata: '-', word: 'ユニコーン', mean: '유니콘'),
        Example(yomikata: '-', word: 'ユーチューブ', mean: '유튜브'),
      ]),
      SubHiragana(hiragana: 'ヨ', kSound: '요', eSound: 'yo', examples: [
        Example(yomikata: '-', word: 'ヨーヨー', mean: '요요'),
        Example(yomikata: '-', word: 'ヨット', mean: '요트'),
        Example(yomikata: '-', word: 'ヨーグルト', mean: '요구르트'),
      ]),
    ],
  ),
  Hiragana(
    hiragana: 'ラ행',
    subHiragana: [
      SubHiragana(hiragana: 'ラ', kSound: '라', eSound: 'ra', examples: [
        Example(yomikata: '-', word: 'ラジオ', mean: '라디오'),
        Example(yomikata: '-', word: 'ライオン', mean: '라이온'),
        Example(yomikata: '-', word: 'ラーメン', mean: '라맨'),
        Example(yomikata: '-', word: 'ランニング', mean: '런닝'),
      ]),
      SubHiragana(hiragana: 'リ', kSound: '리', eSound: 'ri', examples: [
        Example(yomikata: '-', word: 'リボン', mean: '리본'),
        Example(yomikata: '-', word: 'リハーサル', mean: '리허설'),
        Example(yomikata: '-', word: 'リアクション', mean: '리엑션'),
        Example(yomikata: '-', word: 'リーダー', mean: '리더'),
      ]),
      SubHiragana(hiragana: 'ル', kSound: '루', eSound: 'ru', examples: [
        Example(yomikata: '-', word: 'ルート', mean: '루트'),
        Example(yomikata: '-', word: 'ルール', mean: '규칙'),
        Example(yomikata: '-', word: 'ルーレット', mean: '룰렛'),
      ]),
      SubHiragana(hiragana: 'レ', kSound: '레', eSound: 're', examples: [
        Example(yomikata: '-', word: 'レモン', mean: '레몬'),
        Example(yomikata: '-', word: 'レース', mean: '레이스'),
        Example(yomikata: '-', word: 'レンズ', mean: '렌즈'),
        Example(yomikata: '-', word: 'レストラン', mean: '레스토랑'),
      ]),
      SubHiragana(hiragana: 'ロ', kSound: '로', eSound: 'ro', examples: [
        Example(yomikata: '-', word: 'ロボット', mean: '로봇'),
        Example(yomikata: '-', word: 'ロバ', mean: '당나귀'),
        Example(yomikata: '-', word: 'ロケット', mean: '로켓'),
        Example(yomikata: '-', word: 'ロッカー', mean: '(코인)로커'),
      ]),
    ],
  ),
  Hiragana(
    hiragana: 'ワ행',
    subHiragana: [
      SubHiragana(hiragana: 'ワ', kSound: '와', eSound: 'wa', examples: [
        Example(yomikata: '-', word: 'ワッフル', mean: '와플'),
        Example(yomikata: '-', word: 'ワイン', mean: '와인'),
        Example(yomikata: '-', word: 'ワンピース', mean: '원피스'),
        Example(yomikata: '-', word: 'ワクチン', mean: '백신'),
      ]),
      SubHiragana(hiragana: 'ヲ', kSound: '오', eSound: 'wo', examples: [
        Example(yomikata: '-', word: 'ヲタク', mean: '오타쿠'),
      ]),
      SubHiragana(hiragana: 'ン', kSound: '응', eSound: 'n', examples: []),
    ],
  ),
];
List<Hiragana> hiraganas = [
  Hiragana(
    hiragana: 'あ행',
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
          Example(yomikata: 'いす', word: 'いす', mean: '의자'),
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
          Example(yomikata: 'うんこ', word: 'うんこ', mean: '똥'),
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
          Example(yomikata: 'おんがく', word: '音楽', mean: '음악'),
          Example(yomikata: 'おんせん', word: '温泉', mean: '온천'),
          Example(yomikata: 'おりる', word: '降りる', mean: '내리다'),
        ],
      ),
    ],
  ),
  Hiragana(
    hiragana: 'か행',
    subHiragana: [
      SubHiragana(
        hiragana: 'か',
        kSound: '카',
        eSound: 'ka',
        examples: [
          Example(yomikata: 'かう', word: '買う', mean: '사다'),
          Example(yomikata: 'きょう', word: '今日', mean: '오늘'),
          Example(yomikata: 'きのう', word: '昨日', mean: '어제'),
          Example(yomikata: 'かえる', word: '帰る', mean: '돌아가다'),
        ],
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
    hiragana: 'さ행',
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
    hiragana: 'た행',
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
    hiragana: 'な행',
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
    hiragana: 'は행',
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
    hiragana: 'や행',
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
    hiragana: 'ら행',
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
    hiragana: 'わ행',
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
