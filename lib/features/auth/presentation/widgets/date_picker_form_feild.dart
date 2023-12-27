// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
//
// import '../../../../core/constant/colors/colors.dart';
// import '../../../../core/widgets/textfornfeild.dart';
//
// class DatePickerFormFeild2 extends StatelessWidget {
//  final  TextEditingController controller ;
//  final IconData icon;
//    DatePickerFormFeild2({Key? key, required this.controller, required this.icon}) : super(key: key);
//  DateTime? pickedDate;
//   @override
//   Widget build(BuildContext context) {
//     return  MainFormFeild(
//       controller:controller ,
//       suffix: Icon(icon,color: mainColor,),
//       // suffixIcon: const Icon(
//       //   Icons.date_range_sharp,
//       //   color: white,
//       // ),
//       onTap: () async {
//         pickedDate = await showDatePicker(
//           context: context,
//           // initialEntryMode: DatePickerEntryMode.calendarOnly,
//           // initialDatePickerMode: DatePickerMode.year,
//           firstDate: DateTime(1900),
//           initialDate: DateTime.now(),
//           locale: const Locale("ar"),
//           lastDate: DateTime(2025),
//
//           builder: (context, child) => Theme(
//               data: ThemeData(
//                 colorScheme: const ColorScheme.light(
//                   primary: mainColor,
//                   onPrimary: white,
//                   onSurface: UIConstants.blackColor,
//                 ),
//               ),
//               child: child ?? const SizedBox()),
//         );
//         if (pickedDate != null) {
//           fromdate = DateFormat("yyyy-MM-dd").format(pickedDate!);
//         }
//         setState(() {});
//       },
//       hintText: fromdate == ''
//           ? tr(
//         "delivery_date",
//       )
//           : fromdate.toString(),
//     );
//   }
// }
