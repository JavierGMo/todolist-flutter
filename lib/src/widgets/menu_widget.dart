import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Container(
              width: double.infinity,
              height: 30.0,
              color: Colors.blueAccent,
            )
          ),

          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: (){
              Navigator.pushReplacementNamed(context, 'home');
            },
          ),

          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Configuraciones'),
            onTap: (){
              Navigator.pushReplacementNamed(context, 'settings');
            },
          ),
        ],
      ),
    );
  }
}