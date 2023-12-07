import 'package:flutter/cupertino.dart';

class OnBoardingWidget extends StatelessWidget {
  final Widget topWidget;
  final Widget bottomWidget;

  const OnBoardingWidget(
      {Key? key, required this.topWidget, required this.bottomWidget})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: topWidget),
        Container(
          height: 300,
          child:bottomWidget ,
        )
        //
      ],
    );
  }
}
