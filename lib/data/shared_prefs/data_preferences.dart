import 'package:client/data/shared_prefs/shared_preferences_impl.dart';

enum LoginType { guest, email, google}

abstract mixin class DataPreferences{
  String? getToken();
  void setToken(String value);
  void signOut();

  String? getLoginType();
  void setLoginType(LoginType value);
}