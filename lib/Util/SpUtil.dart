import 'dart:async';
import 'dart:convert';
import 'package:fvm/Model/auth/LoginModel.dart';
import 'package:fvm/Util/Util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synchronized/synchronized.dart';

class SpUtil {
  static  SpUtil? _singleton;
  static  SharedPreferences? _prefs;
  static Lock _lock = Lock();
  static Future<SpUtil?> getInstance() async {
    if (_singleton == null) {
      await _lock.synchronized(() async {
        if (_singleton == null) {
          // keep local instance till it is fully initialized.
          var singleton = SpUtil._();
          await singleton._init();
          _singleton = singleton;
        }
      });
    }
    return _singleton;
  }
  SpUtil._();
  Future _init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // put object
  static Future<bool>? putObject(String key, Object value) {
    if (_prefs == null) return null;
    return _prefs?.setString(key, value == null ? "" : json.encode(value));
  }

  // get obj
  static T getObj<T>(String key, T f(Map v), {required T defValue}) {
    Map? map = getObject(key);
    return map == null ? defValue : f(map);
  }

  // get object
  static Map? getObject(String key) {
    if (_prefs == null) return null;
    String? _data = _prefs?.getString(key);
    return (_data == null || _data.isEmpty) ? null : json.decode(_data);
  }

  // put object list
  static Future<bool>? putObjectList(String key, List<Object> list) {
    if (_prefs == null) return null;
    List<String>? _dataList = list.map((value) {
      return json.encode(value);
    }).toList();
    return _prefs?.setStringList(key, _dataList);
  }
////////////////////////////////////////////////////////////////////
  // AppVersion
  static String getAppVersion({String defValue = ''}) {
    if (_prefs == null) return defValue;
    return _prefs?.getString("appVersion") ?? defValue;
  }
  static Future<bool>? setAppVersion(String appVersion) {
    if (_prefs == null) return null;
    return _prefs?.setString("appVersion", appVersion);
  }

  // Login
  static bool getLogin({bool defValue = false}) {
    if (_prefs == null) return defValue;
    return _prefs?.getBool("login") ?? defValue;
  }
  static Future<bool>? setLogin(bool appVersion) {
    if (_prefs == null) return null;
    return _prefs?.setBool("login", appVersion);
  }
//////////////////////////////////////////////////////////////////

  // mode
  static bool getIsSellerMode({bool defValue = false}) {
    if (_prefs == null) return defValue;
    return _prefs?.getBool("mode") ?? defValue;
  }
  static Future<bool>? setIsSellerMode(bool appVersion) {
    if (_prefs == null) return null;
    return _prefs?.setBool("mode", appVersion);
  }


  // Login
  static bool getIsLogin({bool defValue = false}) {
    if (_prefs == null) return defValue;
    return _prefs?.getBool("login") ?? defValue;
  }
  static Future<bool>? setIsLogin(bool appVersion) {
    if (_prefs == null) return null;
    return _prefs?.setBool("login", appVersion);
  }

  // user data
  static LoginModel? getUserData() {
    if (_prefs == null) return null;
    String? json = _prefs?.getString('user');
    Util.consoleLog("asds" +json.toString());
    return LoginModel.fromJson(jsonDecode(json!));
  }
  static Future<bool>? setUserData(user) {
    if (_prefs == null) return null;
    return _prefs?.setString("user", json.encode(user));
  }

  ////////////////////////////////////////////////////////
  //Sp is initialized
  static bool isInitialized() {
    return _prefs != null;
  }

}