
import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/forget_password_response.dart';
import '../repositories/auth_repositoriy.dart';

class ForgetPasswordUseCase
    extends UseCase<ForgetPasswordResponse, ForgetPassowrdParams> {
  final AuthRepository repository;

  ForgetPasswordUseCase({required this.repository});

  @override
  Future<Either<Failure, ForgetPasswordResponse>> call(
      ForgetPassowrdParams params) async {
    return await repository.forgetPassword(params: params);
  }
}

class ForgetPassowrdParams {
  String? phone;

  String? verificationCode;
  String? newPassword;

  ForgetPassowrdParams({this.phone, this.newPassword, this.verificationCode});
}
