part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeUserDataFetchSuccessState extends HomeState {
  final List<UserApiResModel> users;

  HomeUserDataFetchSuccessState({required this.users});
}

class HomeUserDateFetchFailedState extends HomeState {
  final String errorMsg;

  HomeUserDateFetchFailedState({required this.errorMsg});
}
