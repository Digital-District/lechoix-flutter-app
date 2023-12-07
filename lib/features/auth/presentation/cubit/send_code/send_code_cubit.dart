import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failures.dart';
import '../../../domain/usecase/send_code_usecase.dart';

part 'send_code_state.dart';

class SendCodeCubit extends Cubit<SendCodeState> {
  SendCodeCubit({required this.sendCodeUseCase})
      : super(ForgetPasswordInitial());

  final SendCodeUseCase sendCodeUseCase;
  final SendCodeParams params = SendCodeParams();
  TextEditingController codeController = TextEditingController();
  String _code = "";
  String get code => _code;

  Future<void> fGetCode({
    required String phone,
    required bool resend,
  }) async {
    emit(ForgetPasswordLoading());
    final SendCodeParams params = SendCodeParams(
      phone: phone,
    );
    final response = await sendCodeUseCase(params);
    response.fold((fail) async {
      if (fail is ServerFailure) {
        String message = fail.message;
        emit(ForgetPasswordError(message: message));
      }
    }, (info) {
      _code = info.userOtp;

      emit(ForgetPasswordHasCode(code: info.userOtp.toString()));
    });
  }
}
