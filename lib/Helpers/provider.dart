import 'package:flutter/foundation.dart';
import 'database_helper.dart';
import 'package:contactlist/Model/contact_model.dart';

class Providerr extends ChangeNotifier{
  final dbhelper = DatabaseHelper();
  late Future<List<CONTACT>> contact;

  Providerr(){
    loadfetchcontact();
  }

  void loadfetchcontact()async{
    await dbhelper.opendb();
    contact = dbhelper.loadContact();
    notifyListeners();
  }

   Future<void> insertContact(CONTACT newContact)async{
    await dbhelper.insertContact(newContact);
    notifyListeners();
   }

   Future<void> updateContact(CONTACT newContact)async{
    await dbhelper.updateContact(newContact);
    notifyListeners();
   }

   Future<void> deleteContact(int id )async{
    await dbhelper.deleteContact(id);
    notifyListeners();
   }
}