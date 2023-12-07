import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lechoix/cache/user_cache.dart';
import 'package:lechoix/core/util/utils/consts/text_style_constants.dart';
import 'package:lechoix/core/util/utils/consts/ui_constants.dart';
import 'package:lechoix/ui/widget/button/elevated_button_widget.dart';
import 'package:lechoix/ui/widget/button/text_button_widget.dart';
import 'package:lechoix/ui/widget/image/cached_image_widget.dart';
import 'package:lechoix/ui/widget/onBoarding_widget.dart';
import 'package:lechoix/ui/widget/space_widget.dart';
import '../../../../data/response/OnBoardingResponse.dart';

class OnBoardingSelectLanguageWidget extends StatefulWidget {
  final Function() callBack;

  const OnBoardingSelectLanguageWidget({super.key, required this.callBack});

  @override
  State<StatefulWidget> createState() => _OnBoardingSelectLanguageWidgetState();
}

class _OnBoardingSelectLanguageWidgetState
    extends State<OnBoardingSelectLanguageWidget> {
  bool isArabic = false;
  OnBoardingModel screenContent = UserCache.instance.getOnBoardingScreen(0);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        OnBoardingWidget(
            topWidget: SizedBox(
              width: double.infinity,
              child: CachedImageWidget(
                imageUrl: screenContent.image ?? "",
                fit: BoxFit.cover,
              ),
            ),
            bottomWidget: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 50),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const VerticalSpace(10),
                    Text(
                      screenContent.getTitle(),
                      style: TextStyleConstants.titleBold.copyWith(
                        color: UIConstants.gray1Color,
                      ),
                    ),
                    Text(
                      screenContent.getSubTitle(),
                      style: TextStyleConstants.titleRegular.copyWith(
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
                    const VerticalSpace(14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButtonWidget(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: Text(
                            "English",
                            style: isArabic
                                ? null
                                : const TextStyle(
                                    decoration: TextDecoration.underline,
                                  ),
                          ),
                          onClick: () {
                            setState(() {
                              isArabic = false;
                              _setDefaultLanguage();
                            });
                          },
                        ),
                        Container(
                          width: 1,
                          height: 15,
                          color: UIConstants.gray5Color,
                        ),
                        TextButtonWidget(
                          padding: const EdgeInsets.symmetric(vertical: 2.0),
                          child: Text(
                            "عربي",
                            style: isArabic
                                ? const TextStyle(
                                    decoration: TextDecoration.underline,
                                  )
                                : null,
                          ),
                          onClick: () {
                            setState(() {
                              isArabic = true;
                              _setDefaultLanguage();
                            });
                          },
                        ),
                      ],
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
            )),
        Positioned(
          top: MediaQuery.of(context).size.height - 300 - 35,
          left: MediaQuery.of(context).size.width / 2 - 35,
          child: CachedImageWidget(
            imageUrl: screenContent.languageImage ?? "",
            width: 70,
            height: 70,
          ),
        )
      ],
    );
  }

  _setDefaultLanguage() {
    if (isArabic) {
      context.setLocale(const Locale('ar', 'EG'));
      UserCache.instance.setLanguage("ar");
    } else {
      context.setLocale(const Locale('en', 'US'));
      UserCache.instance.setLanguage("en");
    }
  }
}
