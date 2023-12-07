import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failures.dart';
import '../../../domain/usecase/forget_password_usecase.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit({required this.forgetPassword})
      : super(ForgetPasswordInitial());

  ForgetPasswordUseCase forgetPassword;

  ForgetPassowrdParams setNewPassParams = ForgetPassowrdParams();

  Future<void> fForgetPassword(
      {required String newPass,
      required String phone,
      required String code}) async {
    emit(ForgetPasswordLoadingState());
    final ForgetPassowrdParams params = ForgetPassowrdParams(
      newPassword: newPass,
      verificationCode: code,
      phone: phone,
    );
    final response = await forgetPassword(params);
    response.fold((fail) async {
      if (fail is ServerFailure) {
        String message = fail.message;
        emit(ForgetPasswordErrorState(message: message));
      }
    }, (info) {
      emit(ForgetPasswordSuccessState());
    });
  }
}
