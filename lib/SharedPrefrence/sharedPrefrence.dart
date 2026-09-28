// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// class SharedPrefService extends GetxService {
//
//   late SharedPreferences _prefService ;
//
//   static const String keyProfileImage = "user_profile_image";
//
//   Future<SharedPrefService> init()async {
//     _prefService = await  SharedPreferences.getInstance();
//     return this ;
//   }
//
//   Future<bool> saveImagePath(String path)async{
//     return await _prefService.setString(keyProfileImage , path);
//   }
//
//   String getImagePath(){
//     return _prefService.getString(keyProfileImage) ?? '';
//   }
//
//   Future<bool> remover (String key)async {
//     return await _prefService.remove(key);
//   }
//   Future<bool> clearAll ()async {
//     return await _prefService.clear();
//   }
// }
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService extends GetxService {
  late SharedPreferences _prefService;

  static const String keyProfileImage = "user_profile_image";
  static const String keyIsLoggedIn = "is_logged_in";

  Future<SharedPrefService> init() async {
    _prefService = await SharedPreferences.getInstance();
    return this;
  }

  Future<bool> saveLoginStatus(bool isLoggedIn) async {
    return await _prefService.setBool(keyIsLoggedIn, isLoggedIn);
  }

  bool isLoggedIn() {
    return _prefService.getBool(keyIsLoggedIn) ?? false;
  }

  Future<bool> saveImagePath(String path) async {
    return await _prefService.setString(keyProfileImage, path);
  }

  String getImagePath() {
    return _prefService.getString(keyProfileImage) ?? '';
  }

  Future<bool> remover(String key) async {
    return await _prefService.remove(key);
  }

  Future<bool> clearAll() async {
    return await _prefService.clear();
  }
}
