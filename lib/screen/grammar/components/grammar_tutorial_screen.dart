import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/common/widget/kangi_text.dart';
import 'package:japanese_voca/common/widget/tutorial_text.dart';
import 'package:japanese_voca/config/colors.dart';
import 'package:japanese_voca/model/example.dart';
import 'package:japanese_voca/model/grammar.dart';
import 'package:japanese_voca/screen/grammar/components/grammar_card.dart';
import 'package:japanese_voca/screen/grammar/grammar_screen.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class GrammerTutorialScreen extends StatefulWidget {
  const GrammerTutorialScreen({super.key});

  @override
  State<GrammerTutorialScreen> createState() => _GrammerTutorialScreenState();
}

class _GrammerTutorialScreenState extends State<GrammerTutorialScreen> {
  List<TargetFocus> targets = [];

  GlobalKey temp = GlobalKey();
  GlobalKey grammarKey = GlobalKey();
  GlobalKey exampleKey = GlobalKey();
  GlobalKey eyeIconKey = GlobalKey();
  GlobalKey saveIconKey = GlobalKey();

  GlobalKey testKey = GlobalKey();

  bool isClick = false;
  bool isClickExample = false;
  bool isClickEye = true;

  void showTutorial() {
    TutorialCoachMark(
      alignSkip: Alignment.topLeft,
      textStyleSkip: const TextStyle(
          color: Colors.redAccent, fontSize: 20, fontWeight: FontWeight.bold),
      targets: targets,
      onClickTarget: (target) {
        if (target.identify == 'grammar') {
          isClick = true;
          setState(() {});
        }

        if (target.identify == 'exampleKey') {
          showExample();
        }

        if (target.identify == 'test') {
          Get.back();
        }
      },
      onSkip: () {
        Get.offAndToNamed(GRAMMER_PATH);
      },
      onFinish: () {
        Get.offAndToNamed(GRAMMER_PATH);
      },
    ).show(context: context);
  }

  List<Grammar> grammars = [];
  Grammar grammar = Grammar(
    id: 119,
    step: -1,
    level: "",
    grammar: "～てくる [出現]",
    connectionWays: "동사て형",
    means: "출현",
    examples: [
      Example(word: "太陽が地平線から昇ってきた.", mean: "태양이 지평선에서 떠올랐다.", answer: "昇ってきた"),
      Example(word: "歯が生えてきた.", mean: "이가 나기 시작했어.", answer: "生えてきた"),
      Example(
          word: "新年度になり新しい学生がやってきた.",
          mean: "새해가 되어 새로운 학생이 찾아왔다.",
          answer: "やってきた")
    ],
    description:
        "의지가 없는 동사에 접속해서 원래 존재하지 않았다거나 말하는 사람이 보이지 않았던 것이 보이게 되는 것을 나타낸다.\r\n[どんどん, だんだん] 부사어와 호응해서 사용되는 경우가 많다.",
  );

