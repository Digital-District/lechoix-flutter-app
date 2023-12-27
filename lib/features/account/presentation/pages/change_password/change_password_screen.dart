import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../core/base/base_state.dart';
import '../../../../../core/util/utils/validation_util.dart';
import '../../../../../core/widgets/app_bar_widget.dart';
import '../../../../../core/widgets/button/elevated_button_widget.dart';
import '../../../../../core/widgets/button/text_button_widget.dart';
import '../../../../../core/widgets/space_widget.dart';
import '../../../../../core/widgets/textField/input_field_widget.dart';
import '../../../../../core/widgets/textField/text_field_widget.dart';
import '../../cubit/change_password_bloc.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState
    extends BaseState<ChangePasswordScreen, ChangePasswordBloc> {
  final TextEditingController _oldPassController = TextEditingController();
  final TextEditingController _newPassController = TextEditingController();

  bool _obscureTextPassOldPass = true;
  bool _obscureTextPassNewPass = true;

  @override
  void initBloc() {
    bloc = ChangePasswordBloc(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        centerWidget: Text(localize("Change Password")),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const VerticalSpace(32.0),
          InputFieldWidget(
              label: "Old Password*",
              bottomWidget: TextFieldWidget(
                  controller: _oldPassController,
                  obscureText: _obscureTextPassOldPass,
                  suffixIcon: TextButtonWidget(
                    padding: EdgeInsets.zero,
                    child: Text(
                      _obscureTextPassOldPass
                          ? localize("Show")
                          : localize("Hide"),
                      style:
                          const TextStyle(decoration: TextDecoration.underline),
                    ),
                    onClick: () {
                      setState(() {
                        _obscureTextPassOldPass = !_obscureTextPassOldPass;
                      });
                    },
                  ))),
          InputFieldWidget(
            label: "New Password*",
            bottomWidget: TextFieldWidget(
              controller: _newPassController,
              obscureText: _obscureTextPassNewPass,
              suffixIcon: TextButtonWidget(
                padding: EdgeInsets.zero,
                child: Text(
                  _obscureTextPassNewPass ? localize("Show") : localize("Hide"),
                  style: const TextStyle(decoration: TextDecoration.underline),
                ),
                onClick: () {
                  setState(() {
                    _obscureTextPassNewPass = !_obscureTextPassNewPass;
                  });
                },
              ),
            ),
          ),
          const VerticalSpace(80.0),
          ElevatedButtonWidget(
            onClick: _changePassword,
            child: Text(localize("CHANGE PASSWORD")),
          ),
        ],
      ),
    );
  }

  void _changePassword() async {
    if (_isValid()) {
      String oldPass = _oldPassController.text;
      String newPass = _newPassController.text;
      var res = await bloc.changePassword(oldPass, newPass);
      if (res) {
        pop();
      }
    }
  }

  bool _isValid() {
    if (!_oldPassController.isValidPassword()) {
      showErrorMsg(tr("Enter valid current password"));
      return false;
    }
    if (!_newPassController.isValidPassword()) {
      showErrorMsg(tr("Enter valid new password"));
      return false;
    }

    return true;
  }
}
