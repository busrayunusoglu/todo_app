import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/services/todo_services.dart';

class TodoRepository implements TodoServices {
  List<TodoModel?>? todoModel;

  TodoServices services = TodoServices();

  late Map<String, String> header;

  @override
  Future<List<TodoModel?>?> todo() async {
    return TodoServices().todo();
  }
}
