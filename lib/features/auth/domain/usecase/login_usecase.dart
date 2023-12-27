import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/login.dart';
import '../repositories/auth_repositoriy.dart';
import 'register_usecase.dart';

class LoginUseCase extends UseCase<LoginResponse, LoginParams> {
  final AuthRepository repository;

  LoginUseCase({required this.repository});

  @override
  Future<Either<Failure, LoginResponse>> call(LoginParams params) async {
    return await repository.login(params: params);
  }
}

class LoginParams {
  //String ?userToken;
  String? userPassword;
  String? userPhone;

  LoginParams({this.userPassword, this.userPhone});

  Map<String, dynamic> toMap() {
    return {
      'phone': userPhone,
      'password': userPassword,
    };
  }

  factory LoginParams.fromMap(Map<String, dynamic> map) {
    return LoginParams(
      userPhone: map['phone'],
      userPassword: map['password'],
    );
  }

  factory LoginParams.fromRegisterParams(CompleteRegisterParams params) {
    return LoginParams(
      userPhone: params.userPhone,
      userPassword: params.userPassword,
    );
  }
}

