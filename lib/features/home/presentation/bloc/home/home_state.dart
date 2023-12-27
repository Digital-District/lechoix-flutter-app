part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class GetCitiesLoading extends HomeState {}

class GetCitiesSuccess extends HomeState {}

class GetCitiesError extends HomeState {}

class MasterActivityLoading extends HomeState {}

class MasterActivitySuccess extends HomeState {}

class MasterActivityError extends HomeState {}
class GetSlidesLoading extends HomeState {}

class GetSlidesSuccess extends HomeState {}

class GetSlidesError extends HomeState {}
