import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import 'package:fcih_app/business_logic/feedback/feedback_cubit.dart';
import 'package:fcih_app/business_logic/onbording/onboarding_cubit.dart';
import 'package:fcih_app/constants/strings.dart';
import 'package:fcih_app/presention/screens/feedback_screen.dart';
import 'package:fcih_app/presention/screens/home_screen.dart';
import 'package:fcih_app/presention/screens/onbording_screen.dart';

class AppRouter {
  bool isFirst;
  AppRouter({
    required this.isFirst,
  });
  PageRoute genrateRoute(RouteSettings settings) {
    switch (settings.name) {
      case homepage:
        return MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        );
      case feedbackScreen:
        return PageTransition(
            child: BlocProvider(
              create: (context) => FeedbackCubit(),
              child: const FeedbackScreen(),
            ),
            type: PageTransitionType.rightToLeft);

      default:
        return MaterialPageRoute(
          builder: (context) => isFirst
              ? BlocProvider<OnboardingCubit>(
                  create: (context) => OnboardingCubit(),
                  child: const OnBoardingScreen(),
                )
              : const HomeScreen(),
        );
    }
  }
}
