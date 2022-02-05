import 'package:flutter/material.dart';

class User{
 final int? id;
 final String name;
 final String email;
 final String password;

  User({this.id, required this.name, required this.email, required this.password});

  User.fromMap(Map<String , dynamic>intuu) :
    id= intuu["id"],
    name= intuu["name"],
    email= intuu["email"],
    password=intuu["password"];


  Map<String, Object?> toMap(){
    return{
      'id':id,
      'name':name,
    'email':email,
    'password':password

    };
  }
}