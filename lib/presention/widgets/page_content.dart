import 'package:fcih_app/business_logic/onbording/onboarding_cubit.dart';
import 'package:fcih_app/constants/size_config.dart';
import 'package:fcih_app/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageContent extends StatelessWidget {
  final Widget widget;
  final String title;
  final double? space;
  final String description;
  final Color? color;
  final bool islast;
  const PageContent({
    Key? key,
    required this.widget,
    required this.title,
    required this.description,
    this.color,
    this.space,
    this.islast = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = OnboardingCubit.cubit(context);
    return SafeArea(
      child: Container(
          //color: Colors.red,
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              SizedBox(
                height: SizeConfig.screenHeight * .7,
                child: Column(
                  children: [
                    widget,
                    Text(
                      title,
                      style: TextStyle(
                          color: primaryColor,
                          fontSize: getProportionScreenration(24),
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(space ?? 30),
                    ),
                    Expanded(
                      child: Text(
                        description,
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: getProportionScreenration(14),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SmoothPageIndicator(
                        onDotClicked: (index) {
                          cubit.pageController.animateToPage(index,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeIn);
                        },
                        effect: const WormEffect(
                            spacing: 16,
                            dotColor: Colors.black,
                            activeDotColor: primaryColor),
                        controller: cubit.pageController,
                        count: 4),
                    BlocBuilder<OnboardingCubit, OnboardingState>(
                      builder: (context, state) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(
                              getProportionScreenration(100)),
                          child: SizedBox(
                            height: getProportionateScreenHeight(40),
                            width: SizeConfig.screenWidth / 1.5,
                            child: OutlinedButton(
                                //    clipBehavior: Clip.hardEdge,
                                onPressed: () async {
                                  if (islast) {
                                    var shared =
                                        await SharedPreferences.getInstance();
                                    await shared.setBool('first', false);
                                    cubit.pageController.dispose();
                                    Navigator.pushNamed(context, homepage);
                                  } else {
                                    cubit.pageController.nextPage(
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.linear);
                                  }
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.resolveWith(
                                          (states) => primaryColor),
                                ),
                                child: Text(
                                  islast ? 'Get Start' : 'Next',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: getProportionScreenration(20)),
                                )),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
