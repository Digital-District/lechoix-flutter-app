// import 'package:flutter/cupertino.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../../../../core/constant/colors/colors.dart';
// import '../../../../core/constant/dimenssions/screenutil.dart';
// import '../../../../core/constant/icons.dart';
// import '../../../../core/constant/styles/styles.dart';
// import '../../../../core/widgets/image_handler/svg_image.dart';
// import '../../../../core/widgets/space.dart';

// class NotificationsCard extends StatelessWidget {
//   const NotificationsCard(
//       {super.key,
//       this.title = "حسابك الشخصي",
//       this.description =
//           "إذا كنت تحتاج إلى عدد أكبر من الفقراتهذا النص هو مثال لنص يمكن أن يستبدل في نفس المساحة، لقد تم توليد هذا النص من مولد النص العربى، حيث يمكنك أن تولد مثل هذا النص أو العديد من النصوص الأخرى إضافة إلى زيادة عدد الحروف التى يولدها التطبيقإذا كنت تحتاج إلى عدد أكبر من الفقرات", required this.time});

//   final String title;
//   final String description;
//   final String time;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsetsDirectional.symmetric(vertical: 15),
//       decoration: BoxDecoration(
//           border: Border(
//               bottom: BorderSide(
//                   color: greyLightColor.withOpacity(.5), width: .5))),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           customSvg(name: notifyIcon, height: 60.h),
//           const Space(boxWidth: 5),
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(
//                 width: screenWidth - 120.w,
//                 child: RichText(
//                     maxLines: 3,
//                     overflow: TextOverflow.ellipsis,
//                     softWrap: true,
//                     text: TextSpan(
//                         text: title,
//                         style: TextStyles.textViewSemiBold12
//                             .copyWith(color: blackTextColor),
//                         children: [
//                           TextSpan(
//                               text: " $description",
//                               style: TextStyles.textViewRegular10.copyWith(
//                                 color: blackTextColor,
//                               )),
//                         ])),
//               ),
//               Text(
//                 time,
//                 style: TextStyles.textViewSemiBold12.copyWith(color: mainColor),
//               )
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
