import 'package:fcih_app/app_router.dart';
import 'package:fcih_app/business_logic/coures/courses_cubit.dart';
import 'package:fcih_app/constants/strings.dart';
import 'package:fcih_app/data/web_services/db_helper.dart';
import 'package:fcih_app/data/web_services/google_sheets_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // var shard = await SharedPreferences.getInstance();
  WidgetsFlutterBinding.ensureInitialized();

  PlatForm platForm = platformGetter();
  await UserSheetApi.init();
  dynamic first;
  if (platForm == PlatForm.android || platForm == PlatForm.windows) {
    var sharedPreferences = await SharedPreferences.getInstance();
    first = sharedPreferences.getBool('first');
  }

  if (platForm == PlatForm.android) await DBHelper.initDb();
//  print('$data');
  runApp(BlocProvider(
    create: (context) => CoursesCubit()..getAllCourses(),
    child: MyApp(
      appRouter: AppRouter(
          isFirst: platForm == PlatForm.android ? first ?? true : false),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appRouter}) : super(key: key);
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        //       primarySwatch: MaterialColor(Colors.white.value, {}),
        primaryColor: const Color.fromARGB(255, 219, 211, 211),
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: primaryColor,
        ),
        textTheme: const TextTheme(subtitle1: TextStyle(color: primaryColor)),
      ),
      onGenerateRoute: appRouter.genrateRoute,
    );
  }
}
