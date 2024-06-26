import 'data_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'settings_preferences.dart';


class SharedPreferencesImpl with SettingsPreferences, DataPreferences {
  final String spKeyFistOpenFlag = "spKeyFistOpenFlag";
  final String spKeyToken = "spKeyToken";
  final String spKeyDefaultLanguage = "spKeyDefaultLanguage";
  final String spKeyLoginType = "spKeyLoginType";

  late final SharedPreferences sharedPreferences;

  SharedPreferencesImpl();

  Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  String? getToken() {
    return sharedPreferences.getString(spKeyToken);
  }

  @override
  bool? getFirstOpenFlag() {
    return sharedPreferences.getBool(spKeyFistOpenFlag);
  }

  @override
  set firstOpenFlag(bool value) {
    sharedPreferences.setBool(spKeyFistOpenFlag, value);
  }

  @override
  void setToken(String value) {
    sharedPreferences.setString(spKeyToken, value);
  }

  @override
  String? getLoginType() {
    return sharedPreferences.getString(spKeyLoginType);
  }

  @override
  void setLoginType(LoginType value) {
    sharedPreferences.setString(spKeyLoginType , value.name);
  }


  @override
  void signOut() {
    sharedPreferences.clear();
  }
}
