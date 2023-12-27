import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/update_password.dart';
import '../repositories/auth_repositoriy.dart';

class UpdatePasswordUseCase
    extends UseCase<UpdatePasswordResponse, UpdatePasswordParams> {
  final AuthRepository repository;
  UpdatePasswordUseCase({required this.repository});
  @override
  Future<Either<Failure, UpdatePasswordResponse>> call(
      UpdatePasswordParams params) async {
    return await repository.updatePassword(params: params);
  }
}

class UpdatePasswordParams {
  final int userId;
  final String userPassword;

  UpdatePasswordParams({required this.userId, required this.userPassword});
}
