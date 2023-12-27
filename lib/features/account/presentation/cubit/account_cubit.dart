import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/local/auth_local_datasource.dart';
import '../../../../core/widgets/toast.dart';
import '../../../../injection_container/injection_container.dart' as di;
import '../../../auth/domain/entities/login.dart';
import '../../../auth/domain/usecase/login_usecase.dart';
import '../../data/models/static_page.dart';
import '../../domain/usecases/contact_us.dart';
import '../../domain/usecases/edit_profile.dart';
import '../../domain/usecases/get_static_pages.dart';

part 'account_state.dart';

class AccountCubit extends Cubit<AccountState> {
  AccountCubit(this.editProfile, this.getStaticPage, this.contactUs)
      : super(AccountInitial());
  EditProfile editProfile;
  GetStaticPage getStaticPage;
  ContactUs contactUs;
  String? imagePath;
  String? name;
  String? email;
  String? phone;
  String? pass;

  TextEditingController fiNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();
  late LoginParams loginParams;
  late User user;

  Future getUserData() async {
    log("get user data");
    emit(AccountLoading());
    di.sl.get<AuthLocalDataSource>();
    final userShared = di.sharedPreferences.getString(userCacheConst);
    final loginInfo = di.sharedPreferences.getString(loginInfoConst);
    log(loginInfo.toString());
    loginParams = LoginParams.fromMap(json.decode(loginInfo!));
    user = User.fromJson(jsonDecode(userShared!));
    imagePath = "${user.image}";
    log(imagePath!);
    name = "${user.name}";
    email = user.email;
    phone = user.phone;
    pass = loginParams.userPassword;
    fiNameController = TextEditingController(text: name);
    emailController = TextEditingController(text: email);
    phoneController = TextEditingController(text: phone);
    passController = TextEditingController(text: pass);
    emit(AccountLoaded());
  }

  au() {
    emit(AccountLoaded());
  }

  Future<void> fEditProfile() async {
    emit(EditAccountLoading());
    log(imagePath!);
    final failOrUser = await editProfile(EditProfileParams(
        userImage: imagePath,
        userPassword: passController.text,
        userEmail: emailController.text,
        userFirstName: fiNameController.text,
        userPhone: loginParams.userPhone));
    log(imagePath!);

    failOrUser.fold((fail) {
      if (fail is ServerFailure) {
        showToast(fail.message);
      }
    }, (user) {
      showToast(user.message);
      log(imagePath!);
      emit(AccountLoaded());
    });
  }

  Future<void> fGetStaticPage(id) async {
    emit(StaticPageLoading());

    final failOrUser = await getStaticPage(StaticPageParam(page: id));
    failOrUser.fold((fail) {
      if (fail is ServerFailure) {
        showToast(fail.message);
        emit(StaticPageError());
      }
    }, (page) {
      emit(StaticPageLoaded(response: page));
    });
  }

  Future<void> fContactUs({required String phone, name, message}) async {
    emit(ContactUsLoading());
    final failOrUser = await contactUs(ContactUsParams(
      message: message,
      phone: phone,
      name: name,
    ));
    failOrUser.fold((fail) {
      if (fail is ServerFailure) {
        showToast(fail.message);
        emit(ContactUsSuccess());
      }
    }, (res) {
      showToast(res);

      emit(ContactUsSuccess());
    });
  }
}
