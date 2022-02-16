

class listclass{
  final int? id;
   final String listtodo;

  listclass({ this.id, required this.listtodo});

  listclass.fromMap(Map<String, dynamic>res):
        id= res ['id'],
        listtodo= res['listtodo'];



  Map<String, Object?> toMap(){

    return{
      'id': id,
      'listtodo': listtodo
    };

  }
}