  @override
  void initState() {
    super.initState();

    grammars.addAll(
      [
        Grammar(
            id: 31,
            step: -1,
            level: "",
            grammar: "～たまま, ～ないまま",
            connectionWays: "동사 과거형",
            means: "",
            examples: [
              Example(
                  word: "本物と同じような見たままを描く絵なら, 写真でも良いでしょう.",
                  mean: "진짜와 같은 모습을 그리는 그림이라면 사진이라도 좋을 것입니다.",
                  answer: "まま"),
              Example(
                  word: "音楽の知識は全くないので, 感じたままの感想を言ってもいいですか.",
                  mean: "음악에 대한 지식은 전혀 없기 때문에, 느낀 그대로의 감상을 말해도 될까요?",
                  answer: "まま"),
              Example(
                  word: "自分の感じたままに進めばいい.",
                  mean: "자기 느낌대로 진행하면 돼.",
                  answer: "まま"),
              Example(
                  word: "犯行の瞬間, 見たままを話してください.",
                  mean: "범행 순간 본 그대로를 말해주세요.",
                  answer: "まま")
            ],
            description: "사물에 아무것도 손대지 않은 상태를 나타냄."),
        Grammar(
            id: 120,
            step: -1,
            level: "",
            grammar: "～てくる [こちらへの一方的な動作]",
            connectionWays: "동사て형",
            means: "이쪽으로의 일방적인 동작",
            examples: [
              Example(
                  word: "知らない人が話しかけてきた.",
                  mean: "모르는 사람이 말을 걸었다.",
                  answer: "てきた"),
              Example(word: "猫が噛み付いてきた.", mean: "고양이가 물었다.", answer: "付いてきた")
            ],
            description: "화자, 혹은 화자가 보고 있는 사람에 대해 일방적인 동작이 이루어지는 것을 나타냅니다."),
        Grammar(
            id: 64,
            step: -1,
            level: "",
            grammar: "にとって",
            connectionWays: "명사에 직접 접속",
            means: "~에게 (있어서)",
            examples: [
              Example(
                  word: "女の子一人という環境は私にとって不安で心配.",
                  mean: "여자 혼자라는 환경은 나에게 불안하고 걱정이다.",
                  answer: "にとって"),
              Example(
                  word: "彼氏や彼女がいるのと自分にとって一生大切にしたい人がいるのとでは全く違う.",
                  mean: "남자친구나 여자친구가 있는 것과 자신에게 평생 간직하고 싶은 사람이 있는 것은 전혀 다르다.",
                  answer: "にとって"),
              Example(
                  word: "失敗した時こそ, 私たちにとって本当の学びが始まる.",
                  mean: "실패했을 때만이 우리에게 진정한 배움이 시작된다.",
                  answer: "にとって"),
              Example(
                  word: "今年が皆様にとって素晴らしい一年であることを祈念いたします.",
                  mean: "올해가 여러분께 멋진 한 해이기를 기원합니다.",
                  answer: "にとって"),
              Example(
                  word: "これは私にとって特別な映画です.",
                  mean: "이것은 저에게 있어서 특별한 영화입니다.",
                  answer: "にとって"),
              Example(
                  word: "社会人にとっての２４時間はあまりにも短い.",
                  mean: "직장인에게 있어서의 24시간은 너무 짧다.",
                  answer: "にとって"),
              Example(
                  word: "こんなことをしているのは私にとってもあなたにとっても時間の無駄です.",
                  mean: "이런 일을 하고 있는 것은 저에게도 당신에게도 시간 낭비입니다.",
                  answer: "にとって"),
              Example(
                  word: "彼の２歩は私にとっての３歩.",
                  mean: "그의 두 걸음은 나에게 3걸음.",
                  answer: "にとって")
            ],
            description:
                "사람, 조직, 단체 등 명사에 접속하여, 그것들의 위치에서 바라본 판단이나 감상, 평가 등을 표현하는 문법"),
        Grammar(
            id: 43,
            step: -1,
            level: "",
            grammar: "～ておく(とく)",
            connectionWays: "동사 て형",
            means: "~해두다",
            examples: [
              Example(
                  word: "お客さんが来る前に部屋を掃除しておきましょう.",
                  mean: "손님이 오기 전에 방을 청소해 둡시다.",
                  answer: "おきましょう"),
              Example(
                  word: "混乱を避けるため, 早めに皆さんに通知しておきましょう.",
                  mean: "혼란을 피하기 위해 빨리 여러분에게 통지해 둡시다.",
                  answer: "おきましょう"),
              Example(
                  word: "後で見ますので, そこに置いておいてください.",
                  mean: "나중에 볼테니 거기에 놓아두세요.",
                  answer: "おいてください"),
              Example(
                  word: "忙しいので, 私の代わりに打ち合わせしておいてください.",
                  mean: "바빠서 그러는데 저 대신 미팅 해두세요.",
                  answer: "おいてください"),
              Example(
                  word: "ちゃんと挨拶しておけば, 顔は覚えてもらえるかもしれない.",
                  mean: "인사 잘 해놓으면 얼굴은 기억해 줄 수도 있어.",
                  answer: "おけば"),
              Example(
                  word: "ここに置いておくので, 使いたければ使ってください.",
                  mean: "여기에 놔둘테니 쓰고 싶으면 쓰세요.",
                  answer: "おく"),
              Example(
                  word: "アイスは冷凍庫に入れておいたよ.",
                  mean: "아이스는 냉동실에 넣어놨어.",
                  answer: "おいたよ"),
              Example(
                  word: "文句なんか勝手に言わせておけ.",
                  mean: "불평 따위 마음대로 하게 내버려 둬.",
                  answer: "おけ")
            ],
            description: "1. 어떤 목적 때문에 미리 준비해두다.2. 아무것도 하지 않고 방치해두다とく는 회화체"),
        Grammar(
            id: 65,
            step: -1,
            level: "",
            grammar: "には",
            connectionWays: "동사 사전형명사",
            means: "1. ~하려면, ~하기 위해서는2. ~하기에는",
            examples: [
              Example(
                  word: "新しい生活に慣れるには時間が必要.",
                  mean: "새로운 생활에 익숙해지려면 시간이 필요해.",
                  answer: "には"),
              Example(
                  word: "成功するには, 成功するまで決して諦めないことだ.",
                  mean: "성공하려면 성공할 때까지 결코 포기하지 않는 것이다.",
                  answer: "には"),
              Example(
                  word: "痩せるにはまず食生活を見直すことから始めよう.",
                  mean: "살을 빼려면 먼저 식생활을 재검토하는 것부터 시작하자.",
                  answer: "には"),
              Example(
                  word: "再び同じ過ちを犯さないようにするには, しっかり反省するのが大切だ.",
                  mean: "다시는 같은 실수를 저지르지 않으려면 제대로 반성하는 것이 중요하다.",
                  answer: "には"),
              Example(
                  word: "何かアドバイスをしてあげるには情報が少なすぎる.",
                  mean: "뭔가 조언을 해주기에는 정보가 너무 적어.",
                  answer: "には"),
              Example(
                  word: "銀行に行くには, そこの角を左に曲がればいいですよ.",
                  mean: "은행에 가려면 저기 모퉁이에서 왼쪽으로 돌면 돼요.",
                  answer: "には"),
              Example(
                  word: "恋をするにはまだ若すぎる.",
                  mean: "사랑을 하기에는 아직 너무 어리다.",
                  answer: "には"),
              Example(
                  word: "自分を理解してもらうには, まず相手を理解してあげなければ始まらない.",
                  mean: "자신을 이해시키기 위해서는 먼저 상대방을 이해해 주지 않으면 시작되지 않는다.",
                  answer: "には")
            ],
            description:
                "1. 동작의 목적앞 문장에는 목적을 뒷 문장에는 그 목적을 달생하기 위해서 필요한 조건을 서술함.2. 평가의 기준인명을 나타내는 명사에 대해서, 그 인물에게 어떤 상황에 대한 평가를 표현함.뒷 내용에는 주로 난이도에 관한 말이 온다."),
        Grammar(
            id: 106,
            step: -1,
            level: "",
            grammar: "続ける",
            connectionWays: "동사 ます형",
            means: "계속~하다",
            examples: [
              Example(
                  word: "以前もらったペンを今でも使い続けている.",
                  mean: "이전에 받은 펜을 지금도 계속 사용하고 있다.",
                  answer: "続けている"),
              Example(
                  word: "努力し続けると必ず花開く.",
                  mean: "계속 노력하면 반드시 꽃이 핀다.",
                  answer: "続ける"),
              Example(
                  word: "夢の中で見知らぬ男に追われ続け, 起きた時には汗だくだった.",
                  mean: "꿈속에서 낯선 남자에게 계속 쫓겼고 일어났을 때는 땀투성이였다.",
                  answer: "続け"),
              Example(
                  word: "世界人口が増え続けている.",
                  mean: "세계 인구가 계속 증가하고 있다.",
                  answer: "続けている"),
              Example(
                  word: "画面を見続けると目に悪い.",
                  mean: "화면을 계속 보면 눈에 안 좋아.",
                  answer: "続ける"),
              Example(
                  word: "１時間待ち続けたけど, 結局彼は来なかった.",
                  mean: "1시간을 계속 기다렸지만 결국 그는 오지 않았다.",
                  answer: "続けた"),
              Example(
                  word: "定年までこの仕事をし続けるつもりはない.",
                  mean: "정년까지 이 일을 계속할 생각은 없다.",
                  answer: "続ける"),
              Example(
                  word: "昨晩から雨が降り続いている.",
                  mean: "어젯밤부터 비가 계속 내리고 있다.",
                  answer: "続いている")
            ],
            description: "동작의 계속·지속을 나타냄."),
        Grammar(
            id: 84,
            step: -1,
            level: "",
            grammar: "～みたいだ／みたいに／みたいな",
            connectionWays: "동사 보통형＋みたいだい형용사 보통형＋みたいだな형용사 어간＋みたいだ명사＋みたいだ ",
            means: "~것 같다 / ~ 같이 / ~같은",
            examples: [
              Example(
                  word: "葬式みたいな話は聞きたくない.",
                  mean: "장례식 같은 얘기는 듣고 싶지 않아.",
                  answer: "みたいな"),
              Example(
                  word: "彼の鼻はバナナみたいに長い.",
                  mean: "그의 코는 바나나처럼 길다.",
                  answer: "みたいに"),
              Example(
                  word: "彼女は太陽みたいな人だ.",
                  mean: "그녀는 태양 같은 사람이다.",
                  answer: "みたいな"),
              Example(
                  word: "最近は子供みたいな大人が増えている.",
                  mean: "요즘은 어린애 같은 어른들이 늘고 있어.",
                  answer: "みたいな"),
              Example(
                  word: "毎日ゴミみたいな生活をしている.",
                  mean: "매일 쓰레기 같은 생활을 하고 있다.",
                  answer: "みたいな"),
              Example(
                  word: "兄みたいな人にはなりたくない.",
                  mean: "형 같은 사람이 되고 싶지 않아.",
                  answer: "みたいな"),
              Example(
                  word: "あの人みたいに日本語を流暢に話せるようになりたい.",
                  mean: "그 사람처럼 일본어를 유창하게 할 수 있게 되고 싶어.",
                  answer: "みたいに"),
              Example(
                  word: "今年の誕生日も, 去年みたいに盛大に祝ってほしい.",
                  mean: "올해 생일도 작년처럼 성대하게 축하해줬으면 좋겠어.",
                  answer: "みたいに"),
              Example(
                  word: "チョコレートみたいな甘い物は食べると気持ち悪くなる.",
                  mean: "초콜릿 같은 단 음식은 먹으면 징그러워져.",
                  answer: "みたいな"),
              Example(
                  word: "数日前から風邪みたいな症状が続いている.",
                  mean: "며칠 전부터 감기 같은 증상이 계속되고 있다.",
                  answer: "みたいな"),
              Example(
                  word: "あそこのお店はいつも行列ができていて, どうやら人気があるみたいだ.",
                  mean: "저기 가게는 항상 줄이 서 있어서 아무래도 인기가 많은 것 같아.",
                  answer: "みたいだ"),
              Example(
                  word: "彼は舌打ちが癖になっているみたいだ.",
                  mean: "그는 혀를 차는 데 습관이 된 것 같다.",
                  answer: "みたいだ"),
              Example(
                  word: "道が濡れてるし, 雨が降ったみたいです.",
                  mean: "길이 젖어있고 비가 왔나봐요.",
                  answer: "みたいです"),
              Example(
                  word: "あの二人は結婚したみたいだ.", mean: "저 둘은 결혼했나 봐.", answer: "みたいだ"),
              Example(
                  word: "うちの猫ちゃんは私がいないと寂しいみたいだ.",
                  mean: "우리집 고양이는 내가 없으면 외로운가봐.",
                  answer: "みたいだ")
            ],
            description: "みないな ~것 같은 (ような의 회화체)みたいに ~것 같이, ~처럼  (ように의 회화체)"),
        Grammar(
            id: 66,
            step: -1,
            level: "",
            grammar: "～によって／によっては／により／による",
            connectionWays: "명사에 직접 접속",
            means: "~에 따른, ~에 의한",
            examples: [
              Example(
                  word: "テストの結果によって, 成績を決める.",
                  mean: "시험 결과에 따라 성적을 결정한다.",
                  answer: "によって"),
              Example(
                  word: "未成年の喫煙は法律によって禁じられている.",
                  mean: "미성년 흡연은 법률에 의해 금지되어 있다.",
                  answer: "によって"),
              Example(
                  word: "行くかどうかは, 明日の天気によって決めるつもりだ.",
                  mean: "갈지 말지는 내일 날씨에 따라 결정할 거야.",
                  answer: "によって"),
              Example(
                  word: "地域の安全はそこに住む人々の協力によって保たれている.",
                  mean: "지역의 안전은 그곳에 사는 사람들의 협력으로 유지되고 있다.",
                  answer: "によって"),
              Example(
                  word: "インターネットによって, 世界中のニュースを知ることができるようになった.",
                  mean: "인터넷을 통해 전 세계 뉴스를 알 수 있게 됐다.",
                  answer: "によって"),
              Example(
                  word: "職場環境を改善することによって, 従業員満足度を高める.",
                  mean: "직장 환경을 개선함으로써 종업원 만족도를 높인다.",
                  answer: "によって"),
              Example(
                  word: "事故によって片足を失ってしまった.",
                  mean: "사고로 인해 한쪽 다리를 잃고 말았다.",
                  answer: "によって"),
              Example(
                  word: "今回の大雨により孤立した地域があるらしい. ",
                  mean: "이번 폭우로 인해 고립된 지역이 있다고 한다.",
                  answer: "により"),
              Example(
                  word: "不況によって多くの会社が倒産している.",
                  mean: "불황으로 인해 많은 회사가 도산하고 있다.",
                  answer: "によって"),
              Example(
                  word: "台風によって延期になりました.",
                  mean: "태풍으로 인해 연기되었습니다.",
                  answer: "によって"),
              Example(
                  word: "キノコの毒によって体調不良になりました.",
                  mean: "버섯 독으로 인해 몸이 안 좋아졌어요.",
                  answer: "によって"),
              Example(
                  word: "天守閣は火事によって消失しました.",
                  mean: "천수각은 화재로 소실되었습니다.",
                  answer: "によって"),
              Example(
                  word: "パートナーの浮気によって離婚しました.",
                  mean: "파트너의 바람 때문에 이혼했어요.",
                  answer: "によって"),
              Example(
                  word: "２０１２年, ＣＥＲＮによってヒッグス粒子とみられる粒子が発見された.",
                  mean: "2012년 CERN에 의해 힉스 입자로 보이는 입자가 발견됐다.",
                  answer: "によって"),
              Example(
                  word: "金閣寺は足利義満によって建てられた.",
                  mean: "금각사는 아시카가 요시미쓰에 의해 세워졌다.",
                  answer: "によって"),
              Example(
                  word: "壁が何者かによって壊された.",
                  mean: "벽이 누군가에 의해 부서졌다.",
                  answer: "によって"),
              Example(
                  word: "人によって考え方は違う.", mean: "사람마다 생각은 다르다.", answer: "によって"),
              Example(
                  word: "天気予報によると, 所によっては大雨になるそうだ.",
                  mean: "일기예보에 따르면 곳에 따라서는 비가 많이 온다고 한다.",
                  answer: "によって"),
              Example(
                  word: "場合によっては強硬策をとらなくてはならなくなる.",
                  mean: "경우에 따라서는 강경책을 쓰지 않으면 안 된다.",
                  answer: "によって"),
              Example(
                  word: "校長先生による特別講義が行われた.",
                  mean: "교장 선생님의 특강이 진행되었다.",
                  answer: "による"),
              Example(
                  word: "上司からのパワハラによる苦痛は, うつ病にかかってしまうリスクを引き起こす.",
                  mean: "상사의 갑질로 인한 고통은 우울증에 걸릴 위험을 일으킨다.",
                  answer: "による"),
              Example(
                  word: "Ａ国は空軍によるミサイル攻撃を否定している.",
                  mean: "A국은 공군에 의한 미사일 공격을 부정하고 있다.",
                  answer: "による")
            ],
            description: "1. 수단, 방법을 나타냄2. 원인, 이유를 나타냄"),
      ],
    );

    initTutorial();
    showTutorial();
  }

