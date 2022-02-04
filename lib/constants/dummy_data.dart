import 'package:fcih_app/data/models/course.dart';
import 'package:fcih_app/data/models/department.dart';

List<Course> data = List.generate(
    40,
    (index) => Course(
        name: "Ai$index",
        code: 'cs22$index',
        department: Department.values[index % 5],
        level: index % 4 + 1,
        link: 'https://www.facebook.com/moaaz.salama.121/'));
