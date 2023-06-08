import 'dart:developer';

import 'package:hive/hive.dart';
import 'package:japanese_voca/model/user.dart';

class UserRepository2 {
  static Future<bool> isExistData() async {
    final box = Hive.box(User.boxKey);
    return box.isNotEmpty;
  }

  static Future<User> init(User user) async {
    final box = Hive.box(User.boxKey);

    await box.put('user', user);

    return user;
  }

  User getUser() {
    final box = Hive.box(User.boxKey);
    User user = box.get('user');
    print('user: ${user}');
    return user;
  }

  Future<bool> updateScore(User user) async {
    final box = Hive.box(User.boxKey);
    try {
      await box.put('user', user);
      print('update User : ${box.get('user')}');
      return true;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }
}
