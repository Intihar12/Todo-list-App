import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

import 'package:sqflite_app/splentodo/newtask.dart';

import 'splentodo/modals/classtask.dart';
import 'splentodo/modals/database.dart';
import 'splentodo/modals/listclass.dart';

void main(){runApp(
  MaterialApp(

  home: mypage(),));}

class mypage extends StatelessWidget {
  const mypage({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: intuuapp(listtodo: '',),
    );
  }
}




class intuuapp extends StatefulWidget {
  const intuuapp({Key? key,required  this.listtodo }) : super(key: key);

  final String listtodo;
  @override
  _intuuappState createState() => _intuuappState();
}

class _intuuappState extends State<intuuapp> {

  final _formKey = GlobalKey<FormState>();
 // final focus = FocusNode();
//late  VoidCallback? press;
  TextEditingController inputcontroller= TextEditingController();
  Color maincolor = Color(0xFF0d0952);
  Color secondcolor = Color(0xFF212061);
  Color btncolor = Color(0xFFff955b);
  Color editcolor = Color(0xFF4044cc);
  String newTasktexts ="";
 // Database? database;

TodoHandlers? handler;

  Future<List<Textclass>>? searchusers;



  void _runFilter(String enteredKeyword) {
   //Future<List<Textclass>> results ;
   //List<Map<String, dynamic>> results = [];


    // Refresh the UI
    setState(() {
      searchusers = handler!.getSearchData(enteredKeyword);
    });
  }



  @override
void initState() {
  // TODO: implement initState
  super.initState();

print("back???");


  handler= TodoHandlers.dataBases;

  handler!.initDatabases().whenComplete(() async{
    setState(() {
//TodoHandler.dataBase.gettask();

      searchusers = handler!.getdata();

    });
  });

}




  Icon actionIcon = new Icon(Icons.search);
  Widget appBarTitle = new Text("All List");
 // String dropdownValue = 'Delete';

