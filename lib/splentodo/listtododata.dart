/*
import 'package:flutter/material.dart';

import 'modals/listclass.dart';
import 'modals/listdatabase.dart';

class listttt extends StatefulWidget {
  const listttt({Key? key, required this.listtodo}) : super(key: key);
final String listtodo;
  @override
  _listtttState createState() => _listtttState();
}

class _listtttState extends State<listttt> {

  databaseclasshandlar? handlers;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    handlers=databaseclasshandlar();
    handlers!.databaseHandler().whenComplete(() async{
      setState(() {

      });

    });
    }


  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('djskjd'),),

        body:  FutureBuilder(
    //   future: handler!.retriveuser(widget.text),

    future: handlers!.retrivesinlelist(widget.listtodo),
    builder: (BuildContext context, AsyncSnapshot <List<listclass>> snapshot) {

    if (snapshot.hasData) {
    return ListView.builder(
    itemCount: snapshot.data!.length,
    itemBuilder: (context, index) {
    return ListTile(
    key: ValueKey<int>(snapshot.data![index].id!),
       title: Column(
         children: [
           Text(snapshot.data![index].listtodo)
         ],
       )

    );
  }
    );
    }

    return Center(child: CircularProgressIndicator(),);

    } )
    );
    }
  }*/
