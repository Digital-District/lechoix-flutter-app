import 'package:flutter/material.dart';
import 'package:lechoix/base/base_state.dart';
import 'package:lechoix/cache/user_cache.dart';
import 'package:lechoix/core/util/utils/navigation_util.dart';
import 'package:lechoix/core/util/utils/route_util.dart';
import 'package:lechoix/features/splash/presentation/cubit/splash_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseState<SplashScreen, SplashBloc> {
  @override
  void initBloc() {
    bloc = SplashBloc(this);
    navigate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "assets/images/main_splash.png",
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          // Center(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Image.asset(
          //         "assets/images/logo_white_icon.png",
          //         width: MediaQuery.of(context).size.width / 2,
          //       ),
          //       VerticalSpace(10),
          //       Text(
          //         tr("Luxury Experience"),
          //         style: TextStyleConstants.titleRegular.copyWith(
          //           color: Theme.of(context).colorScheme.primary,
          //         ),
          //       ),
          //     ],
          //   ),
          // )
        ],
      ),
    );
  }

  void navigate() async {
    await bloc.getCountryCodes();
    await bloc.getConfigurations();

    Future.delayed(
      const Duration(milliseconds: 1000),
      () {
        if (UserCache.instance.takeOnboardingStatus()) {
          pushReplacementNamed(RouteUtil.hostRoute);
        } else {
          bloc.getOnBoardingScreens().then((response) {
            if (response != null && response.onBoarding != null) {
              UserCache.instance.onBoardingScreens.clear();
              UserCache.instance.onBoardingScreens.addAll(response.onBoarding ?? []);
              pushReplacementNamed(RouteUtil.onboardingRoute);
            }else {
              pushReplacementNamed(RouteUtil.hostRoute);
            }

          });
        }
      },
    );
  }
}
