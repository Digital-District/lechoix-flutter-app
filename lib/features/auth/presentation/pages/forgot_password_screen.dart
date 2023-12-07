import 'package:flutter/material.dart';
import 'package:lechoix/base/base_state.dart';
import 'package:lechoix/core/util/utils/validation_util.dart';
import 'package:lechoix/features/auth/domain/entities/auth/AuthRequestModel.dart';
import 'package:lechoix/features/auth/presentation/cubit/forget_password/forgot_password_bloc.dart';
import 'package:lechoix/features/auth/presentation/pages/otp_verify_screen.dart';
// import 'package:lechoix/ui/screens/auth/otpVerify/otp_verify_screen.dart';
import 'package:lechoix/core/widgets/app_bar_widget.dart';
import 'package:lechoix/core/widgets/button/elevated_button_widget.dart';
import 'package:lechoix/core/widgets/space_widget.dart';
import 'package:lechoix/core/widgets/textField/input_field_widget.dart';
import 'package:lechoix/core/widgets/textField/phone_text_field_widget.dart';
import '../../../../data/Enumeration.dart';
// import 'forgot_password_bloc.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final bool allowedToPush;

  const ForgotPasswordScreen({super.key, this.allowedToPush = true});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState
    extends BaseState<ForgotPasswordScreen, ForgotPasswordBloc> {
  final TextEditingController _phoneController = TextEditingController();

  String? _phoneError;

  bool _isEligibleToContinue = false;

  int phoneCountryCodeId = 1;
  String phoneRegex = "";

  @override
  void initBloc() {
    bloc = ForgotPasswordBloc(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(centerWidget: Text(localize("Forgot Password"))),
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
                    label: "Phone number*",
                    bottomWidget: PhoneTextFieldWidget(
                      controller: _phoneController,
                      hint: "55123456",
                      errorText: _phoneError,
                      onCountyCodeSelected: (countryCodeModel) {
                        phoneRegex = countryCodeModel?.regex ?? "";
                        phoneCountryCodeId = countryCodeModel?.id ?? 0;
                      },
                    ),
                  ),
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
      var phone = _phoneController.getText();

      AuthRequestModel requestModel =
          AuthRequestModel.forgetPassword(phone, phoneCountryCodeId);
      bloc.forgetPassword(requestModel).then((value) {
        if (value) {
          navigateTo(OTPVerifyScreen(
            phone,
            phoneCountryCodeId,
            mood: OTPMood.ForgetPassword,
          ));
        }
      });
    }
  }

  void _isValid() {
    _isEligibleToContinue = true;
    _phoneError = null;

    if (!_phoneController.isValidPhone(phoneRegex)) {
      _phoneError = localize("Enter a valid phone number");
      _isEligibleToContinue = false;
    }

    setState(() {});
  }
}
