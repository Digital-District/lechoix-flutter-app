// import 'package:flutter/material.dart';
// import 'package:lechoix/base/base_state.dart';
// import 'package:lechoix/data/cart/CartModel.dart';
// import 'package:lechoix/core/util/utils/consts/ui_constants.dart';

// class CartItemWidget extends StatefulWidget {
//   final CartModel cartModel;
//   final Function()? onClick;
//   final Function()? onDelete;
//   final Function(bool)? onUpdate;

//   final bool isMyCart;

//   const CartItemWidget({
//     Key? key,
//     required this.cartModel,
//     this.onClick,
//     this.onDelete,
//     this.onUpdate,
//     this.isMyCart = true,
//   }) : super(key: key);

//   @override
//   _CartWidgetState createState() => _CartWidgetState();
// }

// class _CartWidgetState extends BaseState<CartItemWidget, CartBloc> {
//   final ValueNotifier<bool> _loadingNotifier = ValueNotifier<bool>(false);
//   late ProductBloc productBloc;

//   @override
//   void initBloc() {
//     productBloc = ProductBloc(this);
//     bloc = CartBloc(this);
//   }

//   @override
//   void dispose() {
//     productBloc.onDispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       behavior: HitTestBehavior.translucent,
//       onTap: widget.onClick,
//       child: Column(
//         children: [
//           VerticalSpace(16),
//           Padding(
//             padding: EdgeInsets.all(16),
//             child: Container(
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   CachedImageWidget(
//                     imageUrl: widget.cartModel.image ?? "",
//                     fit: BoxFit.cover,
//                     width: MediaQuery.of(context).size.width / 4,
//                   ),
//                   HorizontalSpace(16),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           widget.cartModel.brand?.name ?? "",
//                           style: TextStyleConstants.captionBold.copyWith(
//                             color: UIConstants.gray1Color,
//                           ),
//                         ),
//                         VerticalSpace(8),
//                         Text(
//                           widget.cartModel.name ?? "",
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: TextStyleConstants.bodyRegular.copyWith(
//                             color: UIConstants.gray1Color,
//                           ),
//                         ),
//                         VerticalSpace(8),
//                         Visibility(
//                           visible: (widget.cartModel.salePrice == "" || widget.cartModel.salePrice =='null'),
//                           child: Text(
//                             "${widget.cartModel.price} ${widget.cartModel.currency}",
//                             style: TextStyleConstants.price.copyWith(
//                               color: UIConstants.goldColor,
//                             ),
//                           ),
//                         ),
//                         Visibility(
//                           visible: (widget.cartModel.salePrice != "" && widget.cartModel.salePrice != "null" ),
//                           child: Row(
//                             children: [
//                               Text(
//                                 "${widget.cartModel.price ?? ""} ${widget.cartModel.currency}",
//                                 style: TextStyleConstants.price.copyWith(
//                                   color: UIConstants.gray2Color,
//                                   decoration: TextDecoration.lineThrough,
//                                 ),
//                               ),
//                               HorizontalSpace(8),
//                               Text(
//                                 "${widget.cartModel.salePrice ?? ""} ${widget.cartModel.currency}",
//                                 style: TextStyleConstants.price.copyWith(
//                                   color: UIConstants.redColor,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         VerticalSpace(8),
//                         Visibility(
//                           visible: widget.cartModel.color != null,
//                           child: Column(
//                             children: [
//                               Row(
//                                 children: [
//                                   Text(
//                                     "${localize("Color")}: ",
//                                     style:
//                                         TextStyleConstants.bodyRegular.copyWith(
//                                       color: UIConstants.gray3Color,
//                                     ),
//                                   ),
//                                   Text(
//                                     widget.cartModel.color ?? "",
//                                     style: TextStyleConstants.bodyBold.copyWith(
//                                       color: UIConstants.gray3Color,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               VerticalSpace(8),
//                             ],
//                           ),
//                         ),
//                         Visibility(
//                           visible: widget.cartModel.size != null,
//                           child: Column(
//                             children: [
//                               Row(
//                                 children: [
//                                   Text(
//                                     "${localize("Size")}: ",
//                                     style:
//                                         TextStyleConstants.bodyRegular.copyWith(
//                                       color: UIConstants.gray3Color,
//                                     ),
//                                   ),
//                                   Text(
//                                     widget.cartModel.size ?? "",
//                                     style: TextStyleConstants.bodyBold.copyWith(
//                                       color: UIConstants.gray3Color,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               VerticalSpace(8),
//                             ],
//                           ),
//                         ),
//                         Column(
//                           children: [
//                             Row(
//                               children: [
//                                 Text(
//                                   "${localize("Qty")}: ",
//                                   style:
//                                       TextStyleConstants.bodyRegular.copyWith(
//                                     color: UIConstants.gray3Color,
//                                   ),
//                                 ),
//                                 Visibility(
//                                     visible: widget.isMyCart,
//                                     child: getActions(context)),
//                                 Visibility(
//                                   visible: !widget.isMyCart,
//                                   child: Text(
//                                     "${widget.cartModel.quantity}",
//                                     style: TextStyleConstants.price.copyWith(
//                                       color: UIConstants.gray3Color,
//                                     ),
//                                   ),
//                                 )
//                               ],
//                             ),
//                             VerticalSpace(8),
//                           ],
//                         ),
//                         Visibility(
//                           visible: widget.isMyCart,
//                           child: Row(
//                             children: [
//                               TextButtonWidget(
//                                 padding: EdgeInsets.zero,
//                                 child: LabelWithIconWidget(
//                                   label: localize("Remove"),
//                                   icon: Image.asset(
//                                     "assets/images/cart_remove_icon.png",
//                                     width: 16,
//                                     height: 16,
//                                   ),
//                                   textPadding:
//                                       EdgeInsets.symmetric(vertical: 0),
//                                 ),
//                                 onClick: () => onDeleteClick(),
//                               ),
//                               HorizontalSpace(8),
//                               Expanded(
//                                 child: TextButtonWidget(
//                                   padding: EdgeInsets.zero,
//                                   child: LabelWithIconWidget(
//                                     label: localize(
//                                         widget.cartModel.getFavoriteText),
//                                     icon: ValueListenableBuilder<bool>(
//                                       valueListenable: _loadingNotifier,
//                                       builder: (context, value, child) {
//                                         return value
//                                             ? SizedBox(
//                                                 width: 16,
//                                                 height: 16,
//                                                 child:
//                                                     CircularProgressIndicator(
//                                                   strokeWidth: 2,
//                                                 ),
//                                               )
//                                             : Image.asset(
//                                                 widget
//                                                     .cartModel.getFavoriteIcon,
//                                                 width: 16,
//                                                 height: 16);
//                                       },
//                                     ),
//                                     textPadding:
//                                         EdgeInsets.symmetric(vertical: 0),
//                                   ),
//                                   onClick: () => onFavouriteClick(),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ),
//           VerticalSpace(8),
//           Container(
//             padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
//             color: UIConstants.gray7Color,
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Text(
//                         "${localize("Sending one item from")} ${widget.cartModel.brand?.country}, ${localize("delivered within")} ${widget.cartModel.brand?.deliveryDurationDays} ${localize("days")}",
//                         style: TextStyleConstants.captionMedium.copyWith(
//                           color: UIConstants.gray2Color,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Divider(
//             height: 1,
//           )
//         ],
//       ),
//     );
//   }

//   getActions(BuildContext context) => Row(
//         children: [
//           SizedBox(width: 16),
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(6),
//               color: Theme.of(context).colorScheme.onPrimary,
//             ),
//             child: IconButton(
//               icon: Icon(
//                 Icons.add,
//                 color: Theme.of(context).colorScheme.primary,
//                 size: 20,
//               ),
//               padding: EdgeInsets.all(0),
//               constraints: BoxConstraints(
//                 maxHeight: 36,
//                 maxWidth: 36,
//               ),
//                 onPressed: (){
//                   widget.onUpdate?.call(true);
//                 }
//             ),
//           ),
//           SizedBox(width: 16),
//           GestureDetector(
//             onTap: () {},
//             child: Text(
//               "${widget.cartModel.quantity}",
//               textAlign: TextAlign.start,
//               style: TextStyleConstants.price.copyWith(
//                 color: UIConstants.gray3Color,
//               ),
//             ),
//           ),
//           SizedBox(width: 16),
//           Container(
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(6),
//               color: (widget.cartModel.quantity! == 1 ) ? Colors.grey : Theme.of(context).colorScheme.onPrimary,
//             ),
//             child: IconButton(
//               icon: Icon(
//                 Icons.remove,
//                 color: Theme.of(context).colorScheme.primary,
//                 size: 20,
//               ),
//               padding: EdgeInsets.all(0),
//               constraints: BoxConstraints(
//                 maxHeight: 36,
//                 maxWidth: 36,
//               ),
//               onPressed: (){
//                 widget.onUpdate?.call(false);
//               },
//             ),
//           ),
//         ],
//       );

//   void onFavouriteClick() async {
//     _loadingNotifier.value = true;
//     var res = await productBloc.setFavorite(widget.cartModel.productId ?? 0);
//     if (res != null) {
//       widget.cartModel.isFavorited = res.isFavorite;
//       setState(() {});
//     }
//     _loadingNotifier.value = false;
//   }

//   void onDeleteClick() async {
//     var res = await bloc.deleteFromCart(widget.cartModel.id ?? 1);
//     if (res == true) {
//       widget.onDelete?.call();
//     }
//   }
// }
