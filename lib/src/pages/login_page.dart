import 'package:flutter/material.dart';
import 'package:todolist/src/preferencias_usuario/preferencias_usuario.dart';

class LoginPAge extends StatelessWidget {
  
  final formKey = GlobalKey<FormState>();
  final preferencias = new PreferenciasUsuario();
  final Map<String, String>loginCampos = {'user' : ''};

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          _fondo(size),
          _form(context, size)
        ],
      ),
    );
  }

  Widget _fondo(Size size) {
    return Container(
      width: double.infinity,
      child: Container(
        height: size.height*0.5,
        color: Color.fromRGBO(63, 55, 201, 1.0),
      ),
    );
  }

  
  Widget _form(BuildContext context, Size size) {
    return SingleChildScrollView(
      
      child: Column(
        children: [
          Container(
            height: size.height*0.55,
            margin: EdgeInsets.symmetric(vertical: size.height*0.25, horizontal: size.width*0.07),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 10,
                  offset: Offset(1, 1)
                ),
              ]
            ),
            child: Form(
              key: formKey,
              child: Column(
                children: [

                  SizedBox(height: 30.0,),
                  _titulo(),
                  SizedBox(height: 30.0,),
                  _campoNombre(),
                  Expanded(child: Container()),
                  _btnEntrar(context),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _titulo(){
    return Container(
      child: Text(
        'Ingresa con tu nombre',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0
        ),
      ),
    );
  }

  Widget _campoNombre() {
    return Container(
      margin: EdgeInsets.only(top: 30.0),
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: TextFormField(
        initialValue: '',
        decoration: InputDecoration(
          labelText: 'Nombre de usuario'
        ),
        validator: (String value){
          if(value.length<5){
            return 'Tu usuario debe de llevar mas de cinco caracteres';
          }else{
            return null;
          }
        },
        onSaved: (String value){
          print('VAlor - $value');
          this.loginCampos['user'] = value;
        },
      ),
    );
  }

  Widget _btnEntrar(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 30.0),
      child: RaisedButton.icon(
        
        icon: Icon(Icons.person, color: Colors.white),
        label: Text('Entrar', style: TextStyle(color: Colors.white),),
        color: Color.fromRGBO(63, 55, 201, 1.0),
        onPressed: (){
          if(!formKey.currentState.validate())return;

          formKey.currentState.save();
          this.preferencias.nombreUsuario = this.loginCampos['user'];
          this.preferencias.routeName = 'home';
          Navigator.pushReplacementNamed(context, 'home');

        }
      ),
    );
  }
}