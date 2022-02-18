import 'package:fcih_app/business_logic/onbording/onboarding_cubit.dart';
import 'package:fcih_app/constants/size_config.dart';
import 'package:fcih_app/presention/widgets/page_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/custom_text_field.dart';
import '../widgets/fliter_widget.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var cubit = OnboardingCubit.cubit(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(bottom: getProportionateScreenHeight(80)),
        child: PageView(
          controller: cubit.pageController,
          children: [
            PageContent(
              widget: SvgPicture.asset(
                'assets/images/page1.svg',
                height: getProportionateScreenHeight(300),
                width: getProportionateScreenHeight(200),
                fit: BoxFit.contain,
              ),
              title: 'Welcome To MyFCIH',
              description:
                  'This App Developed to help Fcih Students to provide all material and coureses of faculty.\n so thanks for install our App ',
            ),
            PageContent(
              widget: SizedBox(
                height: SizeConfig.screenHeight / 2,
                width: SizeConfig.screenWidth * .8,
                child: Center(
                  child: Wrap(
                    //         verticalDirection: VerticalDirection.up,
                    spacing: getProportionateScreenWidth(10),
                    direction: Axis.horizontal,
                    // verticalDirection: VerticalDirection.up,
                    // crossAxisAlignment: WrapCrossAlignment.center,
                    // alignment: WrapAlignment.center,
                    children: const [
                      FilterItem(title: "All Courses", keys: 0),
                      FilterItem(title: "Level 1", keys: 1),
                      FilterItem(title: "Level 2", keys: 2),
                      FilterItem(title: "Level 3", keys: 3),
                      FilterItem(title: "Level 4", keys: 4)
                    ],
                  ),
                ),
              ),
              space: 10,
              title: 'Filter by level',
              description: 'Select your level to reach for course faster',
            ),
            PageContent(
              widget: SizedBox(
                height: getProportionateScreenHeight(300),
                width: SizeConfig.screenWidth * .8,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildSearchBar(context, 'IS211'),
                    SizedBox(
                      height: getProportionateScreenHeight(20),
                    ),
                    buildSearchBar(context, 'Database Systems -1'),
                  ],
                ),
              ),
              title: 'Search By Course Name/Code',
              description: 'Search for courses by name or code avalible in app',
            ),
            PageContent(
              islast: true,
              widget: SvgPicture.asset(
                'assets/images/page2.svg',
                height: getProportionateScreenHeight(300),
                width: getProportionateScreenHeight(200),
                fit: BoxFit.contain,
              ),
              title: 'Enjoy',
              description:
                  'Don\'t forget to give us feedback about your experience in our app ',
            ),
          ],
          onPageChanged: cubit.onChanged,
        ),
      ),
    );
  }

  Widget buildSearchBar(BuildContext context, String hintText) {
    return SizedBox(
      height: getProportionateScreenHeight(
          SizeConfig.orientation == Orientation.portrait ? 40 : 120),
      child: CustomTextField(
        disabled: true,

        //    onChanged: BlocProvider.of<CoursesCubit>(context).searching,
        hintText: hintText,
        prefixIcon: Icon(
          Icons.search,
          color: Colors.grey,
          size: SizeConfig.orientation == Orientation.portrait
              ? getProportionScreenration(24)
              : getProportionScreenration(75),
        ),
      ),
    );
  }
}
