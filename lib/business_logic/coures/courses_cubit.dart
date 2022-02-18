import 'package:fcih_app/data/models/course.dart';
import 'package:fcih_app/data/repositiry/courses_repositiry.dart';
import 'package:fcih_app/data/web_services/google_sheets_api.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'courses_state.dart';

class CoursesCubit extends Cubit<CoursesState> {
  CoursesCubit() : super(CoursesInitial());
  List<Course>? allCourses;
  List<Course> fliteredCourses = [];
  Map<int, bool> filters = {0: true, 1: false, 2: false, 3: false, 4: false};
  final CoursesRepositiry coursesRepositiry = CoursesRepositiry(UserSheetApi());
  Future<void> getAllCourses() async {
    if (allCourses != null) {
      emit(CoursesLoadedState(allCourses!));
    } else {
      try {
        emit(CoursesloadingState());
        allCourses = await coursesRepositiry.getAllCourses();
        fliteredCourses = allCourses!;
        emit(CoursesLoadedState(allCourses!));
      } catch (e) {
        print(e);
        emit(CoursesErrorState("There something Wrong"));
      }
    }
  }

  searching(String value) {
    if (value.isNotEmpty) {
      var list = fliteredCourses
          .where((element) =>
              element.name!.contains(value) || element.code!.contains(value))
          .toList();
      emit(CoursesSearchingState(list));
    } else {
      emit(CoursesInitial());
    }
  }

  changeFilter(int keys) {
    filters = filters.map((key, value) {
      if (key == keys) {
        return MapEntry(key, true);
      } else {
        return MapEntry(key, false);
      }
    });

    fliteredCourses = keys == 0
        ? allCourses!
        : allCourses!.where((element) {
            return element.level == keys;
          }).toList();
    emit(CoursesFliterState(fliteredCourses));
  }
}
