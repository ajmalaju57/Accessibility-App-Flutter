import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:accessibility_app/data/shared_preferences/keys.dart';
import 'package:accessibility_app/data/shared_preferences/preference_functions.dart';
import 'package:accessibility_app/ui/pages/accessibility/cubit/thememode_state.dart';
import 'package:accessibility_app/utils/constants.dart';
import 'package:accessibility_app/utils/strings.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit()
      : super(ThemeState(
            themeMode: ThemeModeEnum.light, fontFamily: merriweather)) {
    _init();
  }

  Future<void> _init() async {
    dynamic userTheme = await SharedPref.getTheme();
    dynamic userFontStyle = await SharedPref.getFontStyle();
    emit(ThemeState(
      themeMode: userTheme == null
          ? ThemeModeEnum.light
          : userTheme == "dark"
              ? ThemeModeEnum.dark
              : ThemeModeEnum.light,
      fontFamily: userFontStyle ?? merriweather,
    ));
  }

  // Toggle between light and dark mode
  void toggleTheme() {
    SharedPref.saveTheme(
      key: userTheme,
      value: state.themeMode == ThemeModeEnum.light ? "dark" : "light",
    );
    emit(ThemeState(
      themeMode: state.themeMode == ThemeModeEnum.light
          ? ThemeModeEnum.dark
          : ThemeModeEnum.light,
      fontFamily: state.fontFamily,
    ));
  }

  void changeFont(String font) {
    SharedPref.saveFontStyle(key: userFontStyle, value: font);
    emit(ThemeState(
      themeMode: state.themeMode,
      fontFamily: font,
    ));
  }
}
