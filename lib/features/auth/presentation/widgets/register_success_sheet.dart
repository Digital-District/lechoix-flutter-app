// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../../../../core/constant/colors/colors.dart';
// import '../../../../core/constant/images.dart';
// import '../../../../core/constant/styles/styles.dart';
// import '../../../../core/util/new_navigator/navigator.dart';
// import '../../../../core/widgets/image_handler/svg_image.dart';
// import '../../../../core/widgets/main_button.dart';
// import '../../../cart/presentation/cubit/cart/cart_cubit.dart';
// import '../../../home/presentation/bloc/bottom bar/bottom_bar_cubit.dart';
// import '../../../home/presentation/pages/bottom_bar.dart';
// import '../../../splash/presentation/pages/splash_screen.dart';

// class RegisterSuccessSheet extends StatelessWidget {
//   const RegisterSuccessSheet({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//         height: getHeight(context) * .7,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             customSvg(
//               name: greenDoneCheck,
//             ),
//             Text(tr("register_done"),
//                 style: TextStyles.textViewSemiBold18
//                     .copyWith(color: blackTextColor)),
//             SizedBox(
//               height: 30.h,
//             ),
//             MainButton(
//                 text: tr("ok"),
//                 buttonWidth: getWidth(context) * .7,
//                 buttonColor: mainColor,
//                 onPressed: () {
//                   Navigation.popAllAndPush(context, screen: HomeLayoutScreen());
//                   if (context.read<CartCubit>().cartData != null) {
//                     if (context.read<CartCubit>().cartData!.data!.isNotEmpty) {
//                       context
//                           .read<BottomNavBarCubit>()
//                           .changeBottom(3, context);
//                     }
//                   } else {
//                     context.read<BottomNavBarCubit>().changeBottom(2, context);
//                   }
//                 })
//           ],
//         ));
//   }
// }
