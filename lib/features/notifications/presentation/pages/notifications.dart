// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// import '../../../../core/constant/colors/colors.dart';
// import '../../../../core/constant/dimenssions/measures.dart';
// import '../../../../core/constant/styles/styles.dart';
// import '../cubit/notifications_cubit.dart';
// import '../widgets/notifications_card.dart';

// class NotificationsScreen extends StatefulWidget {
//   const NotificationsScreen({
//     super.key,
//   });

//   @override
//   State<NotificationsScreen> createState() => _NotificationsScreenState();
// }

// class _NotificationsScreenState extends State<NotificationsScreen> {
//   @override
//   void initState() {
//     context.read<NotificationsCubit>().fGetNotifications();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final cubit = context.watch<NotificationsCubit>();
//     return Scaffold(
//         appBar: AppBarGeneric(
//           title: tr("notifications"),
//         ),
//         body: CustomRefresh(
//           // key: refreshke,
//           onRefresh: () async {
//             await Future.delayed(const Duration(milliseconds: 100));
//             cubit.fGetNotifications();
//           },
//           child: BlocConsumer<NotificationsCubit, NotificationsState>(
//             listener: (context, state) {},
//             builder: (context, state) {
//               if (state is NotificationsLoading) {
//                 return const Loading();
//               } else if (state is NotificationsEmpty) {
//                 return Center(
//                   child: Text(tr("no_found", args: [tr("notifications")]),
//                       style: TextStyles.textViewSemiBold14
//                           .copyWith(color: blackColor)),
//                 );
//               } else {
//                 return ListView.builder(
//                     physics: const NeverScrollableScrollPhysics(),
//                     padding: const EdgeInsets.symmetric(horizontal: padding25w),
//                     itemCount: cubit.notification.length,
//                     itemBuilder: (context, index) => NotificationsCard(
//                           description: cubit.notification[index].desc!,
//                           title: cubit.notification[index].name!,
//                           time: cubit.notification[index].createdAt!,
//                         ));
//               }
//             },
//           ),
//         ));
//   }
// }
