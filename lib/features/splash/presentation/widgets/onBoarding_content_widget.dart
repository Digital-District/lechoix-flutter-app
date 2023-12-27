import 'package:flutter/cupertino.dart';

import '../../../../core/cache/user_cache.dart';
import '../../../../core/util/utils/consts/text_style_constants.dart';
import '../../../../core/util/utils/consts/ui_constants.dart';
import '../../../../core/widgets/button/elevated_button_widget.dart';
import '../../../../core/widgets/image/cached_image_widget.dart';
import '../../../../core/widgets/onBoarding_widget.dart';
import '../../../../core/widgets/space_widget.dart';
import '../../../../data/response/OnBoardingResponse.dart';

class OnBoardingContentWidget extends StatefulWidget {
  final Function() callBack;

  const OnBoardingContentWidget({super.key, required this.callBack});

  @override
  State<StatefulWidget> createState() => _OnBoardingContentWidgetState();
}

class _OnBoardingContentWidgetState extends State<OnBoardingContentWidget> {
  bool isArabic = false;
  OnBoardingModel screenContent = UserCache.instance.getOnBoardingScreen(1);

  @override
  Widget build(BuildContext context) {
    return OnBoardingWidget(
        topWidget: Stack(children: [
          CachedImageWidget(
            imageUrl: screenContent.image ?? "",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Center(
            child: Image.asset(
              "assets/images/logo_white_icon.png",
              width: MediaQuery.of(context).size.width / 1.5,
            ),
          )
        ]),
        bottomWidget: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  screenContent.getTitle(),
                  style: TextStyleConstants.titleRegular.copyWith(
                    color: UIConstants.gray1Color,
                  ),
                ),
                Text(
                  screenContent.getSubTitle(),
                  style: TextStyleConstants.titleBold.copyWith(
                    color: UIConstants.gray1Color,
                  ),
                ),
                const VerticalSpace(20),
                Text(
                  screenContent.getContent(),
                  textAlign: TextAlign.center,
                  style: TextStyleConstants.titleRegular.copyWith(
                    color: UIConstants.gray2Color,
                  ),
                ),
                const VerticalSpace(30),
                ElevatedButtonWidget(
                  width: MediaQuery.of(context).size.width / 2 + 50,
                  onClick: widget.callBack,
                  child: Text(screenContent.getActionContent()),
                ),
              ],
            ),
          ),
        ));
  }
}
