//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_app/my_Todo/db/db_provider.dart';
import 'package:sqflite_app/my_Todo/db/db_provider.dart';

import 'db/db_provider.dart';
import 'db/db_provider.dart';
import 'modal/task_modal.dart';
import 'package:intl/intl.dart';

void main(){runApp(MaterialApp(



  home: todoapp(),
));
}
class todoapp extends StatefulWidget {
  const todoapp({Key? key}) : super(key: key);

  @override
  _todoappState createState() => _todoappState();
}

class _todoappState extends State<todoapp> {
TextEditingController inputcontroller= TextEditingController();
  Color maincolor = Color(0xFF0d0952);
  Color secondcolor = Color(0xFF212061);
  Color btncolor = Color(0xFFff955b);
  Color editcolor = Color(0xFF4044cc);
String newTasktext ="";






 /*TodoHandler? handler;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

   handler= TodoHandler.dataBase;

       handler!.initDatabase().whenComplete(() async{
      setState(() {
//TodoHandler.dataBase.gettask();
      });
    });
      handler!.database.whenComplete(() async{
         setState(() {

         });
       });
  }*/

  getTasks()async{
    final tasks=await TodoHandler.dataBase.gettask();
    print(tasks);
    return tasks;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: maincolor,
      appBar: AppBar(
        backgroundColor: maincolor,
        title:  Text('My To_Do!'),),

      body:  Column(
        
        children: [
          Expanded(
            child: FutureBuilder<dynamic>(
            future: getTasks(),
            builder: (_, taskData){
              switch (taskData.connectionState){
                case ConnectionState.waiting:
                  {
                  return Center(child:  CircularProgressIndicator(),);
                }
                case ConnectionState.done:
                  {
                 if(taskData.data != null){
                   return Padding(
                     padding: EdgeInsets.all(8.0),
                     child:  ListView.builder(
                    itemCount: taskData.data.length,
                         itemBuilder: (context , index){


                               //  Text( taskData.data![index]['task'].toString())

                             String task= taskData.data[index]['task'].toString();

                             String day = DateTime.parse(taskData.data[index]['creationDate']).toString();


                               return Card(
                                 color: secondcolor,
                                 child: InkWell(
                                   child: Row(
                                     children: [
                                       Expanded(
                                         child: Container(
                                           margin: EdgeInsets.only(right: 12.0),
                                           padding: EdgeInsets.all(12.0),
                                           decoration: BoxDecoration(
                                             color:  Colors.red,
                                             borderRadius: BorderRadius.circular(8.0),
                                           ),
                                           child: Text(day, style: TextStyle(color: Colors.white, fontSize: 15.0, fontWeight: FontWeight.bold),),
                                         ),
                                       ),
                                       Expanded(
                                           child: Text(
                                             task, style: TextStyle(fontSize: 16, color: Colors.white),))
                                     ],
                                   ),
                                 ),
                               );

                          /* String task= snapshot.data![index].task.toString();
                           String day = DateTime.parse(snapshot.data![index]["creationData"]).day.toString();
*/
                         }
                         ),
                   );
                 }else{
                   return Center(child: Text('you have no task today', style: TextStyle(color: Colors.white),),);
                 }
                }
              }
              return Center(child: CircularProgressIndicator(),);
            },
          ),),
          Container(
          padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 18.0),

          decoration: BoxDecoration(
            color: editcolor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            )
          ),
          child: Row(
            children: [
            Expanded(
              child: TextField(
                controller: inputcontroller,
                decoration: InputDecoration(filled: true,
                hintText: 'type a new task',
                fillColor: Colors.white,
               // focusedBorder: InputBorder.none
                ),


              ),),
            SizedBox(width: 15.0,),

            TextButton.icon(
              style:  TextButton.styleFrom(backgroundColor: btncolor, shape: StadiumBorder(), ),
                onPressed: (){
                setState(() {
                  newTasktext= inputcontroller.text.toString();

                  inputcontroller.text="";
                });
Task newtasks = Task(task: newTasktext, datetime: DateTime.now(), );

TodoHandler.dataBase.addNewtask(newtasks);
                },

                label: Text('Add task',style: TextStyle(color: Colors.white),),
                icon: Icon(Icons.add, color: Colors.white,))
          ],),
        )
      ],),
    );
  }
}

