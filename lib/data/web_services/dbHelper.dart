import 'package:fcih_app/data/models/course.dart';
import 'package:fcih_app/data/models/department.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static Database? _db;
  static const int _version = 1;
  static const _tableName = 'courses';

  static Future<void> initDb() async {
    if (_db != null) return;
    try {
      var directory = await getDatabasesPath();
      String _path = join(directory, 'course.db');

      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: (db, version) async {
          print('object');
          return await db.execute('''
CREATE TABLE $_tableName (
  code STRING PRIMARY KEY,
  name STRING,
  department INTEGER, 
  level INTEGER,
  link STRING
  )''');
        },
        onOpen: (db) {
          print('opened');
        },
      );
    } catch (e) {
      print(e.toString() + "aa");
    }
  }

  static Future<List<Map<String, dynamic>>> getCourses() async {
    if (_db == null) {
      await initDb();
    }
    var list = await _db!.query(_tableName);
    var list2 = List.generate(
        list.length,
        (index) => Course(
            code: list[index]['code'] as String?,
            link: list[index]['link'] as String?,
            name: list[index]['name'] as String?,
            level: int.parse(list[index]['level'] as String),
            department: Department
                .values[int.parse(list[index]['department'] as String)]));
    print(list2);
    return list.toList();
  }

  static Future<int> insert(Course course) async {
    return _db!.insert(_tableName, course.toMap());
  }

  static Future<void> insertCourses(List<Course> courses) async {
    if (_db == null) {
      await initDb();
    }
    courses.map((course) async {
      return await _db!.insert(_tableName, course.toMap());
    }).toList();
  }

  static Future<int> delete(String courseCode) async {
    return _db!.delete(_tableName, where: 'code=?', whereArgs: [courseCode]);
  }

  static Future<int> update(Course course) async {
    return _db!.update(_tableName, course.toMap(),
        where: 'id=?', whereArgs: [course.code]);
  }

  static Future<int> deleteTable() async {
    if (_db == null) {
      await initDb();
    }
    return _db!.delete(_tableName);
  }
}
