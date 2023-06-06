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

    return box.get('user');
  }
}
