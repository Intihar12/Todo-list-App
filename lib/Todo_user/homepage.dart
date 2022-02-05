//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_app/Todo_user/creatdatabase.dart';
import 'package:sqflite_app/Todo_user/modal/modal.dart';
import 'package:sqflite_app/Todo_user/showdata.dart';

class MyHompage extends StatefulWidget {
  const MyHompage({Key? key}) : super(key: key);

  @override
  _MyHompageState createState() => _MyHompageState();
}

class _MyHompageState extends State<MyHompage> {
 SqlLiteData? handler;

 final namecontroller= TextEditingController();
  final emailcontroller= TextEditingController();
  final passwordcontroller= TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    handler = SqlLiteData();

    handler!.initializeDB().whenComplete(() async {
      setState(() {

    });});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sqflite"),backgroundColor: Colors.teal,
      ),

      body: SingleChildScrollView(

        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(

              children: [
                Card(
                  child: TextField(
                     controller: namecontroller,
                    decoration: InputDecoration(
                      hintText: 'name',

                   ),
                  ),
                ),

                 Card(
                   child: TextField(
controller: emailcontroller,
                    decoration: InputDecoration(
                      hintText: 'email',


                    ),
                ),
                 ),
                Card(
                  child: TextField(
                    controller: passwordcontroller,
                    decoration: InputDecoration(
                      hintText: 'password',

                    ),
                  ),
                ),
        TextButton(
            onPressed: ()async{
          User Myuser = User(name: namecontroller.text, email: emailcontroller.text, password: passwordcontroller.text);
             await  handler!.insertuser(Myuser);
print('output .. ${namecontroller.text}');
        }, child: Text("submit")),

                TextButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>showdata(
                    name: namecontroller.text, email: emailcontroller.text,password: passwordcontroller.text,)));

                },
                    child: Text('Showdata'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
