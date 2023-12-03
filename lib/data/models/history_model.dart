import 'package:hive/hive.dart';
part 'history_model.g.dart';

@HiveType(typeId: 0)
class History {
  @HiveField(0)
  String wordsSpoken ;
  @HiveField(1)
  String languageCode ;

  History({
    required this.wordsSpoken,
    required this.languageCode,
  });
}