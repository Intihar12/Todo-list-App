import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_app/my_Todo/modal/task_modal.dart';

class TodoHandler{

 TodoHandler._();

static final TodoHandler dataBase = TodoHandler._();
  static  Database? _database;

Future<Database?> get database async{
  if(_database != null){
    return _database;
  }
  _database=await initDatabase();
  return _database;
}

initDatabase()async{
  return await openDatabase(
    join(await getDatabasesPath(), 'todo_app_db.db'),
    onCreate: (db,  version)async{
     await db.execute('''CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, task TEXT NOT NULL, creationDate TEXT NOT NULL )''');
    },
      version: 1

  );
}

addNewtask(Task newtask)async{
  final db =await database;
  await db!.insert('tasks', newtask.toMap(),
  conflictAlgorithm: ConflictAlgorithm.replace);
}

Future<dynamic> gettask()async{
  final db= await database;
  var res= await db!.query("tasks");
  if(res.length == 0){
    return Null;
  }else{
    var resultMap = res.toList();
    return resultMap.isNotEmpty ? resultMap : Null;
  }
}

/*
 Future<List<Task>> gettask()async{
   final db= await database;
   final List<Map<String, Object?>> data= await db.query('tasks');
   return data.map((e) => Task.fromMap(e)).toList();
 }
*/


}