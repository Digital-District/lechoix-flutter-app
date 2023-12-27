part of 'cart_cubit.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

class CartInitial extends CartState {}

class GetCartDataLoading extends CartState {}

class GetCartDataSuccess extends CartState {
   final double total;

  const GetCartDataSuccess(this.total);
}

class GetCartDataError extends CartState {}

class GetCartDataFailed extends CartState {}

class ChangePrice extends CartState {
  final double total;

  const ChangePrice(this.total);
}