  String listtodo = "";
String texts = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 70),
        child: FloatingActionButton(
backgroundColor: Colors.white,
          onPressed: (){
           Navigator.push(context, MaterialPageRoute(builder: (context)=> newtask(texts: texts, listtodo: listtodo,)));
          },child: Icon(Icons.add, color: Colors.black,),
        ),
      ),



      appBar: AppBar(
        centerTitle: true,
        title:appBarTitle,


       /* leading: IconButton(onPressed:(){

        },
          icon: Icon (Icons.done),

        ),*/




      //  title: Text('All listis'),
        automaticallyImplyLeading: false,
      actions: [




        IconButton(icon: actionIcon,
            onPressed: (){

              if(this.actionIcon.icon == Icons.close){
                setState(() {
                  searchusers = handler!.getdata();
                });
              }

          print(this.actionIcon.icon);
              setState(() {

                if ( this.actionIcon.icon == Icons.search){
                 this.actionIcon = new Icon(Icons.close);

                 if(this.actionIcon == Icons.close){

                   setState(() {
                     searchusers = handler!.getdata();
                   });
                 }

                  this.appBarTitle = new TextField(
                    style: new TextStyle(
                      color: Colors.black,
                    backgroundColor: Colors.white
                    ),
                    decoration: new InputDecoration(

                       // prefixIcon: new Icon(Icons.search,color: Colors.white),
                        hintText: "Search...",
                        hintStyle: new TextStyle(color: Colors.black)
                    ),

                   onChanged: (value) => _runFilter(value),

                  );}
                else {
                   this.actionIcon = new Icon(Icons.search);
                  this.appBarTitle = new Text("Todo List");
                }


              });
            }, //icon: Icon(Icons.search,),
        ),


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
            child: FutureBuilder(
             // future: getTasks(),

              future: searchusers,//handler!.getdata(),
              // builder: (_, taskData)
                builder: (BuildContext context,AsyncSnapshot <List<Textclass>> snapshot)       {
                switch (snapshot.connectionState){
                  case ConnectionState.waiting:
                    {
                      return Center(child:  CircularProgressIndicator(),);
                    }
                  case ConnectionState.done:
                    {

                      print("snapshot.data");
                      print(snapshot.data);

                      if(snapshot.data != null){

                        return Padding(
                          padding: EdgeInsets.all(8.0),
                          child:  ListView.builder (
                              itemCount: snapshot.data!.length,
                              // itemCount: 0,
                              itemBuilder: (BuildContext context ,int index){
                                String task = snapshot.data![index].texts.toString();
                                String list = (snapshot.data![index].listtodo == null) ? "" : snapshot.data![index].listtodo.toString();
                           //     String day = DateFormat('yyyy-MMMM-dd   hh:mm a').format(DateTime.now());
                              //  String day = snapshot.data![index].dateTime;
                                String times= (snapshot.data![index].time == null) ? "" : snapshot.data![index].time.toString();
                                String day= (snapshot.data![index].dateTime == null) ? "" : snapshot.data![index].dateTime.toString();


                                return Dismissible(

                                    direction: DismissDirection.endToStart,
                                    background: Container(
                                      //color: secondcolor,

                                       color: Colors.red,
                                     alignment: Alignment.centerRight,
                                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Icon(Icons.delete_forever, color: Colors.white,),
                                    ),

                                    key: ValueKey<int>(snapshot.data![index].id!),
                                    onDismissed: (DismissDirection direction) async {
                                      await this.handler!.deletedata(snapshot.data![index].id!);
                                      setState(() {
                                        snapshot.data!.remove(snapshot.data![index]);
                                      });
                                    },


                                //  DateTime.jm().format(DateTime("hh:mm:ss").parse("14:15:00"))

                                child:  Card(
                                  color: secondcolor,

                                  child: InkWell (
                    onTap: () {
                     //inputcontroller.text=texts
                     // taskData.data[index]['id'].toString();
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                    builder: (context) => newtask(texts: snapshot.data![index].id.toString(),
                      listtodo: snapshot.data![index].id.toString(), ),
                     // listtodo: snapshot.data![index].id.toString(), dateTime: days, ),
                    ),);},
                                    child: Container(

                                      margin: EdgeInsets.only(right: 5.0),
                                      padding: EdgeInsets.all(12.0),
                                      decoration: BoxDecoration(
                                        //color:  Colors.red,
                                        borderRadius: BorderRadius.circular(8.0),
                                      ),


                                      child: Column(

                                        children:[


                                          Text(
                                            task,

                                            style: TextStyle(fontSize: 20, color: Colors.white),),
                                              SizedBox(height: 5,),

                                          Text(list,
                                              style: TextStyle(color: Colors.white)),


                                            Text(day, style: TextStyle(
                                                    color: Colors.teal, fontSize: 10.0, fontWeight: FontWeight.bold),),

                                         Text(times,style: TextStyle(
                                              color: Colors.teal, fontSize: 10.0, fontWeight: FontWeight.bold),)

                                              ]
                                              ),

                                    ),

                                  ),
                                )
                                );

                              }

                          ),
                        );
                      }
                        return Center(child: Text('you have no task today', style: TextStyle(color: Colors.white),),);

                    }
                }
                return Center(child: CircularProgressIndicator(),);
              },
            ),
          ),

          Container(


            padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 18.0),

            decoration: BoxDecoration(
                color: editcolor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                )
            ),


            child: Form(
              key: _formKey,
              child: Row(
                children: [


                  Expanded(

                    child: TextFormField(

                      textInputAction: TextInputAction.next,
                      controller: inputcontroller,
                      decoration: InputDecoration(filled: true,
                        hintText: 'type a new task',
                        fillColor: Colors.white,

                        // focusedBorder: InputBorder.none
                      ),

    validator: (value) {
    if (value == null || value.isEmpty) {
    return 'Please enter some text';
    }

    return null;
    },
                    ),),
                  SizedBox(width: 15.0,),

                  TextButton.icon(
                      style:  TextButton.styleFrom(backgroundColor: btncolor, shape: StadiumBorder(), ),
                      onPressed: (){

    if (_formKey.currentState!.validate()) {
      setState(() {
        newTasktexts= inputcontroller.text.toString();

        inputcontroller.text="";
/*
        Textclass newtaskst = Textclass(texts: newTasktexts, dateTime: DateFormat('yyyy-MMMM-dd   hh:mm a').format(DateTime.now()), );
*/
        Textclass newtaskst = Textclass(texts: newTasktexts, );

        TodoHandlers.dataBases.insertdata(  newtaskst );
      });

      ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Processing Data')),
    );}



                       //Textclass newtaskst = Textclass(texts: newTasktexts, dateTime: DateTime.now() );
                       print("i am here ${newTasktexts}, ${DateTime.now()}");
                      },



                      label: Text('Add task',style: TextStyle(color: Colors.white),),
                      icon: Icon(Icons.add, color: Colors.white,)),



                ],),
            ),


          ),


        ],),

    );
  }

}


