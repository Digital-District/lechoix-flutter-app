import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/auth_repositoriy.dart';

class LogoutUseCase extends UseCase<String, NoParams> {
  final AuthRepository repository;
  LogoutUseCase({required this.repository});
  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return await repository.logout();
  }
}



