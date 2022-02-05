import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'modal/modal.dart';


class SqlLiteData{

  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'users.db'),
      onCreate: (database, version) async {
        await database.execute("CREATE TABLE users(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT NOT NULL, email TEXT NOT NULL, password TEXT NOT NULL)",
        );
      },
      version: 1,
    );
  }

  Future<String?> insertuser(User user)async{
    final Database db = await initializeDB();
   await db.insert('users', user.toMap());
  }

  Future<List<User>> retriveuser(String id, String name, String email, )async{
final Database db =await initializeDB();
List<Map<String, Object?>> list=await db.rawQuery('SELECT * FROM users WHERE id =? ', [id]);
return list.map((e) => User.fromMap(e)).toList();
  }

  Future<List<User>> retriveallusers(String name, String email, String password)async{
    final Database db = await initializeDB();
   final List<Map<String, Object?>> listusers= await db.query('users');
   return listusers.map((e) => User.fromMap(e)).toList();
  }

  Future<int?> deletedata(int id)async{
    final Database db = await initializeDB();
    await db.rawDelete('DELETE FROM users WHERE id=? ',[id]);
  }
  void updatedata(String name, String email, String password, String id )async{
    final Database db=await initializeDB();

    db.rawUpdate('Update users SET name = ? , email = ? , password = ?, id = ?', [name, email,password, id]);
  }
}