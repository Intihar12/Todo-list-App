
import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'classtask.dart';
import 'listclass.dart';

class TodoHandlers{
static const _databaseName = 'ContactData.db';
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
    Directory getDatabasesPath = await getApplicationDocumentsDirectory();
    print('data directory:  ${ getDatabasesPath.path}');
    return await openDatabase(
        join(await getDatabasesPath.path, _databaseName),
        onCreate: (db,  version)async{

          await  db.execute("CREATE TABLE todolist( id INTEGER PRIMARY KEY AUTOINCREMENT, listtodo TEXT NOT NULL)"
          );


          await db.execute('''CREATE TABLE seplando(id INTEGER PRIMARY KEY AUTOINCREMENT,
           texts TEXT NOT NULL,  creationDates , creationTime,
             listtodo TEXT)''');

        },
        version: 1

    );
  }


  addNewtask(listclass newtask)async{
    final db =await initDatabases();
    await db.insert('todolist', newtask.toMap(),
      //     conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  insertdata(Textclass newtask,  ) async{
    final db= await initDatabases();
final result =  db.rawInsert("INSERT INTO seplando (texts) VALUES(?)",[ newtask.texts ,  ]);
return result;

  }


 void  updatetexts(String texts,  int id, String selectedlistitems ,String selectedDate ,String _selectedTime)async {
    final db = await initDatabases();
     db.rawUpdate(' UPDATE seplando SET texts = ? , listtodo = ? ,creationDates = ?, creationTime = ? WHERE id =? ', [texts,selectedlistitems, selectedDate, _selectedTime, id,  ]);
 //   print("selectedlistitems = " + selectedlistitems);

  }


        Future<List<listclass>> retrivelist(String listtodo)async{
          final db= await initDatabases();
          final List<Map<String, Object?>> data= await db.query('todolist');
          return data.map((e) => listclass.fromMap(e)).toList();
        }


        //KSDFJKDJFDK

  Future<List<Textclass>> getdata()async{
    final db= await initDatabases();
    // var res= await db.query("todolist");

    final List<Map<String, Object?>> listusers= await db.query('seplando');

    print("listusers");
    print(listusers);

    return listusers.map((e) => Textclass.fromMap(e)).toList();

  }

Future<List<Textclass>> getSearchData(String search)async{
  final db= await initDatabases();
  // var res= await db.query("todolist");

   // creationDates
   //    listtodo
  // final  List<Map<String, Object?>> listusers=await db.rawQuery('SELECT * FROM seplando WHERE texts LIKE "%?%" ', [search]);
  final  List<Map<String, Object?>> listusers = await db.query(
      "seplando",
      where: "texts LIKE ?",
      whereArgs: ['%$search%']
  );

  print("listusers");
  print(listusers);

  return listusers.map((e) => Textclass.fromMap(e)).toList();

}


  Future<List<Textclass>> retrivedata(String id)async {
    final db = await initDatabases();
    final  List<Map<String, Object?>> list=await db.rawQuery('SELECT * FROM seplando WHERE id =? ', [id]);
    return list.map((e) => Textclass.fromMap(e)).toList();
  }


  Future<int?> deletedata(int id)async{
    final Database db = await initDatabases();
    await db.rawDelete('DELETE FROM seplando WHERE id=? ',[id]);
  }
}

