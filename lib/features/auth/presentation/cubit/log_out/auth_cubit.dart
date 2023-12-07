import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lechoix/core/usecases/usecases.dart';
import 'package:lechoix/core/util/new_navigator/navigator.dart';
import 'package:lechoix/core/widgets/toast.dart';

import '../../../../../core/error/failures.dart';
import '../../../domain/usecase/log_out.dart';
import '../../pages/login_screen.dart';

part 'auth_state.dart';

class LogOutCubit extends Cubit<LogOutState> {
  LogOutCubit({required this.logout}) : super(LogOutInitial());

  //useCase
  final LogoutUseCase logout;

  Future<void> fLogout(context) async {
    emit(LogoutLoading());
    final failOrUser = await logout(NoParams());
    failOrUser.fold((fail) {
      String message = 'please try again later';
      if (fail is ServerFailure) {
        message = fail.message;
        showToast(message);
        emit(LogoutError(message: message));
      }
    }, (logout) {
      showToast(logout);
      Navigation.popAllAndPush(context, screen: LoginScreen());
      emit(LogoutSuccess(message: logout));
    });
  }
}
