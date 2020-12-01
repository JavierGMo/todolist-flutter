import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:todolist/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:todolist/src/widgets/menu_widget.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  final prefs = new PreferenciasUsuario();
  String nombre = '';
  TextEditingController _textController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nombre = prefs.nombreUsuario;
    _textController = new TextEditingController(text: prefs.nombreUsuario);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        backgroundColor: Color.fromRGBO(63, 55, 201, 1.0),
        elevation: 0.0,
      ),
      drawer: MenuWidget(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                  labelText: 'Nuevo nombre',
                  helperText: 'Escribe tu nuevo nombre',
                  prefix: Icon(
                    Icons.person,
                    color: Color.fromRGBO(63, 55, 201, 1.0),
                  )
                ),
                onChanged: (String value){
                  nombre = value;
                },
              ),
            ),
            SizedBox(height: 50.0,),
            Container(
              width: 220.0,
              child: RaisedButton.icon(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)
                ),
                color: Color.fromRGBO(63, 55, 201, 1.0),
                elevation: 0.0,
                icon: Icon(
                  Icons.save,
                  color: Colors.white,
                ),
                label: Text(
                  'Guardar',
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
                onPressed: (){
                  prefs.nombreUsuario = nombre;
                  print('Pendejos');
                  showDialog(
                    context: context,
                    builder: (BuildContext context){
                      return _alerta(context);
                    }
                  );
                  
                }
              ),
            )
          ],
        ),
      ),
    );
  } //Build

  Widget _alerta(BuildContext context){
    print('Pendjos 2');
    return AlertDialog(
      title: Text('Tu nombre se ha cambiado con exito'),
      content: Text('¿Regresar a los ToDos?'),
      actions: [
        FlatButton(
          child: Text('Si'),
          textColor: Colors.greenAccent,
          onPressed: (){
            Navigator.pushReplacementNamed(context, 'home');

          },
        ),
        FlatButton(
          child: Text('No'),
          textColor: Colors.redAccent,
          onPressed: (){
            Navigator.of(context).pop();
          },
        )
      ],
    );
  }

  



}