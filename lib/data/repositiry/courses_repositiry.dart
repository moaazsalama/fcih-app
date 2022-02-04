import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:fcih_app/data/models/course.dart';
import 'package:fcih_app/data/web_services/dbHelper.dart';
import 'package:fcih_app/data/web_services/google_sheets_Api.dart';

//import 'package:flutter_offline/flutter_offline.dart'as offline;
class CoursesRepositiry {
  final UserSheetApi userSheet;

  CoursesRepositiry(this.userSheet);
  Future<List<Course>> getAllCourses() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.none) {
      var databaseCourses = await getCoursesFromDatabase();
      print(databaseCourses);
      return databaseCourses;
    } else {
      var courses = await userSheet.getCourses();
      var converted = courses!.map((e) => Course.fromMap(e)).toList();
      await DBHelper.deleteTable();
      await DBHelper.insertCourses(converted);
      return converted;
    }
  }

  Future<List<Course>> getCoursesFromDatabase() async {
    print('fn');
    var courses;
    try {
      courses = await DBHelper.getCourses();
      print(courses);
    } on Exception catch (e) {
      print(e.toString() + "Rrrr");
    }
    var list = courses.map((e) => Course.fromMap(e)).toList();

    return list;
  }
}
