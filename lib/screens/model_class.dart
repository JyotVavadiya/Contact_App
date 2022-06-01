import 'dart:io';

class Contact{
  String? firstname;
  String? lastname;
  String? phone;
  String? email;
  File? image;

  Contact({
    this.firstname,
    this.lastname,
    this.phone,
    this.email,
    this.image,
  });
}



List<Contact> contacts = <Contact>[];