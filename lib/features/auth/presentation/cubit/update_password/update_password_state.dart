part of 'update_password_cubit.dart';

abstract class UpdatePasswordState extends Equatable {
  const UpdatePasswordState();

  @override
  List<Object> get props => [];
}

class UpdatePasswordInitial extends UpdatePasswordState {}

class UpdatePasswordLoadingState extends UpdatePasswordState {}

class UpdatePasswordSuccessState extends UpdatePasswordState {}

class UpdatePasswordErrorState extends UpdatePasswordState {
  final String message;

  const UpdatePasswordErrorState({required this.message});
}
