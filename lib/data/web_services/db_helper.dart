import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:fcih_app/data/models/course.dart';

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
          return await db.execute('''
      CREATE TABLE $_tableName (
  code STRING PRIMARY KEY,
  name STRING,
  department INTEGER, 
  level INTEGER,
  link STRING
  )''');
        },
      );
    } catch (e) {
      print(e.toString() + "aa");
    }
  }

  static Future<List<Map<String, Object?>>> getCourses() async {
    if (_db == null) {
      await initDb();
    }
    List<Map<String, Object?>> rawQuery =
        await _db!.rawQuery('SELECT * FROM courses');

    return rawQuery;
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
