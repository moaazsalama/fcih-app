part of 'courses_cubit.dart';

@immutable
abstract class CoursesState {}

class CoursesInitial extends CoursesState {}

class CoursesLoadedState extends CoursesState {
  final List<Course> courses;

  CoursesLoadedState(this.courses);
}

class CoursesFliterState extends CoursesState {
  final List<Course> courses;

  CoursesFliterState(this.courses);
}

class CoursesErrorState extends CoursesState {
  final String errorMessage;

  CoursesErrorState(this.errorMessage);
}

class CoursesloadingState extends CoursesState {}

class CoursesSearchingState extends CoursesState {
  final List<Course> searchedCourses;

  CoursesSearchingState(this.searchedCourses);
}
