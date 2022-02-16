

class titleclass{
 final int? id;
  late final String titles;

  titleclass({ this.id, required this.titles});

  titleclass.fromMap(Map<String, dynamic>res):
      id= res ['id'],
      titles= res['titles'];



  Map<String, Object?> toMap(){

    return{
        'id': id,
      'titles': titles
    };

  }
}