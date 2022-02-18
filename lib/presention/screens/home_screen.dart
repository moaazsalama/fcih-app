//import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fcih_app/business_logic/coures/courses_cubit.dart';
import 'package:fcih_app/constants/size_config.dart';
import 'package:fcih_app/constants/strings.dart';
import 'package:fcih_app/data/models/department.dart';
import 'package:fcih_app/presention/widgets/course_item_widget.dart';
import 'package:fcih_app/presention/widgets/custom_text_field.dart';
import 'package:fcih_app/presention/widgets/fliter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CoursesCubit, CoursesState>(
      listener: (context, state) async {
        if (state is CoursesInitial) {}
      },
      builder: (context, state) {
        var allCourses = BlocProvider.of<CoursesCubit>(context).allCourses;
        if (allCourses != null) {
          return LayoutBuilder(builder: (context, constrant) {
            SizeConfig().init(context);
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.white,
                title: Text('Courses',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontWeight: FontWeight.bold)),
                centerTitle: true,
                actions: [
                  IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, feedbackScreen);
                      },
                      icon: const Icon(
                        Icons.feedback_outlined,
                        color: primaryColor,
                      ))
                ],
              ),
              body: Container(
                //alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(
                    getProportionateScreenWidth(14),
                    getProportionateScreenHeight(14),
                    getProportionateScreenWidth(14),
                    0),
                padding: const EdgeInsets.all(8),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (platformGetter() != PlatForm.web)
                        StreamBuilder<ConnectivityResult>(
                            stream: Connectivity().onConnectivityChanged,
                            initialData: ConnectivityResult.none,
                            builder: (context, snapshot) {
                              return AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                alignment: Alignment.center,
                                color: Colors.white,
                                width: SizeConfig.screenWidth,
                                height: getProportionateScreenHeight(
                                    snapshot.data == ConnectivityResult.none
                                        ? 30
                                        : 0),
                                constraints: BoxConstraints(
                                    maxHeight: getProportionateScreenHeight(
                                        snapshot.data == ConnectivityResult.none
                                            ? 30
                                            : 0)),
                                child: const Text(
                                  'No Network Connection',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 18),
                                ),
                              );
                            }),
                      Center(child: buildSearchBar(context)),
                      SizedBox(
                        height: getProportionateScreenHeight(10),
                      ),
                      Wrap(
                        //         verticalDirection: VerticalDirection.up,
                        spacing: getProportionateScreenWidth(10),
                        direction: Axis.horizontal,
                        children: const [
                          FilterItem(title: "All Courses", keys: 0),
                          FilterItem(title: "Level 1", keys: 1),
                          FilterItem(title: "Level 2", keys: 2),
                          FilterItem(title: "Level 3", keys: 3),
                          FilterItem(title: "Level 4", keys: 4)
                        ],
                      ),
                      if (state is CoursesSearchingState)
                        Column(
                          children: (state)
                              .searchedCourses
                              .map((e) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CourseItem(course: e),
                                  ))
                              .toList(),
                        )
                      else
                        Column(
                          children: [
                            departmentGetter(
                                context, 'HU Courses', Department.hu),
                            departmentGetter(
                                context, 'CS Courses', Department.cs),
                            departmentGetter(
                                context, 'IS Courses', Department.iss),
                            departmentGetter(
                                context, 'IT Courses', Department.it),
                            departmentGetter(
                                context, 'MA&PHA Courses', Department.ma),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            );
          });
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Widget departmentGetter(
      BuildContext context, String title, Department department) {
    var fitlteredData = BlocProvider.of<CoursesCubit>(context).fliteredCourses;
    var list = fitlteredData.where((e) => e.department == department).toList();
    var courses = List.generate(list.length, (index) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0),
        child: CourseItem(
          course: list[index],
        ),
      );
    });
    return courses.isEmpty
        ? Container()
        : ExpansionTile(
            initiallyExpanded: true,
            title: Text(
              title,
              textAlign: TextAlign.start,
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  fontSize: SizeConfig.orientation == Orientation.portrait
                      ? getProportionScreenration(25)
                      : getProportionScreenration(75),
                  fontWeight: FontWeight.bold),
            ),
            children: courses,
          );
  }

  Widget buildSearchBar(BuildContext context) {
    return SizedBox(
      height: getProportionateScreenHeight(
          SizeConfig.orientation == Orientation.portrait ? 40 : 120),
      child: CustomTextField(
        onChanged: BlocProvider.of<CoursesCubit>(context).searching,
        hintText: 'Searching..',
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
