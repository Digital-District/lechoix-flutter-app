import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constant/colors/colors.dart';
import '../../../../core/constant/styles/styles.dart';

class SelectionProductCard extends StatelessWidget {
  const SelectionProductCard(
      {super.key,
      required this.text,
      this.selected = false,
      required this.onTap});
  final String? text;
  final bool? selected;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 35.h,
        // width: 50.w,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
            // color: cardColor,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: selected! ? mainColor : lightGreyColor)),
        child: Center(
          child: Text(
            text!,
            style: TextStyles.textViewSemiBold12
                .copyWith(color: selected! ? mainColor : blackTextColor),
          ),
        ),
      ),
    );
  }
}
