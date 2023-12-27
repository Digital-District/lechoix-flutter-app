import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/auth_repositoriy.dart';

class DeleteAccountUseCase extends UseCase<String, NoParams> {
  final AuthRepository repository;
  DeleteAccountUseCase({required this.repository});
  @override
  Future<Either<Failure, String>> call(NoParams params) async {
    return await repository.deleteAccount();
  }
}



