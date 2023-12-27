import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/account_repository.dart';

class ContactUs extends UseCase<String, ContactUsParams> {
  final AccountRepository repository;
  ContactUs({required this.repository});
  @override
  Future<Either<Failure, String>> call(ContactUsParams params) async {
    return await repository.contactUs(params: params);
  }
}

class ContactUsParams {
  String? name;
  String? phone;
  String? message;

  ContactUsParams(
      {
      this.phone,
      this.name,
      this.message});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phone': phone,
      'message': message,
      // 'country_id': userPhone,
    };
  }
}
