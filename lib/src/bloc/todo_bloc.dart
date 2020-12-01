import 'dart:async';

import 'package:todolist/src/model/todo_model.dart';
import 'package:todolist/src/providers/todo_provider.dart';

class ToDoBloc{
  final _todosProvider = new ToDoProvider();
  final _toDoController = new StreamController<List<ToDoModel>>.broadcast();
  final _cargandoToDoController = new StreamController<bool>.broadcast();


  Stream<List<ToDoModel>> get toDosStream => _toDoController.stream;
  Stream<bool> get cargandoToDosStream => _cargandoToDoController.stream;

  void cargarToDos() async {
    final todos = await this._todosProvider.cargarToDos();

    _toDoController.sink.add(todos);
  }

  void agregarToDo(ToDoModel todoVal) async {

    _cargandoToDoController.sink.add(true);
    await _todosProvider.crearToDo(todoVal);
    _cargandoToDoController.sink.add(false);

  }

  void borrarProducto(String id) async {
    await _todosProvider.borrarToDo(id);
  }

  void dispose(){
    _toDoController?.close();
    _cargandoToDoController?.close();
  }




}