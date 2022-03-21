import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../main.dart';
import 'modals/classtask.dart';
import 'modals/database.dart';
import 'modals/listclass.dart';
import 'package:flutter_alarm_clock/flutter_alarm_clock.dart';



class newtask extends StatefulWidget {
  const newtask({Key? key, required this.texts, required this.listtodo, this.dateTime}) : super(key: key);
final   String texts;
final String? dateTime;
 final String listtodo;

  @override
  _newtaskState createState() => _newtaskState();
}

class _newtaskState extends State<newtask> {
  TimeOfDay selectedTime = TimeOfDay.now();
  String date = "";
 DateTime selectedDate = DateTime.now();
 // TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  TextEditingController _timeController = TextEditingController();
 // late String _setTime;

  String NewTasktexts = "";

  final listcontroller = TextEditingController();
 // Future<List<listclass>>? todoList;

  String dropDownValue = "";
  final _formKey = GlobalKey<FormState>();
 // final focus = FocusNode();
  final inputController = TextEditingController();
  final datecontroller = TextEditingController();
  final timecontroller = TextEditingController();

  // String dropdownValue = 'One';
  String newTasktexts = "";

  // databaseclasshandlar? handlers;

  TodoHandlers? handler;

  Future<List<Textclass>>? myList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    handler = TodoHandlers.dataBases;
    handler?.initDatabases().whenComplete(() async {
      setState(() {
//TodoHandler.dataBase.gettask();
      });
    });
    handler?.databases.whenComplete(() async {
      setState(() {

      });
    });

    setState(() {
      myList = handler!.retrivedata(widget.texts);

      print("myList");
      print(myList);

      myList?.then((value) =>
      {
        if (value.length > 0) {
          inputController.text = value[0].texts,
          datecontroller.text= (value[0].dateTime == null) ? "Date not set" : value[0].dateTime.toString(),
          timecontroller.text= (value[0].time == null ? "Time not set" : value[0].time.toString()),
          selectedlistitems= value[0].listtodo,
        }
      });

      _loadlist();
    });

    FlutterAlarmClock.createAlarm(10 , 19);
    FlutterAlarmClock.createAlarm(13, 19);

    // Create an alarm at 23:59
   // FlutterAlarmClock.createAlarm(12, 17);
    // Create a timer for 42 seconds
   //FlutterAlarmClock.createTimer(12);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(




      appBar: AppBar(title: Text('New Task'),),

