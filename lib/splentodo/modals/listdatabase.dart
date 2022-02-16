
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'listclass.dart';
class databaseclasshandlar{

  Future <Database> databaseHandler() async{
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'listsave.db'),
      onCreate: (database, version)async{

        await  database.execute("CREATE TABLE todolist( id INTEGER PRIMARY KEY AUTOINCREMENT, listtodo TEXT NOT NULL)"
        );
      },
      version: 1,
    );

  }

  Future<int?> insertlist(listclass intuu)async{
    final db= await databaseHandler();
    await db.insert('todolist', intuu.toMap());
  }

  Future<List<listclass>> retrivesinlelist(String id)async{
    final db=await databaseHandler();
    List<Map<String, Object?>> singlelist= await db.rawQuery('SELECT * FROM todolist WHERE id=?', [id]);
    return singlelist.map((e) => listclass.fromMap(e)).toList();
  }
  Future<List<listclass>> retrivelist(String listtodo)async{
    final db= await databaseHandler();
    final List<Map<String, Object?>> data= await db.query('todolist');
    return data.map((e) => listclass.fromMap(e)).toList();
  }

  Future<int?> deletedata(int id)async{
    final db= await databaseHandler();
    await db.rawDelete('DELETE FROM todolist WHERE id=?', [id]);
  }

  void updatelist(String listtodo, int id)async{
    final db= await databaseHandler();

    db.rawUpdate('UPDATE todolist SET  titles=? WHERE id=?', [listtodo, id]);

  }

}