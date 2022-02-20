import 'dart:convert';
import '../model/userModel.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageData extends GetxController {
  setUserData(UserModel user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userData', jsonEncode(user.toJson()));
  }

  _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userData = prefs.getString('userData') as String;
    return UserModel.fromJson(true, '', jsonDecode(userData));
  }

  Future<UserModel?> get getUser async {
    try {
      return await _getUserData();
    } catch (e) {
      return null;
    }
  }

  deleteUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
  }
}
