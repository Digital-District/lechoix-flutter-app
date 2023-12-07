import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failures.dart';
import '../../../domain/entities/login.dart';
import '../../../domain/usecase/login_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.login) : super(LoginInitial());
  static LoginCubit get(BuildContext context) => BlocProvider.of(context);

  final LoginUseCase login;
  bool isSkip = true;
  //params
  LoginParams loginParams = LoginParams();
  int? userId;
  LoginResponse? _user;

  LoginResponse get user {
    userId = _user?.data!.id ?? 1;
    return _user!;
  }

  void updateSkip() => isSkip = true;

  set updateUser(LoginResponse newUser) {
    isSkip = false;
    _user = newUser;
    emit(LoginSuccessState(user: user));
    emit(LoginInitial());
  }

  set updateUserFromEdit(User newUser) {
    _user!.data = newUser;
    emit(LoginInitial());
    emit(LoginSuccessState(user: user));
  }

  Future<void> userLogin(
    GlobalKey<FormState> formKey,
  ) async {
    if (!formKey.currentState!.validate()) {
      return;
    } else {
      emit(LoginLoadingState());
      final failOrUser = await login(loginParams);
      failOrUser.fold((fail) {
        if (fail is ServerFailure) {
          emit(LoginErrorState(
              //  tr("your_phone_or_pass_is_not_true_please_try_again")
              message: fail.message));
        }
      }, (user) {
        isSkip = false;
        _user = user;
        loginParams = LoginParams();
        emit(LoginSuccessState(user: user));
      });
    }
  }
}
