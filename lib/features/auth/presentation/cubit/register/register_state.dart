part of 'register_cubit.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final RegisterResponse registerinfo;
  const RegisterSuccess({required this.registerinfo});
}

class RegisterError extends RegisterState {
  final String message;
  const RegisterError({required this.message});
}

class ChooseFemaleType extends RegisterState {}

class ChooseMaleType extends RegisterState {}

class GetRegisterParametersSuccessState extends RegisterState {}

class GetRegisterParametersErrorState extends RegisterState {}

class GetRegisterParametersLoadingState extends RegisterState {}

class GetStateByCountrySuccessState extends RegisterState {}

class GetStateByCountryErrorState extends RegisterState {}

class GetStateByCountryLoadingState extends RegisterState {}
