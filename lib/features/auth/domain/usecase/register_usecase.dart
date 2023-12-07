import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/register.dart';
import '../repositories/auth_repositoriy.dart';

class RegisterUseCase
    extends UseCase<RegisterResponse, CompleteRegisterParams> {
  final AuthRepository repository;

  RegisterUseCase({required this.repository});

  @override
  Future<Either<Failure, RegisterResponse>> call(
      CompleteRegisterParams params) async {
    return await repository.register(params: params);
  }
}

class CompleteRegisterParams {
  String? userName;
  // String? userSecName;
  String? userPassword;
  String? userConfirmPassword;
  String? userPhone;
  String? userEmail;

  CompleteRegisterParams(
      {this.userName,
      this.userPassword,
      this.userConfirmPassword,
      this.userPhone,
      this.userEmail});

  Map<String, dynamic> toMap() {
    return {
      'phone': userPhone,
      'password': userPassword,
      'name': userName,
      'confirm_password': userConfirmPassword,
      'email': userEmail,
    };
  }
}
