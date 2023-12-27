import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../../core/base/base_state.dart';
import '../../../../../../data/Enumeration.dart';
import '../../../../../core/util/utils/validation_util.dart';
import '../../../../../core/widgets/app_bar_widget.dart';
import '../../../../../core/widgets/button/elevated_button_widget.dart';
import '../../../../../core/widgets/space_widget.dart';
import '../../../../../core/widgets/textField/input_field_widget.dart';
import '../../../../../core/widgets/textField/phone_text_field_widget.dart';
import '../../cubit/change_phone_bloc.dart';
import '../profileOtp/profile_otp_screen.dart';

class ChangePhoneScreen extends StatefulWidget {
  const ChangePhoneScreen({super.key});

  @override
  State<ChangePhoneScreen> createState() => _ChangePhoneScreenState();
}

class _ChangePhoneScreenState
    extends BaseState<ChangePhoneScreen, ChangePhoneBloc> {
  final TextEditingController _phoneController = TextEditingController();
  int phoneCountryCodeId = 1;
  String phoneRegex = "";

  @override
  void initBloc() {
    bloc = ChangePhoneBloc(this);
    _phoneController.text = currentUser?.phone ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        centerWidget: Text(localize("Change Phone")),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const VerticalSpace(32.0),
          InputFieldWidget(
            label: "Phone number*",
            bottomWidget: PhoneTextFieldWidget(
              controller: _phoneController,
              hint: "55123456",
              onCountyCodeSelected: (countryCodeModel) {
                phoneRegex = countryCodeModel?.regex ?? "";
                phoneCountryCodeId = countryCodeModel?.id ?? 0;
              },
            ),
          ),
          const VerticalSpace(80.0),
          ElevatedButtonWidget(
            onClick: _requestChangeEmail,
            child: Text(localize("CHANGE PHONE")),
          ),
        ],
      ),
    );
  }

  void _requestChangeEmail() async {
    if (_isValid()) {
      String phone = _phoneController.text;
      var res = await bloc.requestChangePhone(phone, phoneCountryCodeId);
      if (res) {
        navigateTo(
          ProfileOTPScreen(
            email: "",
            phone: phone,
            countryCodeId: phoneCountryCodeId,
            mood: ProfileOTPMood.Phone,
          ),
        );
      }
    }
  }

  bool _isValid() {
    if (!_phoneController.isValidPhone(phoneRegex)) {
      showErrorMsg(tr("Enter a valid phone number"));
      return false;
    }
    return true;
  }
}
