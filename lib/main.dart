// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:accessibility_app/data/models/history_model.dart';
import 'package:accessibility_app/ui/pages/accessibility/cubit/thememode_cubit.dart';
import 'package:accessibility_app/ui/pages/accessibility/cubit/thememode_state.dart';
import 'package:accessibility_app/ui/pages/landing/landing_page.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:accessibility_app/utils/colors.dart';
import 'package:accessibility_app/utils/constants.dart';
import 'package:accessibility_app/utils/strings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(HistoryAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          var textTheme = TextTheme(
            titleMedium: TextStyle(fontFamily: state.fontFamily),
            bodyLarge: TextStyle(fontFamily: state.fontFamily),
            bodyMedium: TextStyle(fontFamily: state.fontFamily),
            displayLarge: TextStyle(fontFamily: state.fontFamily),
            labelLarge: TextStyle(fontFamily: state.fontFamily),
            bodySmall: TextStyle(fontFamily: state.fontFamily),
            displayMedium: TextStyle(fontFamily: state.fontFamily),
            displaySmall: TextStyle(fontFamily: state.fontFamily),
            headlineMedium: TextStyle(fontFamily: state.fontFamily),
            headlineSmall: TextStyle(fontFamily: state.fontFamily),
            titleLarge: TextStyle(fontFamily: state.fontFamily),
            headlineLarge: TextStyle(fontFamily: state.fontFamily),
          );
          return MaterialApp(
              title: appName,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                textTheme: textTheme,
                appBarTheme: const AppBarTheme(
                    backgroundColor: colorWhite, elevation: 0),
                scaffoldBackgroundColor: background,
                colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
                useMaterial3: true,
              ),
              themeMode: state.themeMode == ThemeModeEnum.light
                  ? ThemeMode.light
                  : ThemeMode.dark,
              darkTheme: ThemeData.dark().copyWith(
                textTheme: textTheme,
                useMaterial3: true,
                appBarTheme: AppBarTheme(
                    backgroundColor: primaryColor,
                    titleTextStyle: TextStyle(
                        color: colorWhite, fontFamily: state.fontFamily)),
              ),
              home: LandingPage());
        },
      ),
    );
  }
}
