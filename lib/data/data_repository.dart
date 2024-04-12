import 'package:client/data/api/api_impl.dart';
import 'package:client/data/db/doc_db.dart';
import 'package:client/data/shared_prefs/data_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sqflite/sqflite.dart';

import 'shared_prefs/shared_preferences_impl.dart';

class DataRepository {
  late final DataPreferences sharedPreferencesImpl;
  late final ApiImpl apiImpl;
  late final DocDb docDatabase;

  DataRepository(
      {required this.sharedPreferencesImpl,
      required this.apiImpl,
      required this.docDatabase});

  Future<void> logout(){
    User? currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      sharedPreferencesImpl.signOut();
      return FirebaseAuth.instance.signOut();
    }
    return Future(() => null);
  }
}
