import 'package:flutter/material.dart';
import 'package:todo_bloc/src/bloc/todo_bloc.dart';
import 'package:todo_bloc/src/bloc/todo_event.dart';

import '../model/todo.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _bloc = TodoBloc();

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          "BloC ToDo App",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.lightBlueAccent,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            _showDialog(context, _bloc);
          }),
      body: StreamBuilder(
        stream: _bloc.todos,
        builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text(
                'Add new ToDo',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onDoubleTap: () =>
                    _bloc.dispatch(ToggleTodoEvent(index: index)),
                onLongPress: () =>
                    _bloc.dispatch(DeleteTodoEvent(index: index)),
                child: ListTile(
                  title: Text(
                    snapshot.data![index].title,
                    style: TextStyle(
                        decoration: snapshot.data![index].isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

_showDialog(BuildContext context, TodoBloc bloc) async {
  TextEditingController _controller = TextEditingController();
  await showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.all(16.0),
          content: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: _controller,
                  autofocus: true,
                  decoration: const InputDecoration(
                      labelText: 'What to do?', hintText: 'eg. Go to mall'),
                ),
              )
            ],
          ),
          actions: <Widget>[
            TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.pop(context);
                }),
            TextButton(
                child: const Text('SAVE'),
                onPressed: () {
                  if (_controller.text != '') {
                    bloc.dispatch(
                      AddTodoEvent(
                        todo: Todo(title: '${_controller.text.toString()}'),
                      ),
                    );
                  }
                  Navigator.pop(context);
                })
          ],
        );
      });
}
