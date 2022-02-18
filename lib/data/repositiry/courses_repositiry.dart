import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fcih_app/constants/strings.dart';

import 'package:fcih_app/data/models/course.dart';
import 'package:fcih_app/data/web_services/db_helper.dart';
import 'package:fcih_app/data/web_services/google_sheets_api.dart';

//import 'package:flutter_offline/flutter_offline.dart'as offline;
class CoursesRepositiry {
  final UserSheetApi userSheet;

  CoursesRepositiry(this.userSheet);
  Future<List<Course>> getAllCourses() async {
    var platform = platformGetter();
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none &&
        platform == PlatForm.android) {
      var databaseCourses = await getCoursesFromDatabase();

      return databaseCourses;
    } else {
      var courses = await userSheet.getCourses();
      var converted = courses!.map((e) => Course.fromMap(e)).toList();

      if (platform == PlatForm.android) {
        await DBHelper.deleteTable();
        await DBHelper.insertCourses(converted);
      }

      return converted;
    }
  }

  Future<List<Course>> getCoursesFromDatabase() async {
    List<Map<String, Object?>> courses = await DBHelper.getCourses();

    var list = courses.map((e) => Course.fromDatabase(e)).toList();

    return list;
  }
}
