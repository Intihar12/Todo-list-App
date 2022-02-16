
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'classtask.dart';

class TodoHandlers{

  TodoHandlers._();

  static final TodoHandlers dataBases = TodoHandlers._();
  static  Database? _databases;

  Future<Database?> get databases async{
    if(_databases != null){
      return _databases;
    }
    _databases=await initDatabases();
    return _databases;
  }

  initDatabases()async{
    return await openDatabase(
        join(await getDatabasesPath(), 'todo_appp_db.db'),
        onCreate: (db,  version)async{
          await db.execute('''CREATE TABLE seplando(id INTEGER PRIMARY KEY AUTOINCREMENT, texts TEXT NOT NULL, creationDates TEXT NOT NULL )''');
        },
        version: 1

    );
  }

  addNewtask(Textclass newtask)async{
    final db =await databases;
   await  db!.insert('seplando', newtask.toMap(),
   //     conflictAlgorithm: ConflictAlgorithm.replace
   );
  }

  Future<dynamic> gettask()async{
    final db= await databases;
    var res= await db!.query("seplando");
    if(res.length == 0){
      return Null;
    }else{
      var resultMap = res.toList();
      return resultMap.isNotEmpty ? resultMap : Null;
    }}

    Future<dynamic> retriveuser(String id)async {
      final db = await databases;
      var res = await db!.rawQuery('SELECT * FROM seplando WHERE id =? ', [id]);
      if (res.length == 0) {
        return Null;
      } else {
        var resultMap = res.toList();
        return resultMap.isNotEmpty ? resultMap : Null;
      }
    }
      Future<dynamic> updatetexts(String texts,int id)async {
        final db = await databases;
        var res = await db!.rawQuery(' UPDATE seplando SET texts=?  WHERE id =? ', [texts,id]);
        if (res.length == 0) {
          return Null;
        } else {
          var resultMap = res.toList();
          return resultMap.isNotEmpty ? resultMap : Null;
        }





/* Future<List<Textclass>?> retriveuser(String id, )async{
    final  db =await  databases;
    List<Map<String, Object?>>? list=await db?.rawQuery('SELECT * FROM seplando WHERE id =? ', [id]);
    return list?.map((e) => Textclass.fromMap(e)).toList();
  }*/

/*
 Future<List<Task>> gettask()async{
   final db= await database;
   final List<Map<String, Object?>> data= await db.query('tasks');
   return data.map((e) => Task.fromMap(e)).toList();
 }
*/


    }
}