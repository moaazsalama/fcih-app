import 'dart:convert';

import 'package:fcih_app/data/models/department.dart';

class Course {
  String? code;
  String? name;
  String? link;
  int? level;
  Department? department;
  Course({
    this.code,
    this.name,
    this.link,
    this.level,
    this.department,
  });

  Course copyWith({
    String? code,
    String? name,
    String? link,
    int? level,
    Department? department,
  }) {
    return Course(
      code: code ?? this.code,
      name: name ?? this.name,
      link: link ?? this.link,
      level: level ?? this.level,
      department: department ?? this.department,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'name': name,
      'link': link,
      'level': level,
      'department': department?.index,
    };
  }

  factory Course.fromMap(Map<String, dynamic> map) {
    print(map);
    try {
      return Course(
        code: map['code'] as String,
        name: map['name'] as String,
        link: map['link'] as String,
        level: int.parse(map['level']),
        department: map['department'] != null
            ? Department.values[int.parse(map['department'])]
            : null,
      );
    } on Exception catch (e) {
      print(e.toString());

      return Course();
    }
  }

  String toJson() => json.encode(toMap());

  factory Course.fromJson(String source) => Course.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Course(code: $code, name: $name, link: $link, level: $level, department: $department)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Course &&
        other.code == code &&
        other.name == name &&
        other.link == link &&
        other.level == level &&
        other.department == department;
  }

  @override
  int get hashCode {
    return code.hashCode ^
        name.hashCode ^
        link.hashCode ^
        level.hashCode ^
        department.hashCode;
  }
}
