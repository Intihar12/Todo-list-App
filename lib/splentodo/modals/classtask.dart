

import 'listclass.dart';

class Textclass{
  int? id;
  final String texts;
final String? dateTime;
final String? time;
 // final DateTime dateTime;
  final String? listtodo;

  Textclass({ this.id, required this.texts, this.listtodo, this.dateTime, this.time});

  Textclass.fromMap(Map<String, dynamic>res):
        id= res ['id'],
        texts= res['texts'],
        dateTime =res ['creationDates'],
  time=res['creationTime'],
  listtodo=res['listtodo'];

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'texts':texts,
     'creationDates':dateTime.toString(),
      'creationTime': time.toString(),
         'listtodo':listtodo
    };

  }
}




