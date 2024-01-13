import 'package:hive_flutter/adapters.dart';

const int ToakgoTypeId = 100;

@HiveType(typeId: ToakgoTypeId)
class Tango {
  @HiveField(1)
  late String headTitle;
  @HiveField(2)
  late String word;
  @HiveField(3)
  late String yomikata;
  @HiveField(4)
  late String mean;
}
