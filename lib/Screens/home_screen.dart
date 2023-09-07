import 'package:contactlist/Custom/appbar.dart';
import 'package:contactlist/Custom/custombutton.dart';
import 'package:contactlist/Custom/textfield.dart';
import 'package:contactlist/Helpers/database_helper.dart';
import 'package:contactlist/Model/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Helpers/provider.dart';
import 'contact_form.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHalper.opendb();
    contact = dbHalper.loadContact();
  }

  final dbHalper = DatabaseHelper();
  TextEditingController namecontroller= TextEditingController();
  TextEditingController phonecontroller= TextEditingController();
  final elevendigit = RegExp(r'^\d{0,11}$');
  late Future<List<CONTACT>> contact;

  @override
  Widget build(BuildContext context) {
    final contactprovider = Provider.of<Providerr>(context, listen: false);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: CustomAppBar(
          title: 'Contact list',
          elevation: 5,
          barcolor: Colors.redAccent,
          centretitle: true,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextField(
                  hintext: "Name", controller: namecontroller, inputType: TextInputType.name,
              ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomTextField(
                hintext: "Phone No.", controller: phonecontroller, inputType: TextInputType.number,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomButton(
                  onpressed: (){
                    final name = namecontroller.text;
                    final number = phonecontroller.text;
                    if(name.isNotEmpty && number.isNotEmpty){
                      final newContact = CONTACT(
                          id: DateTime.now().microsecondsSinceEpoch,
                          name: name,
                          number: number,
                      );
                      contactprovider.insertContact(newContact);
                      setState(() {
                        namecontroller.clear();
                        phonecontroller.clear();

                      });
                    };
                  },
                  childtext: 'Save',
                bgcolor: Colors.redAccent,
              ),
            ],
          ),
          Consumer<Providerr>(
            builder: (context, value, child){
              return Expanded(
                  child: FutureBuilder<List<CONTACT>>(
                    future: dbHalper.loadContact(),
                    builder: (context, snapshot){
                      if(snapshot.connectionState == ConnectionState.waiting){
                        return const Center(child: CircularProgressIndicator());
                      }
                      else if(!snapshot.hasData || snapshot.data!.isEmpty){
                        return const Text("No Contact yet");
                      }
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index){
                            final contact = snapshot.data![index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                tileColor: Colors.yellow.withOpacity(0.1),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    side: const BorderSide(
                                  color: Colors.red,
                                  width: 1
                                )),
                                leading: const Icon(Icons.person, color:  Colors.orangeAccent,size: 30),
                                title: Text(contact.name),
                                subtitle: Text(contact.number),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(onPressed: (){
                                      _showeditDialog(contact);
                                    }, icon: Icon(Icons.edit,color: Colors.blueAccent.shade700,)),
                                    IconButton(onPressed: (){
                                      value.deleteContact(contact.id);
                                      snapshot.data!.removeAt(index);
                                    }, icon: Icon(Icons.delete,color: Colors.red,)),
                                  ],
                                ),
                              ),
                            );
                          }
                      );
                    },
                  )
              );
            },
          )

        ],
      ),
    );
  }
  void _showeditDialog(CONTACT contact){
    showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("Edit Contact"),
            content: ContactForm(
              contact: contact,
              onSave: (contact)async{
                await dbHalper.updateContact(contact.toMap() as CONTACT);
                dbHalper.loadContact();
                Navigator.pop(context);
              },
            ),
          );
        }
    );
  }
}
