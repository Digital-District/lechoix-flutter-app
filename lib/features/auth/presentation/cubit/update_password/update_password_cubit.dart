import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failures.dart';
import '../../../domain/usecase/update_password.dart';

part 'update_password_state.dart';

class UpdatePasswordCubit extends Cubit<UpdatePasswordState> {
  UpdatePasswordCubit({required this.updatePassword})
      : super(UpdatePasswordInitial());

  UpdatePasswordUseCase updatePassword;

  fUpdatePassword({required int userId, required String userPassword}) async {
    emit(UpdatePasswordLoadingState());

    final response = await updatePassword(
        UpdatePasswordParams(userId: userId, userPassword: userPassword));
    response.fold((fail) async {
      if (fail is ServerFailure) {
        String message = fail.message;
        log(fail.message);
        emit(UpdatePasswordErrorState(message: message));
        // emit(CheckOtpInitial());
      }
    }, (info) {
      emit(UpdatePasswordSuccessState());
    });
  }
}