  void initTutorial() {
    targets.addAll(
      [
        TargetFocus(
          identify: "grammar",
          keyTarget: grammarKey,
          contents: [
            TargetContent(
                align: ContentAlign.bottom,
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '문법 정보 보기',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20.0),
                    ),
                    Text.rich(
                      TextSpan(
                        text: "",
                        style: TextStyle(color: Colors.white, fontSize: 14.0),
                        children: [
                          TextSpan(
                              text: '문법', style: TextStyle(color: Colors.red)),
                          TextSpan(text: ' 버튼을 눌러서 문법 정보를 확인 할 수 있습니다.'),
                        ],
                      ),
                    ),
                  ],
                )),
          ],
        ),
        TargetFocus(
          identify: "exampleKey",
          keyTarget: exampleKey,
          contents: [
            TargetContent(
              align: ContentAlign.bottom,
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '문법 예시',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Text.rich(
                    TextSpan(
                      text: "",
                      style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 14.0),
                      children: [
                        TextSpan(
                            text: '예시', style: TextStyle(color: Colors.red)),
                        TextSpan(text: ' 버튼을 클릭하면 문법의 예시를 볼 수 있습니다. '),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        TargetFocus(
          identify: "eyeIcon",
          keyTarget: eyeIconKey,
          contents: [
            TargetContent(
              align: ContentAlign.top,
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '예시 뜻 보기',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0),
                  ),
                  Text.rich(
                    TextSpan(
                      text: "",
                      style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 14.0),
                      children: [
                        TextSpan(
                            text: '눈', style: TextStyle(color: Colors.red)),
                        TextSpan(text: ' 버튼을 클릭하여 예시의 뜻을 확인할 수 있습니다.'),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        TargetFocus(
          identify: "saveIcon",
          keyTarget: saveIconKey,
          contents: [
            TargetContent(
                align: ContentAlign.top,
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '예시 복사 하기',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20.0),
                    ),
                    Text.rich(
                      TextSpan(
                        text: "",
                        style: TextStyle(
                            // fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 14.0),
                        children: [
                          TextSpan(
                              text: '파일', style: TextStyle(color: Colors.red)),
                          TextSpan(text: ' 버튼을 클릭하여 예시를 복사(Ctrl+C) 할 수 있습니다.'),
                        ],
                      ),
                    ),
                  ],
                ))
          ],
        ),
        TargetFocus(
          identify: "test",
          keyTarget: testKey,
          contents: [
            TargetContent(
              align: ContentAlign.bottom,
              child: const TutorialText(
                title: '문법 테스트 하기',
                subTitles: [
                  '예시를 기반으로 문법 테스트를 진행할 수 있습니다.',
                ],
              ),
            )
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const BackButton(color: Colors.white),
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              key: testKey,
              'TEST',
              style: const TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: SizedBox.expand(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: AnimatedSize(
                  // Down 애니메이션
                  alignment: const Alignment(0, -1),
                  duration: const Duration(milliseconds: 500),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    width: size.width * 0.85,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(1, 1),
                        )
                      ],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            isClick = !isClick;
                            setState(() {});
                          },
                          child: Text(
                            key: grammarKey,
                            grammar.grammar,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Visibility(
                          visible: isClick,
                          child: const Divider(height: 20),
                        ),
                        Visibility(
                          visible: isClick,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (grammar.connectionWays.isNotEmpty)
                                GrammarCardSection(
                                    title: '접속 형태',
                                    content: grammar.connectionWays),
                              if (grammar.connectionWays.isNotEmpty)
                                const Divider(height: 20),
                              if (grammar.means.isNotEmpty)
                                GrammarCardSection(
                                    title: '뜻', content: grammar.means),
                              if (grammar.means.isNotEmpty)
                                const Divider(height: 20),
                              if (grammar.description.isNotEmpty)
                                GrammarCardSection(
                                    title: '설명', content: grammar.description),
                              const Divider(height: 20),
                              InkWell(
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          blurRadius: 1,
                                          offset: const Offset(1, 1),
                                        ),
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          blurRadius: 1,
                                          offset: const Offset(-1, -1),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(10)),
                                  // height: 30,
                                  width: double.infinity,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      key: exampleKey,
                                      '예제',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        color: Colors.blue,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  showExample();
                                },
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              ...List.generate(
                grammars.length,
                (index) => GrammarCard(
                  grammar: grammars[index],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> showExample() {
    return Get.bottomSheet(
      backgroundColor: AppColors.scaffoldBackground,
      persistent: false,
      Padding(
        padding: const EdgeInsets.all(16.0).copyWith(right: 0),
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ...List.generate(grammar.examples.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: TouchableJapanese(
                                underlineColor: Colors.black,
                                japanese: grammar.examples[index].word,
                                clickTwice: false,
                                fontSize: 14,
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    print('??');
                                    isClickEye = true;
                                    setState(() {});
                                  },
                                  icon: SvgPicture.asset(
                                    'assets/svg/eye.svg',
                                    key: index == 0 ? eyeIconKey : null,
                                    color: Colors.white,
                                    width: 20,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      // copyWord(widget.example.word);
                                    },
                                    icon: Icon(
                                      key: index == 0 ? saveIconKey : null,
                                      Icons.save,
                                      color: Colors.white,
                                    ))
                              ],
                            )
                          ],
                        ),
                        if (index == 0 && isClickEye)
                          Text(
                            grammar.examples[index].mean,
                            style:
                                TextStyle(color: Colors.grey, fontSize: 14 - 2),
                          ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
