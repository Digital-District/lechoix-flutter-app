import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../util/utils/consts/text_style_constants.dart';
import '../util/utils/consts/ui_constants.dart';
import 'space_widget.dart';

class ShowLessMoreWidget extends StatefulWidget {
  final String fullText;
  const ShowLessMoreWidget({super.key, required this.fullText});
  @override
  _ShowLessMoreWidgetState createState() => _ShowLessMoreWidgetState();
}

class _ShowLessMoreWidgetState extends State<ShowLessMoreWidget> {
  bool showLess = true;
  int charLength = 120;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: widget.fullText.length < charLength
          ? Text(widget.fullText)
          : Column(
              children: <Widget>[
                Text(
                  showLess
                      ? ("${widget.fullText.substring(0, charLength)}...")
                      : widget.fullText.substring(0, charLength) +
                          widget.fullText
                              .substring(charLength, widget.fullText.length),
                  textAlign: TextAlign.center,
                  style: TextStyleConstants.bodyRegular
                      .copyWith(color: UIConstants.gray2Color, height: 1.6),
                ),
                const VerticalSpace(10),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        showLess ? tr("show more") : tr("show less"),
                        style: TextStyleConstants.bodyRegular.copyWith(
                            color: UIConstants.goldColor,
                            decoration: TextDecoration.underline),
                      ),
                    ],
                  ),
                  onTap: () {
                    setState(() {
                      showLess = !showLess;
                    });
                  },
                ),
              ],
            ),
    );
  }

  String fullText =
      "A modern-day Italian goddess as imagined by Domenico Dolce and Stefano Gabbana, calls for form-loving silhouettes, flamboyant prints andA modern-day Italian goddess as imagined by Domenico Dolce and Stefano Gabbana, calls for form-loving silhouettes, flamboyant prints and";
}
