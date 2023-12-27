part of 'account_cubit.dart';

abstract class AccountState extends Equatable {
  const AccountState();

  @override
  List<Object> get props => [];
}

class AccountInitial extends AccountState {}

class AccountLoading extends AccountState {}

class AccountLoaded extends AccountState {}

class AccountError extends AccountState {}

class EditAccountLoading extends AccountState {}

class EditAccountLoaded extends AccountState {}

class EditAccountError extends AccountState {}

class StaticPageLoading extends AccountState {}

class StaticPageLoaded extends AccountState {
  final StaticPageResponse response;

  const StaticPageLoaded({required this.response});
    @override
  List<Object> get props => [response];
  
}

class StaticPageError extends AccountState {}
class ContactUsLoading extends AccountState {}
class ContactUsSuccess extends AccountState {}
