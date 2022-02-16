

class Textclass{
  int? id;
  final String texts;
  final DateTime dateTime;

  Textclass({ this.id, required this.texts,required this.dateTime});

  Textclass.fromMap(Map<String, dynamic>res):
        id= res ['id'],
        texts= res['texts'],
         dateTime =res ['creationDates']

         ;

  Map<String, dynamic> toMap(){
    return {
      'id':id,
      'texts':texts,
      'creationDates':dateTime.toString()
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
