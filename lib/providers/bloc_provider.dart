import 'package:client/bloc/home/home_bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/data_repository.dart';

MultiBlocProvider provideBlocs(DataRepository dataRepository, Widget child) {
  return MultiBlocProvider(providers: [
    BlocProvider(create: (ctx) => HomeBloc(dataRepository: dataRepository))
  ], child: child);
}
