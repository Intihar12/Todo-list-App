import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_app/Todo_list/todo_list.dart';
import 'package:sqflite_app/Todo_user/homepage.dart';
import 'package:sqflite_app/my_Todo/maiin.dart';

import 'package:authentication/intuu.dart';
import 'package:sqflite_app/splentodo/maiiin.dart';

void main(){runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
  home: MyApp()

));}

class  MyApp extends StatelessWidget {
  const  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MyHompage()));
              }, child: Text("TOdo user data")),
              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>App()));
              }, child: Text("Todo list ")),



              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>todoapp()));
              }, child: Text("My To_Do ")),


              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>intuuapp()));
              }, child: Text("SplenTodo "))
            ],
          ),
        ),
      ),



    );
  }
}
