import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:lechoix/core/util/utils/consts/ui_constants.dart';
import 'package:lechoix/core/util/utils/navigation_util.dart';
import 'package:lechoix/core/util/utils/route_util.dart';
import 'package:lechoix/core/util/utils/validation_util.dart';
import 'package:lechoix/core/widgets/app_bar_widget.dart';
import 'package:lechoix/core/widgets/button/elevated_button_widget.dart';
import 'package:lechoix/core/widgets/button/outlined_button_widget.dart';
import 'package:lechoix/core/widgets/dialog/dialog_widget.dart';
import 'package:lechoix/core/widgets/space_widget.dart';
import 'package:lechoix/core/widgets/textField/input_field_widget.dart';
import 'package:lechoix/core/widgets/textField/phone_text_field_widget.dart';
import 'package:lechoix/core/widgets/textField/text_field_widget.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:lechoix/features/account/presentation/cubit/edit_profile_bloc.dart';
import 'package:lechoix/features/account/presentation/pages/change_email/change_email_screen.dart';
import 'package:lechoix/features/account/presentation/pages/change_password/change_password_screen.dart';
import 'package:lechoix/features/account/presentation/pages/change_phone/change_phone_screen.dart';

import '../../../../core/base/base_state.dart';
import '../../../../core/cache/user_cache.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState
    extends BaseState<EditProfileScreen, EditProfileBloc> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  // XFile? _selectedImage;

  @override
  void initBloc() {
    bloc = EditProfileBloc(this);
    setUi();
  }

  void setUi() {
    _firstNameController.text = currentUser?.firstName ?? "";
    _lastNameController.text = currentUser?.lastName ?? "";
    _emailController.text = currentUser?.email ?? "";
    _phoneController.text = currentUser?.phone ?? "";
    _passController.text = "000000000";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        centerWidget: Text(localize("Edit Profile")),
      ),
      body: ListView(
        padding: const EdgeInsets.all(18.0),
        children: [
          // Center(
          //   child: SizedBox(
          //     width: 80.0,
          //     height: 80.0,
          //     child: Stack(
          //       children: [
          //         Container(
          //           width: 80.0,
          //           height: 80.0,
          //           decoration: BoxDecoration(
          //             shape: BoxShape.circle,
          //             border: Border.all(width: 2.0, color: UIConstants.blackColor),
          //           ),
          //           child: ClipOval(
          //             child: _selectedImage != null
          //                 ? Image.file(
          //                     File(_selectedImage?.path ?? ""),
          //                     fit: BoxFit.cover,
          //                   )
          //                 : CachedImageWidget(
          //                     imageUrl: currentUser?.avatar ?? "",
          //                     placeholder: "assets/images/profile_icon.png",
          //                     fit: BoxFit.cover,
          //                     maxHeightDiskCache: 80,
          //                     maxWidthDiskCache: 80,
          //                   ),
          //           ),
          //         ),
          //         Align(
          //           alignment: AlignmentDirectional.bottomEnd,
          //           child: GestureDetector(
          //             onTap: _pickImage,
          //             child: Container(
          //               width: 35,
          //               height: 35,
          //               decoration: BoxDecoration(
          //                 color: Colors.white,
          //                 shape: BoxShape.circle,
          //                 border: Border.all(width: 1.0, color: UIConstants.blackColor),
          //               ),
          //               child: Center(
          //                 child: Image.asset(
          //                   "assets/images/ic_camera.png",
          //                   width: 16,
          //                   height: 16,
          //                 ),
          //               ),
          //             ),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
          const VerticalSpace(40.0),
          Row(
            children: [
              Expanded(
                child: InputFieldWidget(
                  label: "First Name*",
                  bottomWidget: TextFieldWidget(
                    controller: _firstNameController,
                    hint: "Enter your first name",
                  ),
                ),
              ),
              const HorizontalSpace(20.0),
              Expanded(
                child: InputFieldWidget(
                  label: "Last Name*",
                  bottomWidget: TextFieldWidget(
                    controller: _lastNameController,
                    hint: "Enter your lasr name",
                  ),
                ),
              ),
            ],
          ),
          InputFieldWidget(
            label: "Email address*",
            bottomWidget: TextFieldWidget(
              controller: _emailController,
              hint: "e.g. mail@example.com",
              keyboardType: TextInputType.emailAddress,
              readOnly: true,
              suffixIcon: const Icon(
                Icons.mode_edit,
                color: UIConstants.gray1Color,
              ),
              onClick: () {
                navigateTo(const ChangeEmailScreen());
              },
            ),
          ),
          InputFieldWidget(
            label: "Phone number*",
            bottomWidget: PhoneTextFieldWidget(
              controller: _phoneController,
              hint: "55123456",
              readOnly: true,
              suffixIcon: const Icon(
                Icons.mode_edit,
                color: UIConstants.gray1Color,
              ),
              onClick: () {
                navigateTo(const ChangePhoneScreen());
              },
              onCountyCodeSelected: (countryCodeModel) {},
            ),
          ),
          InputFieldWidget(
            label: "Password*",
            bottomWidget: TextFieldWidget(
              controller: _passController,
              hint: "Password needs to be at least 6 characters.",
              obscureText: true,
              readOnly: true,
              suffixIcon: const Icon(
                Icons.mode_edit,
                color: UIConstants.gray1Color,
              ),
              onClick: () {
                navigateTo(const ChangePasswordScreen());
              },
            ),
          ),
          const VerticalSpace(50.0),
          ElevatedButtonWidget(
            onClick: _save,
            child: Text(localize("SAVE")),
          ),
          const VerticalSpace(30.0),
          OutlinedButtonWidget(
            onClick: _showDeleteAccountDialog,
            child: Text(localize("Delete Account")),
          ),
        ],
      ),
    );
  }

  void _save() async {
    if (_isValid()) {
      var firstName = _firstNameController.getText();
      var lastName = _lastNameController.getText();
      var res = await bloc.editProfile(firstName, lastName);
      if (res) pop(res: res);
    }
  }

  bool _isValid() {
    if (!_firstNameController.isValidName()) {
      showErrorMsg(tr("First name should be in 4 to 10 chars"));
      return false;
    }
    if (!_lastNameController.isValidName()) {
      showErrorMsg(tr("Last name should be in 4 to 10 chars"));
      return false;
    }

    return true;
  }

  // void _pickImage() async {
  //   XFile? image = await ImagePicker()
  //       .pickImage(source: ImageSource.gallery, imageQuality: 25);
  //   if (image != null) {
  //     var result = await bloc.changeAvatar(image);
  //     if (result) {
  //       _selectedImage = image;
  //       showSuccessMsg(tr("Profile Updated Successfully"));
  //       setState(() {});
  //     }
  //   }
  // }

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => DialogWidget(
        title: localize("Do you want to delete your account?"),
        cancelMsg: localize("Cancel"),
        confirmMsg: localize("Delete"),
        onCancel: () => Navigator.pop(context),
        onConfirm: () {
          Navigator.pop(context);
          deleteAccountApi();
        },
      ),
    );
  }

  Future<void> deleteAccountApi() async {
    var res = await bloc.deleteAccount();
    if (res) {
      kickUserOut();
    }
  }

  void kickUserOut() {
    UserCache.instance.logout();
    NavigationUtil.pushReplacementAndClear(
        NavigationUtil.navigatorKey.currentContext!, RouteUtil.splashRoute);
  }

// var res = await navigateTo(const ChangeEmailScreen());
// if (res == true) setUi();
}
