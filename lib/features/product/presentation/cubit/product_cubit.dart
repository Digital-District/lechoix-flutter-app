// import 'dart:convert';

// import 'package:bloc/bloc.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';

// import '../../../../core/constant/colors/colors.dart';
// import '../../../../core/error/failures.dart';
// import '../../../../core/widgets/app_snak_bar.dart';
// import '../../data/models/product_details.dart';
// import '../../domain/usecases/get_product_details.dart';

// part 'product_state.dart';

// class ProductCubit extends Cubit<ProductState> {
//   ProductCubit({
//     required this.getProductDetails,
//   }) : super(ProductInitial());

//   final GetProductDetails getProductDetails;
//   ProductDetails? product;
//   final box = Hive.box("myBox");
//   List<int> productIds = [];
//   List<int> quantitys = [];
//   List<int> prices = [];
//   List<int> totals = [];
//   List<int> options = [];
//   List<String> productName = [];
//   List<String> productImages = [];
//   int total = 0;
//   int optionId = 0;
//   double totalScores = 0.0;
//   List<Value> size = [];
//   List<Value> color = [];
//   List optionsName = [];
//   List<OptionValue> OptionsV = [];

//   clear() {
//     productIds.clear();
//     quantitys.clear();
//     prices.clear();
//     totals.clear();
//     options.clear();
//     productName.clear();
//     productImages.clear();
//     totalScores = 0.0;
//     optionId = 0;
//   }

//   void add2cart(
//     context, {
//     required int productId,
//     required int optionsId,
//   }) async {
//     await Hive.openBox("myBox");
//     if (box.isOpen) {
//       clear();
//       if (box.isEmpty) {
//         box.put("options", jsonEncode(options));
//       }
//       options = json.decode(box.get("options")).cast<int>() ?? [];
//       if (options.contains(optionsId)) {
//         ScaffoldMessenger.of(context).showSnackBar(
//             appSnackBar(tr("this product is already exist"), color: redColor));
//       } else {
//         options.add(optionsId);
//         productIds.add(productId);
//         box.put("options", jsonEncode(options));
//         box.put("productIds", jsonEncode(productIds));
//         ScaffoldMessenger.of(context).showSnackBar(
//             appSnackBar(tr("done_add_to_cart"), color: successColor));
//         await clear();
//       }
//     } else {}
//   }

//   // handleOptions(value) {
//   //   List<OptionValue> value = product!.optionValues!;
//   //   List optionsId = [];
//   //   Set<Value> options = {};
//   //   List optionsValueID = [];
//   //   OptionsV.clear();
//   //   options.clear();
//   //   /// 1- loop in options > loop in values  option_name = "" if success list<Map<String,dynamic>> of value option name
//   //   /// 2-
//   //   for (int i = 0; i < value.length; i++) {
//   //     for (int v = 0; v < value[i].values!.length; v++) {
//   //       optionsId.add(value[i].values![v].id);
//   //       options.add(value[i].values![v]);
//   //       optionsValueID = json.decode(value[i].optionValueId!).toList();
//   //       optionsValueID.every((element) => element);
//   //       List filter = options
//   //           .where((element) => element.id == optionsValueID[0])
//   //           .toList();
//   //       log("optionfiltersValueID" + filter.toString());
//   //       log("options" + options.toString());
//   //       // List optionsList = options.toSet() as List;
//   //       // log("options list " + optionsList.toString());
//   //       if (options.contains(value[i].values![v].id)) {
//   //         log("YES");
//   //         Map<String, dynamic> oneOption = {};
//   //         if (optionsName
//   //             .contains(options.contains(value[i].values![v].name))) {
//   //         } else {
//   //           optionsName.add(value[i].values![v].name);
//   //         }
//   //       } else {
//   //         // options.add(value[i].values![v].optionId);
//   //         // optionsName.add(value[i].values![v].name);
//   //         // OptionsV = {
//   //         //   'option_name': value[i].values![v].optionName,
//   //         //   'option_id': options,
//   //         //   'values': optionsName
//   //         // };
//   //         // Map<String, dynamic> allOptions = {
//   //         //   "optionKey": value[i].values![v].optionName,
//   //         //   "optionValue": OptionsV
//   //         // };
//   //         // List<Map<String, dynamic>> listOfAllOptions = [];
//   //         // listOfAllOptions.add(allOptions);
//   //         // log(listOfAllOptions.toString());
//   //       }
//   //       // log(OptionsV.toString());
//   //     }
//   //   }
//   // }

//   fGetProductDetails(id) async {
//     emit(ProductDetailsLoading());
//     final failOrsuccess = await getProductDetails(ProductDetailsParams(id: id));
//     failOrsuccess.fold((fail) {
//       if (fail is ServerFailure) {
//         fail.message;
//       }
//       emit(ProductDetailsError());
//       // emit(GetRegisterParametersErrorState());
//     }, (success) async {
//       product = success.data!;
//       emit(ProductDetailsSuccess());
//       OptionsV = success.data!.optionValues!;
//     });
//   }
// }
