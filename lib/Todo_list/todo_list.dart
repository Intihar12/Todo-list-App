import 'package:flutter/material.dart';

import 'editlist.dart';
import 'modal/databaseclass.dart';
import 'modal/titleclass.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'To-Do List', home: TodoList());
  }
}

class TodoList extends StatefulWidget {

  //const TodoList({Key? key, required this.titles}) : super(key: key);
    String titles="";
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {

  //final List<String> _todoList = <String>[];
  final TextEditingController _textFieldController = TextEditingController();
  databaseclass? handler;

  Future<List<titleclass>>? todoList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    handler= databaseclass();

    handler!.dataseHandler().whenComplete(() async{
      setState(() {
        todoList = handler!.retrivelist(widget.titles);
      });
    });


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('To-Do List')),
        body:// ListView(children: _getItems()),
        FutureBuilder(
          future: handler!.retrivelist(widget.titles),

          builder: (BuildContext context, AsyncSnapshot <List<titleclass>> snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index){
                  return  Card(

                    child: ListTile(
                      key: ValueKey<int>(snapshot.data![index].id!),
                        title: Column(children: [
                        Text(snapshot.data![index].titles),

                        TextButton(onPressed: (){
                          handler!.deletedata(snapshot.data![index].id!);


                        }, child: Text('delete')),
                        TextButton(onPressed: (){

                          Navigator.push(context, MaterialPageRoute(builder: (context)=>updatedata(
                              titles: snapshot.data![index].id.toString(),
                          )),);



                        }, child: Text('Edit'))
                      ],),
                    ),
                  );

                },

              );
            }
            return Center(child: CircularProgressIndicator(),);
          },),


    floatingActionButton: FloatingActionButton(
    onPressed: () => _displayDialog(context),
    //tooltip: 'Add Item',
    child: Icon(Icons.add)),


    );
  }


/*void _addTodoItem(String title) {
  // Wrapping it inside a set state will notify
  // the app that the state has changed
  setState(() {
    _todoList.add(title);
  });
  _textFieldController.clear();
}*/

// Generate list of item widgets
/*Widget _buildTodoItem(String title) {
  return ListTile(title: Text(title));
}*/

// Generate a single item widget
Future<Future> _displayDialog(BuildContext context) async {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a task to your list'),
          content: TextField(
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: 'Enter task here'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ADD'),
              onPressed: () async {
             //   Navigator.push(context, MaterialPageRoute(builder: (context)=>showlist(titles: _textFieldController.text)));
               // _addTodoItem(_textFieldController.text);
                Navigator.of(context).pop();
                titleclass savelist = titleclass(titles: _textFieldController.text);
               await handler!.insertlist(savelist);
                _textFieldController.clear();
                todoList = handler!.retrivelist(widget.titles);

              },
            ),
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      });
}

/*List<Widget> _getItems() {
  final List<Widget> _todoWidgets = <Widget>[];
  for (String title in _todoList) {
    _todoWidgets.add(_buildTodoItem(title));
  }
  return _todoWidgets;
}*/
}