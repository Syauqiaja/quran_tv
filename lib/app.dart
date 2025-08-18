import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quran_tv/config/routes/app_route.dart';
import 'package:quran_tv/config/themes/theme.dart';
import 'package:quran_tv/core/di/injections.dart';
import 'package:quran_tv/domain/repositories/quran_repository.dart';
import 'package:quran_tv/domain/repositories/reciter_repository.dart';
import 'package:quran_tv/presentation/controller/mushaf/mushaf_bloc.dart';
import 'package:quran_tv/presentation/controller/quran_list/quran_list_bloc.dart';
import 'package:quran_tv/presentation/controller/reciter_list/reciter_list_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ReciterListBloc(getIt<ReciterRepository>())),
        BlocProvider(create: (context) => QuranListBloc(getIt<QuranRepository>()),),
        BlocProvider(create: (context) => MushafBloc(getIt<QuranRepository>()),),
      ],
      child: MaterialApp.router(
        title: 'Altara Quran TV',
        theme: darkTheme,
        routerConfig: router,
      ),
    );
  }
}
