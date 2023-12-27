import '../../data/models/edit_profile_model.dart';
import '../repositories/account_repository.dart';
import '../../../auth/domain/usecase/login_usecase.dart';
import '../../../../core/usecases/usecases.dart';
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';

class EditProfile extends UseCase<EditProfileResponse, EditProfileParams> {
  final AccountRepository repository;
  EditProfile({required this.repository});
  @override
  Future<Either<Failure, EditProfileResponse>> call(EditProfileParams params) async {
    return await repository.editProfile(params: params);
  }
}

class EditProfileParams {
  String? userFirstName;
  // String? userSecName;
  String? userPassword;
  String? userPhone;
  String? userImage;
  String? userEmail;

  EditProfileParams(
      {this.userFirstName,
      this.userPassword,
      this.userPhone,
      this.userImage,
      // this.userSecName,
      this.userEmail});

  Map<String, dynamic> toMap() {
    return {
      'name': userFirstName,
      'email': userEmail,
      'phone': userPhone,
      'image': userImage,
      'password': userPassword,
      // 'country_id': userPhone,
    };
  }

  factory EditProfileParams.fromMap(Map<String, dynamic> map) {
    return EditProfileParams(
      userPhone: map['phone'],
      userPassword: map['password'],
      userFirstName: map['name'],
      userEmail: map['email'],
      userImage: map['image'],
    );
  }

  factory EditProfileParams.loginParams(LoginParams params) {
    return EditProfileParams(
      userPhone: params.userPhone,
      userPassword: params.userPassword,
    );
  }
}
