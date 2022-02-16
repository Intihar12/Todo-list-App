
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_app/Todo_list/modal/titleclass.dart';
class databaseclass{

  Future <Database> dataseHandler() async{
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'listsave.db'),
      onCreate: (database, version)async{

      await  database.execute("CREATE TABLE listsave( id INTEGER PRIMARY KEY AUTOINCREMENT, titles TEXT NOT NULL)"
      );
      },
     version: 1,
    );

  }

  Future<int?> insertlist(titleclass intuu)async{
    final db= await dataseHandler();
    await db.insert('listsave', intuu.toMap());
  }

  Future<List<titleclass>> retrivesinlelist(String id)async{
    final db=await dataseHandler();
    List<Map<String, Object?>> singlelist= await db.rawQuery('SELECT * FROM listsave WHERE id=?', [id]);
return singlelist.map((e) => titleclass.fromMap(e)).toList();
  }
  Future<List<titleclass>> retrivelist(String titles)async{
    final db= await dataseHandler();
   final List<Map<String, Object?>> data= await db.query('listsave');
   return data.map((e) => titleclass.fromMap(e)).toList();
  }

  Future<int?> deletedata(int id)async{
    final db= await dataseHandler();
    await db.rawDelete('DELETE FROM listsave WHERE id=?', [id]);
  }

  void updatelist(String titles, int id)async{
 final db= await dataseHandler();

 db.rawUpdate('UPDATE listsave SET  titles=? WHERE id=?', [titles, id]);

  }

}