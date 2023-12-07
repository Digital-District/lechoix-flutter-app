import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failures.dart';
import '../../../domain/usecase/check_otp.dart';

part 'check_otp_state.dart';

class CheckOtpCubit extends Cubit<CheckOtpState> {
  CheckOtpCubit({required this.checkOtp}) : super(CheckOtpInitial());
  CheckOtpUseCase checkOtp;
  String? code;

  fcheckOtp({
    required int userId,
  }) async {
    emit(CheckOtpLoading());
    final CheckOtpParams params = CheckOtpParams(userID: userId);
    final response = await checkOtp(params);
    response.fold((fail) async {
      if (fail is ServerFailure) {
        String message = fail.message;
        log(fail.message);
        emit(CheckOtpError(message: message));
        emit(CheckOtpInitial());
      }
    }, (info) {
      code = info.result.userOtp;
      emit(CheckOtpSuccess(userId: info.result.userId));
    });
  }
}
