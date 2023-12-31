part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

class HomeInitial extends HomeState {
  @override
  List<Object> get props => [];
}


class HomeSuccess extends HomeState {
  late int index;
  HomeSuccess(this.index);
  @override
  List<Object> get props => [index];
}

