import 'package:shared_preferences/shared_preferences.dart';


class PreferenciasUsuario{
  static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();

  
  
  factory PreferenciasUsuario(){
    // return _instancia!=null?_instancia:;
    return _instancia;
  }

  PreferenciasUsuario._internal();
  
  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  get nombreUsuario {
    return _prefs.getString('nombreusuario')??'';
  }

  set nombreUsuario(String nombreUsuario) {
    _prefs.setString('nombreusuario', nombreUsuario);
  }

  get routeName {
    return _prefs.getString('routename')??'home';
  }

  set routeName(String routeName) {
    _prefs.setString('routename', routeName);
  }


}