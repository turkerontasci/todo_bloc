import 'package:todo_bloc/src/model/todo.dart';

abstract class TodoEvent {}

class AddTodoEvent extends TodoEvent {
  Todo todo;
  AddTodoEvent({required this.todo});
}

class DeleteTodoEvent extends TodoEvent {
  int index;
  DeleteTodoEvent({required this.index});
}

class ToggleTodoEvent extends TodoEvent {
  int index;
  ToggleTodoEvent({required this.index});
}
