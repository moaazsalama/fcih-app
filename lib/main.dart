import 'package:fcih_app/app_router.dart';
import 'package:fcih_app/business_logic/cubit/courses_cubit.dart';
import 'package:fcih_app/constants/strings.dart';
import 'package:fcih_app/data/web_services/dbHelper.dart';
import 'package:fcih_app/data/web_services/google_sheets_Api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  await UserSheetApi.init();

    await DBHelper.initDb();

  runApp(BlocProvider(
    create: (context) => CoursesCubit()..getAllCourses(),
    child: MyApp(
      appRouter: AppRouter(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appRouter}) : super(key: key);
  final AppRouter appRouter;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: primaryColor,
        ),
        textTheme: const TextTheme(subtitle1: TextStyle(color: primaryColor)),
      ),
      onGenerateRoute: appRouter.genrateRoute,
    );
  }
}
