import 'dart:convert';

import 'package:todo_app/model/todo_model.dart';
import 'package:http/http.dart' as http;

class TodoServices {
  static String todoUrl = "https://jsonplaceholder.typicode.com/todos";

  Future<List<TodoModel?>?> todo() async {
    var response = await http.get(Uri.tryParse(todoUrl)!);
    if (response.statusCode == 200) {
      var map = json.decode(response.body);
      List<TodoModel?> list = [];
      map
          .asMap()
          .forEach((index, value) => list.add(TodoModel.fromJson(value)));
      return list;
    } else {
      return [];
    }
  }
}
