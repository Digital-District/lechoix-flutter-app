import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lechoix/core/usecases/usecases.dart';
import 'package:lechoix/core/util/new_navigator/navigator.dart';
import 'package:lechoix/core/widgets/toast.dart';
import 'package:lechoix/features/auth/domain/usecase/delete_account.dart';
import '../../../../../core/error/failures.dart';
import '../../pages/login_screen.dart';
part 'delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  DeleteAccountCubit({required this.logout}) : super(DeleteAccountInitial());

  //useCase
  final DeleteAccountUseCase logout;

  Future<void> fDeleteAccount(context) async {
    emit(DeleteAccountLoading());
    final failOrUser = await logout(NoParams());
    failOrUser.fold((fail) {
      String message = 'please try again later';
      if (fail is ServerFailure) {
        message = fail.message;
        showToast(message);
        emit(DeleteAccountError(message: message));
      }
    }, (logout) {
      showToast(logout);
      Navigation.popAllAndPush(context, screen: LoginScreen());
      emit(DeleteAccountSuccess(message: logout));
    });
  }
}
