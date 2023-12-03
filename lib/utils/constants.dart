//main.dart

import 'package:flutter/material.dart';

List<Map<String, dynamic>> languages = [
  {'name': 'English', 'code': "en-US"},
  {'name': 'Malayalam', 'code': "ml-IN"},
];

List<Map<String, dynamic>> fonts = [
  {'name': 'Merri Weather', 'code': 'Merriweather-Regular'},
  {'name': 'Rubik Bubbles', 'code': 'RubikBubbles-Regular'},
];

void get hideKeyboard => FocusManager.instance.primaryFocus?.unfocus();

enum ThemeModeEnum { light, dark }
