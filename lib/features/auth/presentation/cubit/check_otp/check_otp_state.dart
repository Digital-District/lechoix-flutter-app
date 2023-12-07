part of 'check_otp_cubit.dart';

abstract class CheckOtpState extends Equatable {
  const CheckOtpState();

  @override
  List<Object> get props => [];
}

class CheckOtpInitial extends CheckOtpState {}

class CheckOtpLoading extends CheckOtpState {}

class CheckOtpSuccess extends CheckOtpState {
  final int userId;

  const CheckOtpSuccess({required this.userId});
}

class CheckOtpError extends CheckOtpState {
  final String message;

  const CheckOtpError({required this.message});
}
