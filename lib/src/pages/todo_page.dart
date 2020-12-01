import 'package:flutter/material.dart';
import 'package:todolist/src/bloc/todo_bloc.dart';
import 'package:todolist/src/model/todo_model.dart';


class ToDoPage extends StatefulWidget {
  
  @override
  _ToDoPageState createState() => _ToDoPageState();
}

class _ToDoPageState extends State<ToDoPage> {
  
  // List<String> tempTodos = ['Comprar carne', 'Comprar azucar', 'Comprar azucar', 'Comprar azucar', 'Comprar azucar', 'Comprar azucar', 'Comprar azucar', 'Comprar azucar', 'Comprar azucar', 'Comprar azucar',];
  String toDoValor = '';
  bool agregar = false;
  bool _guardando = false;
  ToDoModel toDoModel = new ToDoModel();

  final formKey = GlobalKey<FormState>();
  final toDosBloc = new ToDoBloc();



  
  @override
  Widget build(BuildContext context) {
    
    toDosBloc.cargarToDos();

    final size = MediaQuery.of(context).size;
    final String args = ModalRoute.of(context).settings.arguments;
    

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            children: [
              _tituloToDo(args, size),
              _intercambio(size),
            ],
          ),
      ),
      floatingActionButton: FloatingActionButton(
        
        child: Icon(
          Icons.add
        ),
        backgroundColor: Color.fromRGBO(63, 55, 201, 1.0),
        onPressed: (){
          setState(() {
            this.agregar = !this.agregar;
          });
        },
      ),
    );
  }

  Widget _tituloToDo(String titulo, Size size){
    
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: size.height*0.15,
        color: Color.fromRGBO(63, 55, 201, 1.0),
        child: Center(
          child: Text(
            '$titulo',
            style: TextStyle(
              fontSize: 30.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }


 


  Widget _agregarToDo(Size size){
    return Container(
      width: size.width*0.85,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            SizedBox(height: 30.0,),
            _crearCampoToDo(),
            _crearBotonGuardar(),
          ],
        ),
      ),
    );
  }


  Widget _intercambio(Size size){
    return this.agregar?this._agregarToDo(size):this._todosStreamWidget(size);
    // return this.agregar?this._agregarToDo(size):this._listaTodos();
  }
  
  Widget _crearCampoToDo(){


    return TextFormField(
      initialValue: this.toDoValor,
      decoration: InputDecoration(
        labelText: 'Tarea por hacer'
      ),
      onSaved: (String value){
        this.toDoValor = value;
        this.toDoModel.todo = value;
        this.toDoModel.tipo = 'escolar';
        this.toDoModel.success = false;
      },
      validator: (String valor){
        if(valor.length > 3){
          return null;
        }else{
          return 'Tiene que tener mas de 5 caracteres';
        }

      },
    );
  }

  Widget _crearBotonGuardar(){
    return Container(
      margin: EdgeInsets.only(top: 30.0),
      child: RaisedButton.icon(
        icon: Icon(Icons.save),
        label: Text('Agregar'),
        onPressed: () async {
          if(!formKey.currentState.validate()) return;
          formKey.currentState.save();

          this.toDosBloc.agregarToDo(toDoModel);

          setState(() {
            // this.tempTodos.add(this.toDoValor);
            this.toDoValor = '';
            this.agregar = !this.agregar;
          });




        },
      ),
    );
  }

  Widget _todosStreamWidget(Size size){
    
    return Container(
      height: size.height*0.79,
      child: StreamBuilder(
        stream: toDosBloc.toDosStream,
        builder: (BuildContext context, AsyncSnapshot<List<ToDoModel>> snapShot){
          
          final data = snapShot.data;

          if(snapShot.hasData){
            
            
            
            return ListView.builder(
              itemCount: data.length,
              shrinkWrap: true,
              itemBuilder: (BuildContext context, int i){
                return this._itemToDo(data[i].todo, data[i].id);
              },
            );
          }else{
            
            return Center(
              heightFactor: 10.0,
              child: CircularProgressIndicator()
            );
          }

        }
      ),
    );



  }
  
   Widget _itemToDo(String descripcion, String id){
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
      ),
      child: ListTile(
        title: Text('$descripcion'),
      ),
      onDismissed: (DismissDirection direccion){
        this.toDosBloc.borrarProducto(id);
      },
    );
  }

  
}

