import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/util/api_basehelper.dart';
import '../../domain/usecases/contact_us.dart';
import '../../domain/usecases/edit_profile.dart';
import '../models/edit_profile_model.dart';
import '../models/notifications_model.dart';
import '../models/static_page.dart';

const notificationsApi = "notifications";
const editProfileApi = "edit-profile";
const getStaticPageApi = "page/";
const contactUsApi = "contact";

abstract class AccountRemoteDataSource {
  Future<NotificationsResponse> getNotifications();
  Future<StaticPageResponse> getStaticPage({required int page});
  Future<EditProfileResponse> editProfile({required EditProfileParams params});
  Future<String> contactUs({required ContactUsParams params});
}

class AccountRemoteDataSourceImpl implements AccountRemoteDataSource {
  final ApiBaseHelper helper;

  AccountRemoteDataSourceImpl({
    required this.helper,
  });

  @override
  Future<NotificationsResponse> getNotifications() async {
    try {
      final response = await helper.get(
        url: notificationsApi,
      );
      // return unit;
      if (response["success"] == true) {
        return NotificationsResponse.fromJson(response);
      } else {
        throw ServerException(message: response['message']);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<EditProfileResponse> editProfile(
      {required EditProfileParams params}) async {
    Map<String, dynamic> bodyNoImage = {
      'name': params.userFirstName,
      'email': params.userEmail,
      'phone': params.userPhone,
      'password': params.userPassword,
    };
    Map<String, dynamic> body = {
      'name': params.userFirstName,
      'email': params.userEmail,
      'phone': params.userPhone,
      'password': params.userPassword,
      'image': await MultipartFile.fromFile(
        params.userImage!,
      )
    };
    try {
      final upload = params.userImage!.contains("https");
      final response = await helper.post(
          url: editProfileApi, body: !upload ? bodyNoImage : body);
      if (response["status"] == true) {
        return EditProfileResponse.fromJson(response);
      } else {
        throw ServerException(message: response['message']);
      }
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<StaticPageResponse> getStaticPage({required int page}) async {
    try {
      final response = await helper.get(
        url: "$getStaticPageApi$page",
      );
      return StaticPageResponse.fromJson(response);
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<String> contactUs({required ContactUsParams params}) async {
    try {
      final response =
          await helper.post(url: contactUsApi, body: params.toMap());
      log(response.toString());
      return response["message"];
    } on ServerException catch (e) {
      throw ServerException(message: e.message);
    }
  }
}
