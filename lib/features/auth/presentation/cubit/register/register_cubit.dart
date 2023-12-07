import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/error/failures.dart';
import '../../../domain/entities/register.dart';
import '../../../domain/usecase/register_usecase.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({
    required this.registerUseCase,
  }) : super(RegisterInitial());
  static RegisterCubit get(BuildContext context) => BlocProvider.of(context);

  RegisterUseCase registerUseCase;

  CompleteRegisterParams completeRegisterParams = CompleteRegisterParams();
  ////

  TextEditingController nameController = TextEditingController();
  TextEditingController secNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();
  bool agree = false;

  Future<void> fCompleteRegister({required BuildContext context}) async {
    emit(RegisterLoading());
    final response = await registerUseCase(CompleteRegisterParams(
        userName: nameController.text,
        userPhone: phoneController.text,
        userEmail: emailController.text,
        userPassword: passwordController.text,
        userConfirmPassword: passwordConfirmController.text));
    response.fold((fail) async {
      String? message = fail is ServerFailure ? fail.message : "Try again";
      if (fail is ServerFailure) {
        message = fail.message;
      }
      emit(RegisterError(message: message));
    }, (info) async {
      addressController.clear();
      nameController.clear();
      phoneController.clear();
      emailController.clear();
      passwordController.clear();
      passwordConfirmController.clear();
      agree = false;
      log(info.toString());
      emit(RegisterSuccess(registerinfo: info));
    });
  }

  ///choose Gender
  // String? gendreValue;

  // chooseGendre(state) {
  //   switch (state == true) {
  //     case true:
  //       gendreValue = 'male';
  //       emit(ChooseMaleType());
  //       break;
  //     case false:
  //       gendreValue = 'female';
  //       emit(ChooseFemaleType());
  //   }
}