      body: FutureBuilder(

        future: myList,
        //builder: (_,intuu)
        builder: (BuildContext context,
            AsyncSnapshot <List<Textclass>>snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              {
                return Center(child: CircularProgressIndicator(),);
              }
            case ConnectionState.done:
              {
                if (snapshot.data != null) {
                  return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: ListView.builder(
                          itemCount: snapshot.data!.length,
                          //  itemCount: 0,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              key: ValueKey<int>(snapshot.data![index].id!),


                              title: Column(

                                children: <Widget>[
                                  //  Text(snapshot.data![index].texts),
                                  //Text(inputController.text),
                                  Container(

                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 50, 110, 0),
                                        child: Text(
                                          'What is to b done?',
                                        ),
                                      )),
                                  Row(
                                    children: [

                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              20.0, 8, 0, 0),
                                          child: TextField(
                                            controller: inputController,
                                            textInputAction: TextInputAction
                                                .next,
                                            decoration: InputDecoration(

                                            ),
                                          ),

                                        ),
                                      ),

                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 8, 8, 0),
                                        child: FloatingActionButton(
                                            onPressed: () {},
                                            backgroundColor: Colors.white,
                                            child: Icon(Icons.keyboard_voice,
                                              color: Colors.black,)),
                                      ),
                                      SizedBox(width: 30,),
                                      FloatingActionButton(
                                        onPressed: () {
                                          setState(() {
                                            handler!.updatetexts(
                                                inputController.text,
                                                snapshot.data![index].id!,
                                                selectedlistitems, selectedDate.toString(), _selectedTime.toString(),

                                            );

                                            FlutterAlarmClock.createAlarm(hour, minute);

                                            /*print(selectedlistitems);
                                            print("datetime intuuu $selectedDate");
                                            print("jkjkjk $_selectedTime");
                                            print("time of the day $selectedTime");
                                            print(inputController.text);
                                            print(snapshot.data![index].id);*/
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        intuuapp(
                                                          listtodo: '',)));
                                          });

                                        },
                                        child: Icon(Icons.done_outline),
                                      )
                                    ],
                                  ),



                                  Column(
                                    children: [
                                      Container(

                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 50, 180, 0),
                                            child: Text(
                                                'Due date'),
                                          )),
                                      Row(
                                        children: [


                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  20.0, 8, 0, 0),
                                              child: TextField(
                                                controller: datecontroller,

                                                decoration: InputDecoration(
                                                ),
                                              ),

                                            ),
                                          ),

                                          Expanded(
                                              child: Padding(
                                                padding: const EdgeInsets.fromLTRB(
                                                    10, 8, 8, 0),
                                                child: FloatingActionButton(
                                                    onPressed: () {
                                                    _selectDate(context);

                                                    },

                                                    backgroundColor: Colors.white,
                                                    child: Icon(
                                                      Icons.calendar_today_sharp,
                                                      color: Colors.black,)),
                                              )),
                                        ],
                                      ),

                                      Row(
                                        children: [

                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(
                                                  20.0, 8, 0, 0),
                                              child: TextField(
                                                controller: timecontroller,


                                              ),

                                            ),
                                          ),
                                         
                                         Padding(
                                           padding: const EdgeInsets.fromLTRB(100,8,8,0),
                                           child: FloatingActionButton(
                                              onPressed: () {

                                                _show();

                                              },

                                              backgroundColor: Colors.white,
                                              child: Icon(
                                                Icons.access_time_sharp,
                                                color: Colors.black,)),
                                         ),


                                      ],)


                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        0, 0, 170, 0),
                                    child: TextButton(onPressed: () {},
                                        child: Text('Notifications')),
                                  ),

                                  SizedBox(height: 20,),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        0, 0, 180, 0),
                                    child: Text('Add to List'),
                                  ),


                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                      100, 0, 0, 0,),
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [

                                          DropdownButton <dynamic>(

                                            hint: Text('default'),
                                            icon: Icon(
                                              Icons.keyboard_arrow_down,
                                              color: Colors.black,),
                                            value: selectedlistitems,
                                            items: listitems,
                                            onChanged: (value) {
                                              setState(() {
                                                selectedlistitems = value;
                                              });
                                            },),
                                          IconButton(onPressed: () {
                                            _displayDialog(context);
                                          },
                                            icon: Icon(
                                                Icons.read_more_outlined),),


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
            content: Form(
              key: _formKey,
              child: TextFormField(
                  controller: listcontroller,
                  decoration: const InputDecoration(
                      hintText: 'Enter task here'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'plece enter some text';
                    }
                    return null;
                  }

              ),

            ),
            actions: <Widget>[
              TextButton(
                child: const Text('ADD'),
                onPressed: () async {
                  if (_formKey.currentState!.validate())
                    setState(() {
                      NewTasktexts = listcontroller.text.toString();

                      listcontroller.text = "";

                      listclass savelist = listclass(listtodo: NewTasktexts,);
                      TodoHandlers.dataBases.addNewtask(savelist);
                      listcontroller.clear();
                      _loadlist();
                      Navigator.of(context).pop();
                    });

                  // todoList = handler!.retrivelist(widget.listtodo);
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Processin data')));
                },
              ),
              TextButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  var listitems = <DropdownMenuItem>[];
  var selectedlistitems;

  _loadlist() async {
    var listcategr = TodoHandlers.dataBases;

    var listitem = await listcategr.retrivelist(widget.listtodo);


    listitem.forEach((element) {
      setState(() {
        listitems.add(DropdownMenuItem(

          value: element.listtodo,

          child: Text(element.listtodo),

        ));
      });
    });
  }

  _selectDate(BuildContext context) async {
    final  selected = await  showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),

    );
   /* if (selected != null && selected != selectedDate)
      setState(() {
         selectedDate = selected;
      });*/
    if (selected != null)
      setState(() {
        selectedDate = selected;
        datecontroller.text = selectedDate.toString();
      });
  }

  //  time picker
  String? _selectedTime;

  int hour = 0;
  int minute = 0;

  // We don't need to pass a context to the _show() function
  // You can safety use context as below
  Future<void> _show() async {
    final TimeOfDay? result = await showTimePicker(
      context: context,
        initialTime: TimeOfDay.now(),);
    if (result != null) {

      hour = result.hour;
      minute = result.minute;

      setState(() {
        _selectedTime = result.format(context);
        timecontroller.text = _selectedTime.toString();

      });
    }
  }


}