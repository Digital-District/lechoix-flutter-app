part of 'counter_cubit.dart';

abstract class CounterState extends Equatable {
  const CounterState();

  @override
  List<Object> get props => [];
}

class CounterInitial {
  int counterValue;
  CounterInitial({
    required this.counterValue,
  });
}
// class CounterInitial extends CounterState {}
class CounterMinus extends CounterState {}

class CounterPlus extends CounterState {}


