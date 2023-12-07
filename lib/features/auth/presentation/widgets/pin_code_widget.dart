// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';

// import '../../../../core/constant/colors/colors.dart';
// import '../../../../core/util/validator.dart';

// class PinCodeWidget extends StatelessWidget {
//   const PinCodeWidget({
//     Key? key,
//     required this.verFicationCode,
//   }) : super(key: key);

//   final TextEditingController verFicationCode;

//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.ltr,
//       child: PinCodeTextField(
//           cursorColor: white,
//           length: 6,
//           appContext: context,
//           animationType: AnimationType.fade,
//           keyboardType: TextInputType.number,
//           backgroundColor: Colors.transparent,
//           inputFormatters: [FilteringTextInputFormatter.digitsOnly],
//           pinTheme: PinTheme(
//             shape: PinCodeFieldShape.box,
//             borderRadius: BorderRadius.circular(20),
//             fieldHeight: 70.h,
//             fieldWidth: 60.w,
//             activeColor: white,
//             disabledColor: white,
//             borderWidth: 1,
//             selectedColor: white,
//             inactiveColor: white,
//           ),
//           textStyle: const TextStyle(
//             color: white,
//             fontWeight: FontWeight.bold,
//           ),
//           controller: verFicationCode,
//           onChanged: (String value) {},
//           onCompleted: (value) {},
//           validator: (val) => Validator.defaultValidator(val)),
//     );
//   }
// }
