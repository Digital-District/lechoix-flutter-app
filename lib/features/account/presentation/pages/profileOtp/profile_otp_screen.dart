// profile otp screen

import 'package:flutter/material.dart';
import 'package:lechoix/core/util/utils/consts/ui_constants.dart';
import 'package:lechoix/core/util/utils/route_util.dart';
import 'package:lechoix/core/widgets/app_bar_widget.dart';
import 'package:lechoix/core/widgets/button/elevated_button_widget.dart';
import 'package:lechoix/core/widgets/space_widget.dart';
import 'package:lechoix/core/widgets/stream/stream_widget.dart';
import 'package:lechoix/features/account/presentation/cubit/profile_otp_bloc.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../../../core/base/base_state.dart';
import '../../../../../../data/Enumeration.dart';

class ProfileOTPScreen extends StatefulWidget {
  final ProfileOTPMood mood;

  final String phone;
  final int countryCodeId;
  final String email;

  const ProfileOTPScreen({
    super.key,
    this.mood = ProfileOTPMood.Phone,
    required this.email,
    required this.phone,
    required this.countryCodeId,
  });

  @override
  State<ProfileOTPScreen> createState() => _ProfileOTPScreenState();
}

class _ProfileOTPScreenState
    extends BaseState<ProfileOTPScreen, ProfileOTPBloc> {
  bool canResend = false;

  @override
  void initBloc() {
    bloc = ProfileOTPBloc(this);
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

    var result = false;

    if (widget.mood == ProfileOTPMood.Email) {
      result = await bloc.requestChangeEmail(widget.email);
    } else if (widget.mood == ProfileOTPMood.Phone) {
      result =
          await bloc.requestChangePhone(widget.phone, widget.countryCodeId);
    }
    if (result) {
      setState(() {
        canResend = false;
        bloc.startTimer();
      });
    }
  }

  _verifyCode(String code) async {
    var result = false;
    if (widget.mood == ProfileOTPMood.Email) {
      result = await bloc.changeEmail(widget.email, code);
    } else if (widget.mood == ProfileOTPMood.Phone) {
      result = await bloc.changePhone(widget.phone, code, widget.countryCodeId);
    }

    if (result) {
      showSuccessMsg(localize("Profile Updated Successfully"));

      Navigator.popUntil(context, ModalRoute.withName(RouteUtil.hostRoute));
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
