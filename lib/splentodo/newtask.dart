import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'listtododata.dart';
import 'maiiin.dart';
import 'modals/classtask.dart';
import 'modals/database.dart';
import 'modals/listclass.dart';
import 'modals/listdatabase.dart';

class newtask extends StatefulWidget {
  const newtask({Key? key, required this.texts, required this.dateTime}) : super(key: key);
final   String texts;
final String dateTime;
 final String listtodo="";
  @override
  _newtaskState createState() => _newtaskState();
}

class _newtaskState extends State<newtask> {

  final listcontroller= TextEditingController();
  Future<List<listclass>>? todoList;

  String dropDownValue="";


  final focus = FocusNode();
  final inputController = TextEditingController();
  final datecontroller= TextEditingController();
  final listcontrollers = TextEditingController();
 // String dropdownValue = 'One';
  String newTasktexts ="";
  databaseclasshandlar? handlers;

  TodoHandlers? handler;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
handlers=databaseclasshandlar();
    handler= TodoHandlers.dataBases;

    handlers!.databaseHandler().whenComplete(() async{
      setState(() {

      });
    });

    handler!.initDatabases().whenComplete(() async{
      setState(() {
//TodoHandler.dataBase.gettask();
      });
    });
    handler!.databases.whenComplete(() async{
      setState(() {

      });
    });
  }

  retriveusers()async{
    final tasks=await TodoHandlers.dataBases.retriveuser(widget.texts);
    print(tasks);
    return tasks;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

       /* floatingActionButton: FloatingActionButton(
          onPressed: (){

          //  handler!.updatetexts(inputController.text,  );

          },
         child:  Icon(Icons.done_outline)

        ),*/


        appBar: AppBar(title:  Text('New Task'),),

    body: FutureBuilder<dynamic>(
   //   future: handler!.retriveuser(widget.text),

    future: retriveusers(),
      builder: (_,intuu) {
        switch (intuu.connectionState) {
          case ConnectionState.waiting:
            {
              return Center(child: CircularProgressIndicator(),);
            }
          case ConnectionState.done:
            {
              if (intuu.data != null) {
                return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: ListView.builder(
                        itemCount: intuu.data.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            key: ValueKey<int>(intuu.data[index]['id']),


/*title: Column(
  children: [
    Text(intuu.data[index]['text'].toString())
  ],
),*/




                       title: Column(

       children:<Widget> [
         //Text(intuu.data[index]['texts'].toString()),
          //Text(inputController.text),
Container(

      child: Padding(
       padding: const EdgeInsets.fromLTRB(0,50,110,0),
       child: Text(
           'What is to b done?'),
      )),
             Row(
               children: [
                 //Text(intuu.data[index]['texts'].toString()),
                 Expanded(
                   child: Padding(
                     padding: const EdgeInsets.fromLTRB(20.0,8,0,0),
                     child: TextField(
                       controller: inputController,
                       textInputAction: TextInputAction.next,
                       decoration: InputDecoration(
                       //  labelText: 'What is to be done?',
                         hintText: intuu.data[index]['texts'].toString(),
                       ),
                     ),

                   ),
                 ),

                 Expanded(
                     child: Padding(
                       padding: const EdgeInsets.fromLTRB(100,8,8,0),
                       child: FloatingActionButton
                         (onPressed:() {},backgroundColor: Colors.white, child: Icon(Icons.keyboard_voice, color: Colors.black,)),
                     )),
SizedBox(width: 30,),
                 FloatingActionButton(onPressed: (){

                   setState(() {
                     handler!.updatetexts(inputController.text, intuu.data[index]['id']);

                     Navigator.push(context, MaterialPageRoute(builder: (context)=>intuuapp()));
                   });

                  // handler!.updatetexts(inputController.text, intuu.data[index]['id']);

                 }, child: Icon(Icons.done_outline),)
               ],
             ),


         Container(

             child: Padding(
               padding: const EdgeInsets.fromLTRB(0,50,180,0),
               child: Text(
                   'Due date'),
             )),
Row(
  children: [
      Expanded(
       child: Padding(
         padding: const EdgeInsets.fromLTRB(20.0,8,0,0),
         child: TextFormField(

           textInputAction: TextInputAction.next,
           controller:  datecontroller,
           decoration: InputDecoration(
           //  labelText: 'Due Date?',
             hintText: 'due date',
           ),
         ),
       ),
      ),

      Expanded(
         child: Padding(
           padding: const EdgeInsets.fromLTRB(100,8,8,0),
           child: FloatingActionButton(
               onPressed:() {
                 _displayDialog(context);
                // Navigator.push(context, MaterialPageRoute(builder: (context)=>listtododata()));
              //   _displayDialog(context);

               }, backgroundColor: Colors.white,
               child:  Icon(Icons.calendar_today_sharp,color:  Colors.black,)),
         )),
  ],
),
         Padding(
           padding: const EdgeInsets.fromLTRB(0,0,170,0),
           child: TextButton(onPressed: (){}, child: Text('Notifications')),
         ),

         SizedBox(height: 20,),
         Padding(
           padding: const EdgeInsets.fromLTRB(0,0,180,0),
           child: Text('Add to List'),
         ),



          Padding(
            padding: const EdgeInsets.fromLTRB(100,0,0,0,),
            child: Container(
              child: Row(children: [


                IconButton(onPressed: (){
                  _displayDialogsj(context);
                }, icon: Icon(Icons.arrow_drop_down_circle)),




                IconButton(onPressed: (){
                  _displayDialogs(context);
                }, icon: Icon(Icons.arrow_drop_down_sharp)),

                IconButton(onPressed: (){

                  _displayDialog(context);
                },icon: Icon(Icons.read_more_outlined),),


              ],),
            ),
          )


       ],
         ),


                          );
                        }
                    ));
              }
              return Center(child: CircularProgressIndicator(),);
            }
        }
        return Center(child: CircularProgressIndicator(),);
      },






      ),

    );
  }



  Future<Future> _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add a task to your list'),
            content: TextField(
              controller: listcontroller,
              decoration: const InputDecoration(hintText: 'Enter task here'),
            ),
            actions: <Widget>[
              TextButton(
                child: const Text('ADD'),
                onPressed: () async {
                //  Navigator.push(context, MaterialPageRoute(builder: (context)=>showlist()));
                  // _addTodoItem(_textFieldController.text);
              //    Navigator.of(context).pop();
                  listclass savelist = listclass(listtodo: listcontroller.text);
                  await handlers!.insertlist(savelist);
                  listcontroller.clear();
                  todoList = handlers!.retrivelist(widget.listtodo);

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



  Future<Future> _displayDialogs(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: Container(
                height: 200,
        width: 100,
        child:  FutureBuilder(
          future: handlers!.retrivelist(widget.listtodo),

          builder: (BuildContext context, AsyncSnapshot <List<listclass>> snapshot){

          if(snapshot.hasData){
          return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (BuildContext context, int index){
          return
          //key: ValueKey<int>(snapshot.data![index].id!),

          InkWell(
            onTap: (){

              Navigator.push(context, MaterialPageRoute(builder: (context)=> listttt(listtodo: snapshot.data![index].id.toString(),)));
            },

              child: Text(
                snapshot.data![index].listtodo, style: TextStyle(fontSize: 20),));
          },

          );
          }
          return Center(child: CircularProgressIndicator(),);
          },
          )
              )

          );
        });
  }


  Future<FutureBuilder<List<listclass>>> _displayDialogsj(BuildContext context) async {
   return  FutureBuilder(
                    future: handlers!.retrivelist(widget.listtodo),

                    builder: (BuildContext context, AsyncSnapshot <List<listclass>> snapshot) {
                     return snapshot.hasData ?
                         Container(
                          child: DropdownButton<String>(
                             // icon:  Icon(Icons.keyboard_arrow_down, color: Colors.black,),
                             // hint:  Text(dropDownValue),

                            items: snapshot.data!.map(( item) {
                              return DropdownMenuItem(
                                value: item.listtodo,
                                child: Text(item.listtodo),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                dropDownValue = value!;
                                print(value);
                              });
                            }


                          ),
                        )
                    : Container(child:  Text('Loading'),);

                      //return Center(child: CircularProgressIndicator(),);
                      }



          );

  }

}
