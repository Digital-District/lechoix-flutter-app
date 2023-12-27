import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/login.dart';
import '../repositories/auth_repositoriy.dart';

class AutoLogin extends UseCase<LoginResponse, NoParams> {
  final AuthRepository repository;
  AutoLogin({required this.repository});
  @override
  Future<Either<Failure, LoginResponse>> call(NoParams params) async {
    return await repository.autoLogin();
  }
}
