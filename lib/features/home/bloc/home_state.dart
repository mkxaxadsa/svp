part of 'home_bloc.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoadedState extends HomeState {
  var coins;
  var gems;

  HomeLoadedState({
    required this.coins,
    required this.gems,
  });
}
