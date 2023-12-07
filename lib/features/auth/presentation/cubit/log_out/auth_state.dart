part of 'auth_cubit.dart';

abstract class LogOutState extends Equatable {
  const LogOutState();

  @override
  List<Object> get props => [];
}

class LogOutInitial extends LogOutState {}

class LogoutSuccess extends LogOutState {
  final String message;

  const LogoutSuccess({required this.message});
}
class LogoutError extends LogOutState {
  final String message;

  const LogoutError({required this.message});
}
class LogoutLoading extends LogOutState {}