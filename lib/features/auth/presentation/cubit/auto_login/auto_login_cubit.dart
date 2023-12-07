import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/usecases/usecases.dart';
import '../../../domain/entities/login.dart';
import '../../../domain/usecase/auto_login.dart';
part 'auto_login_state.dart';

class AutoLoginCubit extends Cubit<AutoLoginState> {
  AutoLoginCubit({required this.autoLogin}) : super(AutoLoginInitial());
  final AutoLogin autoLogin;
  static AutoLoginCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> fAutoLogin() async {
    emit(AutoLoginLoading());
    final failOrUser = await autoLogin(NoParams());
    failOrUser.fold((fail) {
      emit(AutoLoginNoUser());
    }, (user) {
      log("autologs${user.data!.phone}");
      emit(AutoLoginHasUser(user: user));
    });
  }
 
  void emitLoading() {
    emit(AutoLoginLoading());
  }
  
  void emitHasUser({required LoginResponse user}) {
    debugPrint(user.toString());
    emit(AutoLoginHasUser(user: user));
  }


  void emitNoUser() {
    emit(AutoLoginNoUser());
  }
}
