import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'package:get/get.dart';
import 'package:japanese_voca/model/my_word.dart';
import 'package:japanese_voca/model/word.dart';
import 'package:japanese_voca/repository/localRepository.dart';

class App2 extends StatefulWidget {
  const App2({super.key});

  @override
  State<App2> createState() => _App2State();
}

class _App2State extends State<App2> {
  List<MyWord> savedWords = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
                onPressed: () async {
                  FilePickerResult? pickedFile =
                      await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['xlsx'],
                    withData: true,
                    allowMultiple: false,
                  );

                  if (pickedFile != null) {
                    var bytes = pickedFile.files.single.bytes;

                    var excel = Excel.decodeBytes(bytes!);

                    for (var table in excel.tables.keys) {
                      for (var row in excel.tables[table]!.rows) {
                        print('-------------------------------');

                        String word = (row[0] as Data).value.toString();
                        String yomikata = (row[1] as Data).value.toString();
                        String mean = (row[2] as Data).value.toString();

                        MyWord newWord = MyWord(
                          word: word,
                          mean: mean,
                          yomikata: yomikata,
                        );

                        print('newWord: ${newWord}');
                        LocalReposotiry.saveMyWord(newWord);
                        // savedWords.add(newWord);
                      }
                    }
                  } else {
                    // User canceled the picker
                  }
                  // await Get.dialog(AlertDialog());
                  // await Get.dialog(AlertDialog(
                  //   title: Text('aaa'),
                  //   // content: Text('${savedWords.length ?? 0}의 단어를 저장하시겠습니까?'),
                  //   actions: [
                  //     TextButton(
                  //         onPressed: () => Get.back(),
                  //         child: const Text('NO')),
                  //     TextButton(
                  //       onPressed: () {
                  //         print('YES!! and What do you do next ?');
                  //       },
                  //       child: const Text('YES'),
                  //     )
                  //   ],
                  // ));
                },
                child: const Text('Upload')),
            ElevatedButton(
                onPressed: () async {
                  var excel = Excel.createExcel();

                  Sheet sheetObject = excel['SheetName'];
                  print('sheetObject: ${sheetObject}');

                  var fileBytes =
                      excel.save(fileName: 'My_Excel_File_Name.xlsx');

                  print('fileBytes: ${fileBytes}');

                  String? selectedDirectory =
                      await FilePicker.platform.getDirectoryPath();

                  if (selectedDirectory == null) {
                    // User canceled the picker
                  }
                  print('selectedDirectory: ${selectedDirectory}');

                  File(selectedDirectory!)
                    ..createSync(recursive: true)
                    ..writeAsBytes(fileBytes!);
                },
                child: Text('SAVE'))
          ],
        ),
      ),
    ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  var intStream = StreamController<int>();
  var stringStream = StreamController<String>.broadcast();

  @override
  void initState() {
    super.initState();
    Generator(intStream);
    Coordinator(intStream, stringStream);
    Consumer(stringStream);
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
    // _counterStream.sink.add(_counter);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('widget.title'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              StreamBuilder<String>(
                stream: stringStream.stream,
                initialData: "a",
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print('snapshot.: ${snapshot.error}');

                    return Container();
                  }
                  return Text(
                    '${snapshot.data}',
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

// Consumerクラス
// データの利用を担当する
class Consumer {
  //コンストラクタでString型のStreamを受け取る
  Consumer(StreamController<String> stringStream) {
    // Streamをlistenしてデータが来たらターミナルに表示する
    stringStream.stream.listen((data) async {
      print("Consumerが$dataを使ったよ");
    });
  }
}

class Generator {
  Generator(StreamController<int> intStream) {
    Timer.periodic(const Duration(seconds: 5), (timer) {
      int data = Random().nextInt(100);

      print('$data is Created by generator');

      intStream.sink.add(data);
    });
  }
}

class Coordinator {
  Coordinator(
      StreamController<int> intSream, StreamController<String> stringStream) {
    intSream.stream.listen((event) {
      String newData = event.toString();

      print("Coordinatorが$event(数値)から$newData(文字列)に変換したよ");

      stringStream.sink.add(newData);
    });
  }
}
