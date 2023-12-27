import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/toast.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterInitial> {
  CounterCubit() : super(CounterInitial(counterValue: 1));

  void decrement(
      {required int maxQuantity, required void Function() function}) {
    log("$maxQuantity +++++++");

    if (state.counterValue > 0) {
      emit(CounterInitial(counterValue: state.counterValue - 1));

      log("${state.counterValue} --");
      function();
    } else {
      emit(CounterInitial(counterValue: state.counterValue));

      log("$maxQuantity remove it from list");
    }
  }

  void increment(
      {required int maxQuantity, required void Function() function}) {
    log("$maxQuantity +++++++");

    if (state.counterValue < maxQuantity) {
      emit(CounterInitial(counterValue: state.counterValue + 1));
      log("${state.counterValue} ++");
      function();
    } else {
      showToast("No available quantity");
      emit(CounterInitial(counterValue: state.counterValue));

      log("$maxQuantity remove it from list");
    }
  }
}
