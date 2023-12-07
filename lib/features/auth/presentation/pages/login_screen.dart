import 'package:flutter/material.dart';
import 'package:lechoix/base/base_state.dart';
import 'package:lechoix/cache/user_cache.dart';
import 'package:lechoix/core/util/utils/consts/text_style_constants.dart';
import 'package:lechoix/core/util/utils/consts/ui_constants.dart';
import 'package:lechoix/core/util/utils/navigation_util.dart';
import 'package:lechoix/core/util/utils/route_util.dart';
import 'package:lechoix/core/util/utils/validation_util.dart';
import 'package:lechoix/features/auth/domain/entities/auth/AuthRequestModel.dart';
import 'package:lechoix/features/auth/presentation/cubit/login/login_bloc.dart';
import 'package:lechoix/features/auth/presentation/pages/forgot_password_screen.dart';
import 'package:lechoix/features/auth/presentation/pages/otp_verify_screen.dart';
import 'package:lechoix/features/auth/presentation/pages/register_screen.dart';
import 'package:lechoix/ui/widget/app_bar_widget.dart';
import 'package:lechoix/ui/widget/button/elevated_button_widget.dart';
import 'package:lechoix/ui/widget/button/outlined_button_widget.dart';
import 'package:lechoix/ui/widget/button/text_button_widget.dart';
import 'package:lechoix/ui/widget/space_widget.dart';
import 'package:lechoix/ui/widget/textField/input_field_widget.dart';
import 'package:lechoix/ui/widget/textField/phone_text_field_widget.dart';
import 'package:lechoix/ui/widget/textField/text_field_widget.dart';


class LoginScreen extends StatefulWidget {
  final bool allowedToPush;
  final bool cameFromCart;

  const LoginScreen(
      {super.key, this.allowedToPush = true, this.cameFromCart = false});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseState<LoginScreen, LoginBloc> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  String? _passError;
  String? _phoneError;

  bool _isEligibleToContinue = false;
  bool _obscureTextPass = true;
  int phoneCountryCodeId = 1;
  String phoneRegex = "";

  @override
  void initBloc() {
    bloc = LoginBloc(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(centerWidget: Text(localize("Sign In"))),
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
                  InputFieldWidget(
                      label: "Password*",
                      bottomWidget: TextFieldWidget(
                          controller: _passController,
                          errorText: _passError,
                          obscureText: _obscureTextPass,
                          suffixIcon: TextButtonWidget(
                            padding: EdgeInsets.zero,
                            child: Text(
                              _obscureTextPass ? localize("Show") : localize("Hide"),
                              style: const TextStyle(
                                  decoration: TextDecoration.underline),
                            ),
                            onClick: () {
                              setState(() {
                                _obscureTextPass = !_obscureTextPass;
                              });
                            },
                          ))),
                  ElevatedButtonWidget(
                    onClick: _login,
                    child: Text(localize("SIGN IN")),
                  ),
                  const VerticalSpace(30),
                  TextButtonWidget(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: Text(
                      localize("Forgotten your password?"),
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.normal,
                        letterSpacing: 1.0,
                      ),
                    ),
                    onClick: () {
                      navigateTo(const ForgotPasswordScreen());
                    },
                  ),
                  const VerticalSpace(40),
                ],
              ),
            ),
            const Divider(height: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const VerticalSpace(40),
                  Center(
                    child: Text(
                      localize("Don’t have an account?"),
                      style: TextStyleConstants.headline7.copyWith(
                        color: UIConstants.gray1Color,
                      ),
                    ),
                  ),
                  const VerticalSpace(20),
                  OutlinedButtonWidget(
                    borderColor: Colors.black,
                    onClick: () {
                      if (widget.allowedToPush) {
                        navigateTo(const RegisterScreen(
                          allowedToPush: false,
                        ));
                      } else {
                        pop();
                      }
                    },
                    child: Text(localize("CREATE A NEW ACCOUNT")),
                  ),
                  const VerticalSpace(24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _login() async {
    _isValid();
    if (_isEligibleToContinue) {
      var password = _passController.getText();
      var phone = _phoneController.getText();

      AuthRequestModel requestModel = AuthRequestModel.login(
        phone,
        phoneCountryCodeId,
        password,
      );

      bloc.login(requestModel).then((response) {
        if (response != null) {
          if (response.isPhoneVerified ?? false) {
            UserCache.instance.setUser(response);
            if (widget.cameFromCart) {
              pop();
            } else {
              pushReplacementAndClear(RouteUtil.hostRoute);
            }
          } else {
            navigateTo(OTPVerifyScreen(phone, phoneCountryCodeId));
          }
        }
      });
    }
  }

  void _isValid() {
    _isEligibleToContinue = true;
    _phoneError = null;
    _passError = null;

    if (!_phoneController.isValidPhone(phoneRegex)) {
      _phoneError = localize("Enter a valid phone number");
      _isEligibleToContinue = false;
    }
    if (!_passController.isValidPassword()) {
      _passError = localize("Enter a valid password");
      _isEligibleToContinue = false;
    }
    setState(() {});
  }
}
