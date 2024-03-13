import 'dart:io';

import 'package:client/app_localization.dart';
import 'package:client/data/data_repository.dart';
import 'package:client/data/db/doc_db.dart';
import 'package:client/data/shared_prefs/shared_preferences_impl.dart';
import 'package:client/providers/bloc_provider.dart';
import 'package:client/providers/data_provider.dart';
import 'package:client/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'data/api/api_impl.dart';

var globalMessengerKey = GlobalKey<ScaffoldState>();
var navigatorState = GlobalKey<NavigatorState>();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final String defaultLocale = Platform.localeName;
  String language = defaultLocale.split('_')[0];

  if (!AppLocalization.languages().contains(language.toLowerCase())) {
    language = 'en';
  }

  SharedPreferencesImpl sharedPreferencesImpl = SharedPreferencesImpl();
  DocDb docDb = DocDb();
  ApiImpl apiImpl = ApiImpl(
      dataPreferences: sharedPreferencesImpl, defaultLanguage: language);
  Future.wait([sharedPreferencesImpl.init(), docDb.init()]).then((value) {
    runApp(provideDataSources(
        sharedPreferencesImpl, docDb, apiImpl, const MyApp()));
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auto Flashcards',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: provideBlocs(context.read<DataRepository>(), const SplashScreen()),
      localizationsDelegates: [
        AppLocalizationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
