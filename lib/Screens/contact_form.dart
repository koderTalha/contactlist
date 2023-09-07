import 'package:contactlist/Custom/custombutton.dart';
import 'package:contactlist/Custom/textfield.dart';
import 'package:flutter/material.dart';
import 'package:contactlist/Model/contact_model.dart';

class ContactForm extends StatefulWidget {
  final CONTACT? contact;
  final Function(CONTACT) onSave;
  const ContactForm({
    this.contact,
    required this.onSave
  });
  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  late TextEditingController _namecontroller;
  late TextEditingController _phonecontroller;

  @override
  void initState() {
    _namecontroller = TextEditingController(text: widget.contact?.name??'',);
    _phonecontroller = TextEditingController(text: widget.contact?.number??'',);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTextField(hintext: "Name", controller: _namecontroller, inputType: TextInputType.name),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomTextField(hintext: "Phone No.", controller: _phonecontroller, inputType: TextInputType.name),
        ),
        const SizedBox(height: 10,),
        CustomButton(onpressed: (){
          final name = _namecontroller.text;
          final number  = _phonecontroller.text;
          final contact = CONTACT(
              id: widget.contact?.id ?? 0,
              name: name,
              number: number,
          );
          widget.onSave(contact);
          Navigator.pop(context);
        }, childtext: "Save"),
      ],
    );
  }
  void dispose(){
    _namecontroller.dispose();
    _phonecontroller.dispose();
  }

}
