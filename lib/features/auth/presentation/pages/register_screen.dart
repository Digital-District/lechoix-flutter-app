import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../core/base/base_state.dart';
import '../../../../core/util/utils/consts/text_style_constants.dart';
import '../../../../core/util/utils/consts/ui_constants.dart';
import '../../../../core/util/utils/validation_util.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../../core/widgets/button/elevated_button_widget.dart';
import '../../../../core/widgets/button/outlined_button_widget.dart';
import '../../../../core/widgets/button/text_button_widget.dart';
import '../../../../core/widgets/space_widget.dart';
import '../../../../core/widgets/textField/input_field_widget.dart';
import '../../../../core/widgets/textField/phone_text_field_widget.dart';
import '../../../../core/widgets/textField/text_field_widget.dart';
import '../../domain/entities/auth/AuthRequestModel.dart';
import '../cubit/register/register_bloc.dart';
import 'login_screen.dart';
import 'otp_verify_screen.dart';

class RegisterScreen extends StatefulWidget {
  final bool allowedToPush;

  const RegisterScreen({super.key, this.allowedToPush = true});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends BaseState<RegisterScreen, RegisterBloc> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  String? _firstNamError;
  String? _lastNameError;
  String? _emailError;
  String? _passError;
  String? _phoneError;

  bool _obscureTextPass = true;
  bool _isEligibleToContinue = false;
  bool _receiveAnnouncements = false;

  int phoneCountryCodeId = 1;
  String phoneRegex = "";

  @override
  void initBloc() {
    bloc = RegisterBloc(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(centerWidget: Text(localize("Create An Account"))),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const VerticalSpace(16.0),
              InputFieldWidget(
                label: "First Name*",
                bottomWidget: TextFieldWidget(
                  controller: _firstNameController,
                  hint: "Enter your first name",
                  errorText: _firstNamError,
                ),
              ),
              InputFieldWidget(
                label: "Last Name*",
                bottomWidget: TextFieldWidget(
                  controller: _lastNameController,
                  hint: "Enter your last name",
                  errorText: _lastNameError,
                ),
              ),
              InputFieldWidget(
                label: "Email address*",
                bottomWidget: TextFieldWidget(
                  controller: _emailController,
                  hint: "e.g. mail@example.com",
                  errorText: _emailError,
                  keyboardType: TextInputType.emailAddress,
                ),
              ),
              InputFieldWidget(
                label: "Password*",
                bottomWidget: TextFieldWidget(
                  controller: _passController,
                  hint: "Password needs to be at least 6 characters.",
                  errorText: _passError,
                  obscureText: _obscureTextPass,
                  suffixIcon: TextButtonWidget(
                    padding: EdgeInsets.zero,
                    child: Text(
                      _obscureTextPass ? localize("Show") : localize("Hide"),
                      style:
                          const TextStyle(decoration: TextDecoration.underline),
                    ),
                    onClick: () {
                      setState(() {
                        _obscureTextPass = !_obscureTextPass;
                      });
                    },
                  ),
                ),
              ),
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
              const VerticalSpace(24),
              Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    activeColor: UIConstants.blackColor,
                    value: _receiveAnnouncements,
                    onChanged: (bool? value) {
                      setState(() {
                        _receiveAnnouncements = value ?? false;
                      });
                    },
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        localize(
                            "Yes, I want to receive announcements, recommendations, and updates about lechoix"),
                        style: TextStyleConstants.captionRegular.copyWith(
                          color: UIConstants.gray1Color,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const VerticalSpace(24),
              ElevatedButtonWidget(
                onClick: _register,
                child: Text(localize("Create an account")),
              ),
              const VerticalSpace(14),
              Text.rich(
                TextSpan(
                  style: TextStyleConstants.captionRegular.copyWith(
                    color: UIConstants.gray2Color,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text:
                          "${localize("By registering your details, you agree with our")} ",
                    ),
                    TextSpan(
                      text: "${localize("Terms & Conditions")},",
                      style:
                          const TextStyle(decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // navigateTo(
                          //     const DynamicHTMLScreen(
                          //       "Terms & Conditions",
                          //       "terms-and-conditions",
                          //     ),
                          //     fullscreenDialog: true);
                        },
                    ),
                    TextSpan(text: " ${localize("and")} "),
                    TextSpan(
                      text: localize("Privacy and Cookie Policy."),
                      style:
                          const TextStyle(decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // navigateTo(
                          //     const DynamicHTMLScreen(
                          //         "Privacy Policy", "privacy-policy"),
                          //     fullscreenDialog: true);
                        },
                    ),
                  ],
                ),
              ),
              const VerticalSpace(40),
              const Divider(),
              const VerticalSpace(40),
              Center(
                child: Text(
                  localize("Already have an account?"),
                  style: TextStyleConstants.headline7.copyWith(
                    color: UIConstants.gray1Color,
                  ),
                ),
              ),
              const VerticalSpace(20),
              OutlinedButtonWidget(
                borderColor: UIConstants.blackColor,
                onClick: () {
                  if (widget.allowedToPush) {
                    navigateTo(const LoginScreen(
                      allowedToPush: false,
                    ));
                  } else {
                    pop();
                  }
                },
                child: Text(localize("SIGN IN")),
              ),
              const VerticalSpace(24),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _register() async {
    _isValid();
    if (_isEligibleToContinue) {
      var firstName = _firstNameController.getText();
      var lastName = _lastNameController.getText();
      var email = _emailController.getText();
      var password = _passController.getText();
      var phone = _phoneController.getText();

      AuthRequestModel requestModel = AuthRequestModel.register(
          firstName,
          lastName,
          email,
          phoneCountryCodeId,
          phone,
          password,
          _receiveAnnouncements);

      bloc.register(requestModel).then((value) {
        if (value) {
          navigateTo(OTPVerifyScreen(phone, phoneCountryCodeId));
        } else {
          mangeApiError();
        }
      });
    }
  }

  void _isValid() {
    _isEligibleToContinue = true;
    _emailError = null;
    _lastNameError = null;
    _firstNamError = null;
    _phoneError = null;
    _passError = null;

    if (!_emailController.isValidEmail()) {
      _emailError = localize("Enter a valid email");
      _isEligibleToContinue = false;
    }
    if (!_firstNameController.isValidName()) {
      _firstNamError = localize("First name should be in 4 to 10 chars");
      _isEligibleToContinue = false;
    }
    if (!_lastNameController.isValidName()) {
      _lastNameError = localize("Last name should be in 4 to 10 chars");
      _isEligibleToContinue = false;
    }
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

  void mangeApiError() {
    _firstNamError = bloc.getValidationError("first_name");
    _lastNameError = bloc.getValidationError("last_name");
    _emailError = bloc.getValidationError("email");
    _phoneError = bloc.getValidationError("phone");
    _passError = bloc.getValidationError("password");
    setState(() {});
  }
}
