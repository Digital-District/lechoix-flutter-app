import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/check_otp.dart';
import '../entities/forget_password_response.dart';
import '../entities/login.dart';
import '../entities/register.dart';
import '../entities/send_code.dart';
import '../entities/update_password.dart';
import '../usecase/check_otp.dart';
import '../usecase/forget_password_usecase.dart';
import '../usecase/login_usecase.dart';
import '../usecase/register_usecase.dart';
import '../usecase/send_code_usecase.dart';
import '../usecase/update_password.dart';

abstract class AuthRepository {
  Future<Either<Failure, RegisterResponse>> register(
      {required CompleteRegisterParams params});
  Future<Either<Failure, LoginResponse>> login({required LoginParams params});
  Future<Either<Failure, LoginResponse>> autoLogin();
  Future<Either<Failure, CheckOtpResponse>> checkOtp(
      {required CheckOtpParams params});
  Future<Either<Failure, UpdatePasswordResponse>> updatePassword(
      {required UpdatePasswordParams params});
  Future<Either<Failure, SendCodeForForgetPasswordResponse>> sendCode(
      {required SendCodeParams params});
  Future<Either<Failure, ForgetPasswordResponse>> forgetPassword(
      {required ForgetPassowrdParams params});
  Future<Either<Failure, String>> logout();
  Future<Either<Failure, String>> deleteAccount();
}
