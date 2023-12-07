import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../entities/check_otp.dart';
import '../repositories/auth_repositoriy.dart';

class CheckOtpUseCase extends UseCase<CheckOtpResponse, CheckOtpParams> {
  final AuthRepository repository;
  CheckOtpUseCase({required this.repository});
  @override
  Future<Either<Failure, CheckOtpResponse>> call(CheckOtpParams params) async {
    return await repository.checkOtp(params: params);
  }
}

class CheckOtpParams {
  int? userID;

  CheckOtpParams({
    this.userID,
  });
}
