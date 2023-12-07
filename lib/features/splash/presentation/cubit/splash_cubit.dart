import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lechoix/core/util/new_navigator/navigator.dart';
import 'package:lechoix/features/home/presentation/pages/bottom_bar.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  static SplashCubit get(BuildContext context) => BlocProvider.of(context);

  // SharedPrefService prefs = SharedPrefService();
  void getSplash(context) {
    Future.delayed(const Duration(milliseconds: 400),
        () => Navigation.popAllAndPush(context, screen: HomeLayoutScreen()));
  }
}
