import 'dart:convert';



ToDoModel toDoModelFromJson(String str) => ToDoModel.fromJson(json.decode(str));

String toDoModelToJson(ToDoModel data) => json.encode(data.toJson());

class ToDoModel {
    ToDoModel({
        this.id,
        this.tipo,
        this.todo,
        this.success,
    });

    String id;
    String tipo;
    String todo;
    bool success;

    factory ToDoModel.fromJson(Map<String, dynamic> json) => ToDoModel(
        id: json["id"],
        tipo: json["tipo"],
        todo: json["todo"],
        success: json["success"],
    );

    Map<String, dynamic> toJson() => {
        // "id": id,
        "tipo": tipo,
        "todo": todo,
        "success": success,
    };
}
