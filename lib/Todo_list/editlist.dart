import 'package:flutter/material.dart';
import 'package:sqflite_app/Todo_list/modal/databaseclass.dart';

import 'modal/titleclass.dart';

class updatedata extends StatefulWidget {
  const updatedata({Key? key, required this.titles}) : super(key: key);
final String titles;
  @override
  _updatedataState createState() => _updatedataState();
}

class _updatedataState extends State<updatedata> {
  databaseclass? handler;
  final TextEditingController _textFieldController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    handler= databaseclass();
    handler!.dataseHandler().whenComplete(() async{setState(() {

    });});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text('LIST '),),


      body: FutureBuilder(
      future: handler!.retrivesinlelist(widget.titles,),

        builder: (BuildContext context, AsyncSnapshot <List<titleclass>> snapshot){
        if(snapshot.hasData){
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (BuildContext context, int index){
              return ListTile(
                key: ValueKey<String> (snapshot.data![index].titles),
                title: Column(children: [
                  Text(snapshot.data![index].titles)
                ],),

                subtitle: Column(children: [
                  TextField(
                    controller: _textFieldController,
                    decoration: InputDecoration(
                      hintText: snapshot.data![index].titles
                    ),
                  ),
                  TextButton(onPressed: (){
                    handler!.updatelist(_textFieldController.text,  snapshot.data![index].id!);

                  }, child: Text('update'))
                ],),
              );
            },

          );
        }
          return Center(child: CircularProgressIndicator(),);
      },),
    );
  }
}
