import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:japanese_voca/1.new_app/models/new_japanese.dart';
import 'package:japanese_voca/1.new_app/models/new_japanese_list.dart';
import 'package:japanese_voca/1.new_app/models/new_voca_example.dart';
import 'package:japanese_voca/1.new_app/temp_data.dart';
import 'package:japanese_voca/common/admob/controller/ad_controller.dart';
import 'package:japanese_voca/common/network_manager.dart';
import 'package:japanese_voca/features/home/screens/home_screen.dart';
import 'package:japanese_voca/common/admob/banner_ad/test_banner_ad_controller.dart';
import 'package:japanese_voca/config/theme.dart';
import 'package:japanese_voca/model/hive_type.dart';
import 'package:japanese_voca/model/user.dart';
import 'package:japanese_voca/repository/grammar_step_repository.dart';
import 'package:japanese_voca/repository/jlpt_step_repository.dart';
import 'package:japanese_voca/repository/kangis_step_repository.dart';
import 'package:japanese_voca/repository/local_repository.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:japanese_voca/routes.dart';
import 'package:japanese_voca/user/controller/user_controller.dart';
import 'package:japanese_voca/user/repository/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  if (GetPlatform.isMobile) {
    await Hive.initFlutter();
  } else if (GetPlatform.isWindows) {
    Hive.init("C:/Users/kissco/Desktop/learning/jlpt_app/assets/hive");
  }

// if (!Hive.isAdapterRegistered(NewJapaneseId)) {
//     Hive.registerAdapter(NewJapaneseAdapter());
//   }
//   if (!Hive.isBoxOpen(NewJapaneseList.boxKey)) {
//     await Hive.openBox<NewJapaneseList>(NewJapaneseList.boxKey);
//   }
  if (!Hive.isAdapterRegistered(NewVocaExampleId)) {
    Hive.registerAdapter(NewVocaExampleAdapter());
  }
  if (!Hive.isBoxOpen(NewVocaExample.boxKey)) {
    await Hive.openBox<NewVocaExample>(NewVocaExample.boxKey);
  }

  if (!Hive.isAdapterRegistered(NewJapaneseId)) {
    Hive.registerAdapter(NewJapaneseAdapter());
  }
  if (!Hive.isBoxOpen(NewJapanese.boxKey)) {
    await Hive.openBox<NewJapanese>(NewJapanese.boxKey);
  }

  if (!Hive.isAdapterRegistered(NewJapaneseListId)) {
    Hive.registerAdapter(NewJapaneseListAdapter());
  }
  if (!Hive.isBoxOpen(NewJapaneseList.boxKey)) {
    await Hive.openBox<List<NewJapaneseList>>(NewJapaneseList.boxKey);
  }

  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    // NewJapaneseListRepository.putJapaneseLists(1);
    NewJapaneseListRepository.getJapaneseLists(1);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemings.dartTheme,
      initialRoute: HOME_PATH,
      getPages: AppRoutes.getPages,
    );
  }
}

class NewJapaneseListRepository {
  static Future<bool> isExistData() async {
    final box = Hive.box(NewJapaneseList.boxKey);
    final isExist = await box.get(NewJapaneseList.boxKey, defaultValue: []);

    return isExist == 0 ? false : true;
  }

  static Future<List<NewJapaneseList>> getJapaneseLists(int level) async {
    final box = Hive.box<List<NewJapaneseList>>(NewJapaneseList.boxKey);

    List<NewJapaneseList> newJapaneseLists = [];

    // (box.get('$level-${NewJapaneseList.boxKey}') as List<NewJapaneseList>).map(
    //   (newJapanese) => newJapaneseLists.add(newJapanese),
    // );

    return newJapaneseLists;
  }

  static Future<void> putJapaneseLists(int level) async {
    final box = Hive.box<List<NewJapaneseList>>(NewJapaneseList.boxKey);
    var selectedJlptLevelJson = temp_words;

    List<NewJapanese> newJapaneses = [];
    List<NewJapaneseList> newJapaneseLists = [];
    int chatper = 1;
    for (int i = 0; i < selectedJlptLevelJson.length; i++) {
      NewJapanese newJapanese = NewJapanese.fromMap(selectedJlptLevelJson[i]);
      newJapaneses.add(newJapanese);

      if (newJapaneses.length == 3) {
        NewJapaneseList newJapaneseList = NewJapaneseList(
          level: level,
          chatper: chatper,
          japaneses: newJapaneses,
        );
        newJapaneseLists.add(newJapaneseList);
        chatper++;
        newJapaneses.clear();
      }
    }
    await box.put('$level-${NewJapaneseList.boxKey}', newJapaneseLists);
  }
}
