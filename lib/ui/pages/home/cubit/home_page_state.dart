// ignore_for_file: must_be_immutable

part of 'home_page_cubit.dart';

@immutable
sealed class HomePageState {}

final class HomePageInitial extends HomePageState {}


class HistoryDataLoaded extends HomePageState {
  List<History> box;
  HistoryDataLoaded({required this.box});
}