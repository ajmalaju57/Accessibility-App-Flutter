// ignore_for_file: depend_on_referenced_packages, unnecessary_import

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:accessibility_app/data/models/history_model.dart';

part 'home_page_state.dart';

TextEditingController language = TextEditingController(text: "en-US");

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(HomePageInitial()) {
    initSpeech();
    getHistory();
  }

  final SpeechToText speechToText = SpeechToText();
  FlutterTts flutterTts = FlutterTts();

  bool speechEnabled = false;
  String wordsSpoken = "";

  void initSpeech() async {
    speechEnabled = await speechToText.initialize();
    emit(HomePageInitial());
  }

  void startListening() async {
    await speechToText.listen(
        onResult: onSpeechResult, localeId: language.text);

    emit(HomePageInitial());
  }

  void stopListening() async {
    await speechToText.stop();
    emit(HomePageInitial());
  }

  void onSpeechResult(result) {
    wordsSpoken = "${result.recognizedWords}";
    speechToText.isNotListening == true
        ? addHistory(
            History(wordsSpoken: wordsSpoken, languageCode: language.text))
        : null;

    emit(HomePageInitial());
  }

  final boxName = 'HistoryBox';

  void addHistory(History item) async {
    var box = await Hive.openBox<History>(boxName);
    box.add(item);
    emit(HistoryDataLoaded(box: box.values.toList()));
  }

  getHistory() async {
    var box = await Hive.openBox<History>(boxName);
    emit(HistoryDataLoaded(box: box.values.toList()));
  }

  speak(String text, String laug) async {
    flutterTts.setLanguage(laug);
    await flutterTts.setVolume(1.0);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.setPitch(1.0);

    await flutterTts.speak(text);
  }
}
