import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite_app/my_Todo/db/db_provider.dart';
import 'package:sqflite_app/splentodo/newtask.dart';

import 'modals/classtask.dart';
import 'modals/database.dart';

void main(){runApp(intuuapp(),);}

class intuuapp extends StatefulWidget {
  const intuuapp({Key? key}) : super(key: key);

  @override
  _intuuappState createState() => _intuuappState();
}

class _intuuappState extends State<intuuapp> {
  final focus = FocusNode();
late  VoidCallback? press;
  TextEditingController inputcontroller= TextEditingController();
  Color maincolor = Color(0xFF0d0952);
  Color secondcolor = Color(0xFF212061);
  Color btncolor = Color(0xFFff955b);
  Color editcolor = Color(0xFF4044cc);
  String newTasktexts ="";



TodoHandler? handler;


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
}


  getTasks()async{
    final tasks=await TodoHandlers.dataBases.gettask();
    print(tasks);
    return tasks;
  }

  Icon actionIcon = new Icon(Icons.search);
  Widget appBarTitle = new Text("Todo List");
  String dropdownValue = 'Delete';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 70),
        child: FloatingActionButton(
backgroundColor: Colors.white,
          onPressed: (){
           Navigator.push(context, MaterialPageRoute(builder: (context)=> newtask(texts: dropdownValue,dateTime: dropdownValue,)));
          },child: Icon(Icons.add, color: Colors.black,),
        ),
      ),



      appBar: AppBar(
        centerTitle: true,
        title:appBarTitle,
        leading: IconButton(onPressed:(){

        },icon: Icon (Icons.done),

        ),

      //  title: Text('All listis'),
        automaticallyImplyLeading: false,
      actions: [
        IconButton(icon: actionIcon,
            onPressed: (){
              setState(() {

                if ( this.actionIcon.icon == Icons.search){
                  this.actionIcon = new Icon(Icons.close);
                  this.appBarTitle = new TextField(
                    style: new TextStyle(
                      color: Colors.black,
                    backgroundColor: Colors.white
                    ),
                    decoration: new InputDecoration(

                        prefixIcon: new Icon(Icons.search,color: Colors.white),
                        hintText: "Search...",
                        hintStyle: new TextStyle(color: Colors.black)
                    ),
                  );}
                else {
                  this.actionIcon = new Icon(Icons.search);
                  this.appBarTitle = new Text("Todo List");
                }

              });
            }, //icon: Icon(Icons.search,),
        ),

/*Drawer(

),
  */
       /* DropdownButton(

            items: <String>['Delete', 'Share', 'Edit', ].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (_) {},
            icon: const Icon(Icons.more_vert),

        //}, icon: Icon(Icons.more_vert))
          )*/


    IconButton(onPressed: (){

      ListTile(
        //leading: Icon(Icons.exit_to_app),
        title: Text('Delete'),
      );

    }, icon: Icon(Icons.more_vert)



    )

     ] ),

      body: Column(
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

                                String task= taskData.data[index]['texts'].toString();

                            //    String day = DateTime.now().toString();
                             //  String day = DateFormat('hh:mm a').format(DateTime.now());
                                String days = DateFormat('yyyy-MMMM-dd   hh:mm a').format(DateTime.now());

                                //  DateTime.jm().format(DateTime("hh:mm:ss").parse("14:15:00"))

                                return Card(
                                  color: secondcolor,

                                  child: InkWell (
                    onTap: () {
                     //inputcontroller.text=texts
                     // taskData.data[index]['id'].toString();
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => newtask(texts: taskData.data[index]['id'].toString(), dateTime: days, ),
                    ),);},
                                    child: Container(
                                      margin: EdgeInsets.only(right: 12.0),
                                      padding: EdgeInsets.all(12.0),
                                      decoration: BoxDecoration(
                                        //color:  Colors.red,
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),
                                      child: Column(

                                        children:[

                                          Text(
                                            task, style: TextStyle(fontSize: 20, color: Colors.white),),
                                              SizedBox(height: 5,),
                                          /*   Text(day, style: TextStyle(
                                                    color: Colors.teal, fontSize: 10.0, fontWeight: FontWeight.bold),),*/
                                          Text(days, style: TextStyle(
                                              color: Colors.teal, fontSize: 10.0, fontWeight: FontWeight.bold),),

                                              ]
                                              ),
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
         // ElevatedButton.icon(onPressed: (){},icon: Icon(Icons.add), label: Text(''), ),
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
                    textInputAction: TextInputAction.next,
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
                        newTasktexts= inputcontroller.text.toString();

                        inputcontroller.text="";
                      });
                      Textclass newtaskst = Textclass(texts: newTasktexts, dateTime: DateTime.now(), );

                      TodoHandlers.dataBases.addNewtask(newtaskst);
                    },

                    label: Text('Add task',style: TextStyle(color: Colors.white),),
                    icon: Icon(Icons.add, color: Colors.white,)),



              ],),


          ),


        ],),

    );
  }
}
