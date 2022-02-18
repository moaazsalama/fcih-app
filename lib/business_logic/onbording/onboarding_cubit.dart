import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  PageController pageController = PageController(
    initialPage: 0,
  );
  int currentPage = 0;
  void onChanged(int value) {
    currentPage = value;
    emit(OnboardingInitial());
  }

  bool last = false;
  change() {
    last = true;
    emit(OnboardingInitial());
  }

  static OnboardingCubit cubit(context) =>
      BlocProvider.of<OnboardingCubit>(context);
  OnboardingCubit() : super(OnboardingInitial());
}
