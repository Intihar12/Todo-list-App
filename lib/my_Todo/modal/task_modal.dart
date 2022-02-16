

class Task{
   int? id;
  final String task;
  final DateTime datetime;

  Task({ this.id, required this.task,required this.datetime});
/*
  Task.fromMap(Map<String, dynamic>res):
        id= res ['id'],
        task= res['titles'],
datetime= res['creationData'];*/

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'task':task,
      'creationDate':datetime.toString()
    };

  }
}



/*class DateTime implements Comparable<DateTime> {
  // Weekday constants that are returned by [weekday] method:
  static const int monday = 1;
  static const int tuesday = 2;
  static const int wednesday = 3;
  static const int thursday = 4;
  static const int friday = 5;
  static const int saturday = 6;
  static const int sunday = 7;
  static const int daysPerWeek = 7;

  @override
  int compareTo(DateTime other) {
    // TODO: implement compareTo
    throw UnimplementedError();
  }

}*/
