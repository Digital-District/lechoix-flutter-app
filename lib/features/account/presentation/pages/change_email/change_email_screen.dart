import 'package:flutter/material.dart';
import '../../../../../core/base/base_state.dart';
import '../../../../../core/util/utils/validation_util.dart';
import '../../../../../core/widgets/app_bar_widget.dart';
import '../../../../../core/widgets/button/elevated_button_widget.dart';
import '../../../../../core/widgets/space_widget.dart';
import '../../../../../core/widgets/textField/input_field_widget.dart';
import '../../../../../core/widgets/textField/text_field_widget.dart';
import '../../../../../data/Enumeration.dart';
import '../../cubit/change_email_bloc.dart';
import '../profileOtp/profile_otp_screen.dart';

class ChangeEmailScreen extends StatefulWidget {
  const ChangeEmailScreen({super.key});

  @override
  State<ChangeEmailScreen> createState() => _ChangeEmailScreenState();
}

class _ChangeEmailScreenState
    extends BaseState<ChangeEmailScreen, ChangeEmailBloc> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void initBloc() {
    bloc = ChangeEmailBloc(this);
    _emailController.text = currentUser?.email ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarWidget(
          centerWidget: Text(localize("Change Email")),
        ),
        body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            const VerticalSpace(32.0),
            InputFieldWidget(
              label: "Email address*",
              bottomWidget: TextFieldWidget(
                controller: _emailController,
                hint: "e.g. mail@example.com",
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            const VerticalSpace(80.0),
            ElevatedButtonWidget(
              onClick: _requestChangeEmail,
              child: Text(localize("CHANGE EMAIL")),
            ),
          ],
        ));
  }

  void _requestChangeEmail() async {
    if (_isValid()) {
      String email = _emailController.text;
      var res = await bloc.requestChangeEmail(email);
      if (res) {
        navigateTo(
          ProfileOTPScreen(
            email: email,
            phone: "",
            countryCodeId: 0,
            mood: ProfileOTPMood.Email,
          ),
        );
      }
    }
  }

  bool _isValid() {
    if (!_emailController.isValidEmail()) {
      showErrorMsg(localize("Enter a valid email"));
      return false;
    }
    return true;
  }
}
