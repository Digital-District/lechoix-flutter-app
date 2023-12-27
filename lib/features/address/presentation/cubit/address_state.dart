part of 'address_cubit.dart';

abstract class AddressState extends Equatable {
  const AddressState();

  @override
  List<Object> get props => [];
}

class AddressInitial extends AddressState {}

class MyAddressLoading extends AddressState {}

class MyAddressError extends AddressState {}

class MyAddressSuccess extends AddressState {
  final List<AddressModel> myAddress;

  const MyAddressSuccess({required this.myAddress});
    @override
  List<Object> get props => [myAddress];
}

class ChangeMyAddressIndex extends AddressState {
  final int index;
  const ChangeMyAddressIndex({required this.index});
  @override
  List<Object> get props => [index];
}


class AddAddressLoading extends AddressState {}
class AddAddressError extends AddressState {}
class AddAddressSuccess extends AddressState {}
class DeleteAddressSuccess extends AddressState {}
