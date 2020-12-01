import 'package:flutter/material.dart';

import 'package:todolist/src/pages/home_page.dart';
import 'package:todolist/src/pages/login_page.dart';
import 'package:todolist/src/pages/settings_page.dart';
import 'package:todolist/src/pages/todo_page.dart';
import 'package:todolist/src/preferencias_usuario/preferencias_usuario.dart';
 
void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  final prefs = new PreferenciasUsuario();
  
  await prefs.initPrefs();


  runApp(MyApp());
}
 
class MyApp extends StatelessWidget {

  final prefs = new PreferenciasUsuario();
  //prefs.routeName
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'todolist',
      initialRoute: prefs.routeName,
      routes: {
        'home' : (BuildContext context)=>HomePage(),
        'todopage' : (BuildContext context)=>ToDoPage(),
        'login' : (BuildContext context)=>LoginPAge(),
        'settings' : (BuildContext context)=>SettingsPage(),
      },
    );
  }
}