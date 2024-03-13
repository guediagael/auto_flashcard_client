import 'package:client/data/api/api_impl.dart';
import 'package:client/data/db/doc_db.dart';
import 'package:client/data/shared_prefs/data_preferences.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../data/data_repository.dart';

MultiProvider provideDataSources(DataPreferences dataPreferences,
    DocDb docDatabase, ApiImpl apiImpl, Widget child) {
  return MultiProvider(
    providers: [
      Provider.value(value: docDatabase),
      Provider.value(value: dataPreferences),
      Provider.value(
        value: apiImpl,
      ),
      Provider(
          create: (ctx) => DataRepository(
              sharedPreferencesImpl: dataPreferences,
              apiImpl: apiImpl,
              docDatabase: docDatabase))
    ],
    child: child,
  );
}
