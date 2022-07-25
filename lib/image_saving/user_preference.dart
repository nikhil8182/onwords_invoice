import 'dart:convert';
import 'package:onwords_invoice/image_saving/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static late SharedPreferences logData;

  static const _keyUser = 'user';
  static const myUser = User(imagePath: 'images/blank.png',);

  static Future init() async =>
      logData = await SharedPreferences.getInstance();

  static Future setUser(User user) async {
    final json = jsonEncode(user.toJson());
    await logData.setString(_keyUser, json);
  }

  static User getUser() {
    final json = logData.getString(_keyUser);
    return json == null ? myUser : User.fromJson(jsonDecode(json));
  }
}