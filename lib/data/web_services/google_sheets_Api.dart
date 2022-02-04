// ignore_for_file: avoid_bool_literals_in_conditional_expressions

import 'package:gsheets/gsheets.dart';

class UserSheetApi {
  static const _spreedSheetId = '1guQsPjthWict47n32k9ycE03vSAvpQxkxpMFeCnXBkg';
  static const _credentials = r'''
 {
  "type": "service_account",
  "project_id": "telegram-b8bef",
  "private_key_id": "314c70dd6f9efdcc03a729f8e196d28d0db5ee4d",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQC1GhSc1mYYnRKN\n3Nq2cS5kXTc4CDSdhYZh0RVMuLIVUPr+7DUMl7a+p46c7pB/iXOp/aBgMMAVD7pn\nH49+Al01ECTR2lNNb8fym96lWX90Lz7O0jz7Foj8evn37Zvevv2aZjorNGOE8Bbe\n4QKhm3BehWM4mqE3UVVNw1Xhdapf/NPQzWIkncxjWlt2avP4o4sy0yT8vWmVH6LF\nnROSeWXD3uq1IybnMqTH7jloT0h7IGzpLSy4ZMMBaDuc0aKiLeEKeMPJN9p5o0Mn\nkHvsXlfxHNVMHcMjKR62fiXEeyOGY85gPryLffMeZPTphlWx5z72+jv5Y/XA5Me9\nNr/vsb/VAgMBAAECggEABT3fJbeG5GSgl/6NTgVgCPFWUc//jwDBgYhrZ2cSQr1m\nJmECrcbpykt0YPb+s625WwOi09OeiVjy5+97WAYMWbkcd7VQkRDsCy5ym43+uz5v\nZYR+jH3poIdv0d86bbTjK+yUZUjgUs6xTQ4kd1qxPjRDSX9E0ZA0zCVlNhbIVjLX\n9mPvVAstQXiCYfbgT8DSi8n2Ysesinst0a2aFD+ajvSJ6fkybYazTfifJhIzdL7r\nFKnXrX4CDaCoMEqra8jt55ufdXqESrFvoiW2SxsNu2CWn82Oyrsbh8Xtz5dpTExa\nxOh+gENrtccuae0AVoPp5I+DuUdzqJF0SWYxPCT2gQKBgQD7xMGbLkYtngBex8TO\nNbMnza/Hy1tdirFA2+E+f0MKJtyfxib1qYK9p7l3EkWpViISyknpWbk84eaEC7oD\n8XRbno/esmmpFPdifXUlBVdh8hh74h2Uud0IQ9O3ph4nzHDzkYRrNn9SaCrHiAKr\ndLkQdBP8YW7v9hIlakZ9iOe+UQKBgQC4JUcylhEcgT9mgQ4vC+8w6iPhWoS6Hknw\n+IDUZrLzu/qUPoANUjP5d4QUh5kNOKWv+SDpxNuhjMRfozcfppz9dqeVn1mKktNv\nRvEOh9VgF//MikA58LvMpA6WjkDyICQbJeVQkwJ8xC5t26yeY6Ec00zHmnWIRtX9\nNeBw+aM0RQKBgQCcWqjRsn8qvUEFm5KBbaABTB+qOIRZJ1TFLshHg8kieNfy8aAo\nWEk1dwAbDmHss+0dNjuIi4waX0BFKPMwl7bnXyWB69LqinbH15n0j8igrzS9WsN8\nJaE7DMRi/OslVDWhTfGqk4Gmr8JBgBoIWMjFixEOX4QByhOi4Mk+FNO2wQKBgHZX\nzsfd1aViEuLHcdweaVwgPWroh4AtUwvASNs4HS2y0zlOaXEmMSzT+FhRRLVQgHr1\nOofB8fyCwPlNpXF73EywYscvn5YFAkjzaJwUA7c79TL4bopOAgNkM9PiHC7/JPUl\nh5gewmx4j/YeRXONR8+EpEVrKLmp/IA8jb9NT+uZAoGBAL7zyHhcEYWzhoPN2CC+\n5fD60qcizjOR9O+jIjwm7VH9JwcMlC9Fw2auyShn7sEZS9Gzq5yAa3LqKADjj8MV\nnOChWVvzuU+OVJmrPWtDT1UnfrnUMUIIdRKDbJaoI1WKl9I9L0WQhd5h2o8Osr/J\nQ56GB5BUxIjQHo2WWzjyetQ8\n-----END PRIVATE KEY-----\n",
  "client_email": "telegram-b8bef@appspot.gserviceaccount.com",
  "client_id": "101388890780295758354",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/telegram-b8bef%40appspot.gserviceaccount.com"
}


  ''';
  static List<String> admins = [];
  static Worksheet? _courses;
  static final _gsheets = GSheets(_credentials);

  static Future<void> init() async {
    try {
      final spreadsheet = await _gsheets.spreadsheet(_spreedSheetId);
      _courses = await _getWorkSheet(spreadsheet, title: 'Courses');
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<Map<String, dynamic>>?> getCourses() async {
    var allRows = await _courses!.values.map.allRows(fromRow: 1);
    return allRows;
  }

  static Future<void> fetchAdmins() async {
    if (admins.isEmpty) {
      final List<Map<String, String>>? data =
          await _courses!.values.map.allRows(fromRow: 1);

      admins = List.generate(data!.length, (index) => data[index]['email']!);
    }
  }

  static Future<Worksheet?> _getWorkSheet(Spreadsheet spreedSheet,
      {required String title}) async {
    try {
      return await spreedSheet.addWorksheet(title);
    } catch (e) {
      return spreedSheet.worksheetByTitle(title);
    }
  }
}
