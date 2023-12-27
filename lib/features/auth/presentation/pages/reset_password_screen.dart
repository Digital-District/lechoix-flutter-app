import 'package:flutter/material.dart';

import '../../../../core/base/base_state.dart';
import '../../../../core/util/utils/navigation_util.dart';
import '../../../../core/util/utils/route_util.dart';
import '../../../../core/util/utils/validation_util.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../../core/widgets/button/elevated_button_widget.dart';
import '../../../../core/widgets/button/text_button_widget.dart';
import '../../../../core/widgets/space_widget.dart';
import '../../../../core/widgets/textField/input_field_widget.dart';
import '../../../../core/widgets/textField/text_field_widget.dart';
import '../../domain/entities/auth/AuthRequestModel.dart';
import '../cubit/update_password/reset_password_bloc.dart';

class ResetPasswordScreen extends StatefulWidget {
  final bool allowedToPush;

  final String phone;
  final int countryCodeId;
  final String code;

  const ResetPasswordScreen(this.phone, this.countryCodeId, this.code,
      {super.key, this.allowedToPush = true});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState
    extends BaseState<ResetPasswordScreen, ResetPasswordBloc> {
  final TextEditingController _passController = TextEditingController();

  String? _passError;

  bool _isEligibleToContinue = false;
  bool _obscureTextPass = true;

  @override
  void initBloc() {
    bloc = ResetPasswordBloc(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(centerWidget: Text(localize("Reset Password"))),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const VerticalSpace(24.0),
                  InputFieldWidget(
                      label: "Password*",
                      bottomWidget: TextFieldWidget(
                          controller: _passController,
                          errorText: _passError,
                          hint: "Password needs to be at least 6 characters.",
                          obscureText: _obscureTextPass,
                          suffixIcon: TextButtonWidget(
                            padding: EdgeInsets.zero,
                            child: Text(
                              _obscureTextPass
                                  ? localize("Show")
                                  : localize("Hide"),
                              style: const TextStyle(
                                  decoration: TextDecoration.underline),
                            ),
                            onClick: () {
                              setState(() {
                                _obscureTextPass = !_obscureTextPass;
                              });
                            },
                          ))),
                  const VerticalSpace(40),
                  ElevatedButtonWidget(
                    onClick: _send,
                    child: Text(localize("Send")),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _send() async {
    _isValid();
    if (_isEligibleToContinue) {
      var password = _passController.getText();

      AuthRequestModel requestModel = AuthRequestModel.resetPassword(
          widget.countryCodeId, widget.phone, password, widget.code);

      bloc.register(requestModel).then((value) {
        if (value) {
          pushReplacementAndClear(RouteUtil.hostRoute);
        }
      });
    }
  }

  void _isValid() {
    _isEligibleToContinue = true;
    _passError = null;

    if (!_passController.isValidPassword()) {
      _passError = localize("Enter a valid password");
      _isEligibleToContinue = false;
    }
    setState(() {});
  }
}
