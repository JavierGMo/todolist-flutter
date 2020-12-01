import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:todolist/src/model/todo_model.dart';

//Aqui se trae toda la data que ocupemos, ya sea de internet o de una base de datos


class ToDoProvider {
  final String _url = 'https://flutter-todos-4d8d3.firebaseio.com/';

  Future<List<ToDoModel>> cargarToDos() async {
    final url = '$_url/todos.json';
    final resp = await http.get(url);
    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<ToDoModel> todos = new List();
    if(decodedData == null) return [];
    if(decodedData['error'] != null) return [];

    decodedData.forEach((id, todoF){
      final todoTemp = ToDoModel.fromJson(todoF);
      todoTemp.id = id;

      todos.add(todoTemp);


    });

    return todos;
    
  }

  Future<bool> crearToDo(ToDoModel todo) async {

    final url = '$_url/todos.json';
    final resp = await http.post(
      url,
      body: toDoModelToJson(todo)
    );

    final decodedData = json.decode(resp.body);

    return true;

  }

  Future<bool> borrarToDo(String id) async {

    final url = '$_url/todos/$id.json';
    final resp = await http.delete(url);
    
    
    return true;

  }

  


}