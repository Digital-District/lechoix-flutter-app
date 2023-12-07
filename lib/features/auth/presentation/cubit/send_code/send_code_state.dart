part of 'send_code_cubit.dart';

abstract class SendCodeState extends Equatable {
  const SendCodeState();

  @override
  List<Object> get props => [];
}

class ForgetPasswordInitial extends SendCodeState {}

class ForgetPasswordHasCode extends SendCodeState {
  final String code;

  const ForgetPasswordHasCode({required this.code});
}

class ForgetPasswordResendCode extends SendCodeState {
  final String code;

  const ForgetPasswordResendCode({required this.code});
}

class ForgetPasswordLoading extends SendCodeState {}

class ForgetPasswordError extends SendCodeState {
  final String message;
  const ForgetPasswordError({required this.message});
}
