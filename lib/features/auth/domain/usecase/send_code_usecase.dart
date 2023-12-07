import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/send_code.dart';
import '../repositories/auth_repositoriy.dart';

class SendCodeUseCase
    extends UseCase<SendCodeForForgetPasswordResponse, SendCodeParams> {
  final AuthRepository repository;

  SendCodeUseCase({required this.repository});

  @override
  Future<Either<Failure, SendCodeForForgetPasswordResponse>> call(
      SendCodeParams params) async {
    return await repository.sendCode(params: params);
  }
}

class SendCodeParams {
  String? phone;

  SendCodeParams({
    this.phone,
  });
}
