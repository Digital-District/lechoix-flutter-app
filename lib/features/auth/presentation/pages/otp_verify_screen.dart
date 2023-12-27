import 'package:flutter/material.dart';
import 'package:lechoix/core/constant/colors/colors.dart';
import 'package:lechoix/core/util/utils/consts/ui_constants.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../../core/base/base_state.dart';
import '../../../../core/util/utils/navigation_util.dart';
import '../../../../core/util/utils/route_util.dart';
import '../../../../core/widgets/app_bar_widget.dart';
import '../../../../core/widgets/button/elevated_button_widget.dart';
import '../../../../core/widgets/space_widget.dart';
import '../../../../core/widgets/stream/stream_widget.dart';
import '../../../../data/Enumeration.dart';
import '../../domain/entities/auth/AuthRequestModel.dart';
import '../cubit/check_otp/otp_verify_bloc.dart';
import 'reset_password_screen.dart';

class OTPVerifyScreen extends StatefulWidget {
  final OTPMood mood;

  final String phone;
  final int countryCodeId;

  const OTPVerifyScreen(this.phone, this.countryCodeId,
      {super.key, this.mood = OTPMood.Auth});

  @override
  State<OTPVerifyScreen> createState() => _OTPVerifyScreenState();
}

class _OTPVerifyScreenState extends BaseState<OTPVerifyScreen, OTPVerifyBloc> {
  bool canResend = false;

  @override
  void initBloc() {
    bloc = OTPVerifyBloc(this);
    bloc.startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(centerWidget: Text(localize("Verify OTP"))),
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
                  Text(localize(
                      "A text message has been sent to your phone containing the activation code.")),
                  const VerticalSpace(40.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Theme(
                      data: ThemeData(primaryColor: Colors.cyan),
                      child: PinFieldAutoFill(
                        codeLength: 5,
                        autoFocus: true,
                        decoration: BoxLooseDecoration(
                            textStyle: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                            bgColorBuilder: FixedColorBuilder(
                                Theme.of(context).colorScheme.primary),
                            strokeColorBuilder: FixedColorBuilder(
                                UIConstants.blackColor.withOpacity(0.3))),
                        onCodeSubmitted: (code) {},
                        onCodeChanged: (code) {
                          if (code!.length == 5) {
                            _verifyCode(code);
                          }
                        },
                      ),
                    ),
                  ),
                  const VerticalSpace(40.0),
                  getTimerData(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  getTimerData() => StreamWidget<int>(
        stream: bloc.timerController.stream,
        onRetry: () {},
        child: (timer) => Column(
          children: [
            updateCanResendStatus(timer),
            Text(
              "${localize("Didn't receive the code?")} ${timeFormatter(timer)}",
              textAlign: TextAlign.center,
              style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
            ),
            const VerticalSpace(40),
            canResend
                ? ElevatedButtonWidget(
                    width: MediaQuery.of(context).size.width / 2,
                    onClick: _resend,
                    child: Text(localize("Resend")),
                  )
                : Container(),
          ],
        ),
      );

  Widget updateCanResendStatus(int timer) {
    if (timer == 0) {
      canResend = true;
    } else {
      canResend = false;
    }
    return const SizedBox(
      height: 1,
    );
  }

  _resend() async {
    _listenForCode();
    AuthRequestModel requestModel = AuthRequestModel.forgetPassword(
      widget.phone,
      widget.countryCodeId,
    );
    if (widget.mood == OTPMood.Auth) {
      bloc.resendCode(requestModel).then((value) {
        if (value) {
          setState(() {
            canResend = false;
            bloc.startTimer();
          });
        }
      });
    } else if (widget.mood == OTPMood.ForgetPassword) {
      bloc.forgetPassword(requestModel).then((value) {
        if (value) {
          setState(() {
            canResend = false;
            bloc.startTimer();
          });
        }
      });
    }
  }

  _verifyCode(String code) async {
    AuthRequestModel requestModel = AuthRequestModel.verifyPhone(
      widget.phone,
      widget.countryCodeId,
      code,
    );

    if (widget.mood == OTPMood.Auth) {
      bloc.verifyPhone(requestModel).then((value) {
        if (value) {
          pushReplacementAndClear(RouteUtil.hostRoute);
        }
      });
    } else if (widget.mood == OTPMood.ForgetPassword) {
      bloc.passwordCheckCode(requestModel).then((value) {
        if (value) {
          navigateTo(
              ResetPasswordScreen(widget.phone, widget.countryCodeId, code));
        }
      });
    }
  }

  String timeFormatter(int timerCount) {
    int time = timerCount;
    Duration duration = Duration(seconds: time);
    return [duration.inMinutes, duration.inSeconds]
        .map((seg) => seg.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }

  _listenForCode() async {
    SmsAutoFill().listenForCode;
  }
}
