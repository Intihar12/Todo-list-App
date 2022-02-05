import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite_app/Todo_user/creatdatabase.dart';
import 'package:sqflite_app/Todo_user/modal/modal.dart';
import 'package:sqflite_app/Todo_user/update.dart';


class showdata extends StatefulWidget {
  const showdata({Key? key,required this.name, required this.email, required this.password}) : super(key: key);
final String name;
final String email;
final String password;
  @override
  _showdataState createState() => _showdataState();
}

class _showdataState extends State<showdata> {


  SqlLiteData? handler;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    handler= SqlLiteData();
    handler!.initializeDB().whenComplete(() async{setState(() {

    });});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(title:  Text('showdata'),),
      body: FutureBuilder(

future: handler!.retriveallusers(  widget.name,widget.email,widget.password, ),
        builder: (BuildContext context, AsyncSnapshot<List<User>> snapshot) {
if(snapshot.hasData) {
  return ListView.builder(
    itemCount: snapshot.data?.length,
    itemBuilder: (BuildContext context, int index) {
      return Card(
        child: ListTile(
            key: ValueKey<int>(snapshot.data![index].id!),
            contentPadding: EdgeInsets.all(8.0),
            title: Column(


              children: [
              Text(snapshot.data![index].name),
SizedBox(height: 10,),
              Text(snapshot.data![index].email),
                SizedBox(height: 10,),
              Text(snapshot.data![index].password)
            ],),

          subtitle: Column(
            children: [

              TextButton(onPressed: (){

                handler!.deletedata(snapshot.data![index].id ?? 0);
              }, child: Text('Delete')),

              TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>updateData(
                  name: snapshot.data![index].id.toString(), email: snapshot.data![index].id.toString() ,password: snapshot.data![index].id.toString(),


                )));
              },

                  child: Text('Edite'))
            ],
          ),
        ),
      );
    },
  );}
  return Center(child: CircularProgressIndicator());
},



      ) );
  }
}
