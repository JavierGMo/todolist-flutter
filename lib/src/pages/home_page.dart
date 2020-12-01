import 'package:flutter/material.dart';


import 'dart:ui';

import 'package:todolist/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:todolist/src/widgets/menu_widget.dart';

class HomePage extends StatelessWidget {

  final preferencias = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(63, 55, 201, 1.0),
        elevation: 0.0,
      ),
      drawer: MenuWidget(),
      body: PageView(
        scrollDirection: Axis.vertical,
        children: [
          Stack(
            children: [
              _backgroundHome(context, size),
              _inicio(context, size)
            ],
          ),
          _vistaDos(context),
        ]
      ),
    );
  }

  Widget _inicio(BuildContext context, Size size){
    
    
    return Column(
      children: [
        SizedBox(height: size.height*0.1,),
        _bienvenidaUsuario('${preferencias.nombreUsuario}'),
        Expanded(child: Container(),),
        _primerosTodos(context, size),
        
      ],
    );
  }



  Widget _backgroundHome(BuildContext context, Size size){
    
    return Container(
      height: size.height*0.7,
      width: double.infinity,
      color: Color.fromRGBO(63, 55, 201, 1.0),
    );
  }

  Widget _bienvenidaUsuario(String nombre){
    final date = new DateTime.now();
    return Container(
        child: Column(
          children: [
            Text(
              '¡Bienvenido $nombre!',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),
            SizedBox(height: 10.0,),
            Text(
              '${date.day}-${date.month}-${date.year}',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.white
              ),
            )
          ],
        ),
    );
  }
  
  Widget _primerosTodos(BuildContext context, Size size) {
    return Container(
      margin: EdgeInsets.only(top: size.height*0.17),
      
      width: double.infinity,
      height: size.height*0.50,
      child: Table(
        children: [
          TableRow(
            children: [
              _todoSeccion(context, Icons.home_work, 'Tareas escolares'),
              _todoSeccion(context, Icons.person, 'Personal')
            ]
          ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(25.0), topLeft: Radius.circular(25.0)),
        color: Colors.white
      ),
    );
  }

  Widget _vistaDos(BuildContext context){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 35.0),
      child: Table(
        children: [
          TableRow(
            children: [
              _todoSeccion(context, Icons.work, 'Trabajo'),
              _todoSeccion(context, Icons.emoji_emotions, 'Ideas')
            ]
          ),
          TableRow(
            children: [
              _todoSeccion(context, Icons.shopping_bag, 'Mercado'),
              _todoSeccion(context, Icons.date_range, 'Recordatorios')
            ]
          ),
        ],
      ),
    );
  }


  Widget _todoSeccion(BuildContext context, IconData icon, String titulo){
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 30.0),
        margin: EdgeInsets.only(top: 25.0 , left: 20.0, right: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          color: Color.fromRGBO(233, 236, 239, 1.0)
        ),
        child: Column(
          children: [
            SizedBox(height: 25.0,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              decoration: BoxDecoration(
                color: Color.fromRGBO(168, 218, 220, 1.0),
                borderRadius: BorderRadius.circular(100.0)
              ),
              child: Icon(
                icon,
                color: Color.fromRGBO(63, 55, 201, 1.0),
              ),
            ),
            SizedBox(height: 20.0,),
            Text(
              titulo,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(63, 55, 201, 1.0),
              ),
            ),
            SizedBox(height: 15.0,),
            Text(
              'Numero de items',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15.0,
              ),
            ),
            SizedBox(height: 25.0,),
          ],
        ),
      ),
      onTap: (){
        Navigator.pushNamed(context, 'todopage', arguments: titulo);
      },
    );
  }
}