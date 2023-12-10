import 'package:flutter/material.dart';
import 'package:lechoix/base/base_state.dart';
import 'package:lechoix/base/dummy_bloc.dart';
import 'package:lechoix/cache/user_cache.dart';
import 'package:lechoix/core/util/utils/navigation_util.dart';
import 'package:lechoix/core/util/utils/route_util.dart';
import 'package:lechoix/features/splash/presentation/widgets/onBoarding_content_widget.dart';
import 'package:lechoix/features/splash/presentation/widgets/onBoarding_notifications_widget.dart';
import 'package:lechoix/features/splash/presentation/widgets/onBoarding_select_language_widget.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<StatefulWidget> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends BaseState<OnboardingScreen, DummyBloc> {
  int currentPage = 0;
  final PageController controller = PageController();

  @override
  void initBloc() {
    bloc = DummyBloc(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: controller,
        physics: const NeverScrollableScrollPhysics(),
        children: <Widget>[
      OnBoardingSelectLanguageWidget(
        callBack: navigateToTheNext,
      ),
      OnBoardingContentWidget(
        callBack: navigateToTheNext,
      ),
      OnBoardingNotificationsWidget(
        callBack: navigateToTheNext,
      ),

        ],
      ),
    );
  }

  void navigateToTheNext() {
    print(controller.page);
    if (controller.page == 2) {
      pushReplacementNamed(RouteUtil.login);
      UserCache.instance.setOnboardingStatus(true);
    } else {
      controller.nextPage(
          duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
    }
  }
}
