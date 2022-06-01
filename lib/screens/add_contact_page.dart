import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'model_class.dart';
import 'dart:io';

class addcontect extends StatefulWidget {
  const addcontect({Key? key}) : super(key: key);

  @override
  _addcontectState createState() => _addcontectState();
}

class _addcontectState extends State<addcontect> {

  final ImagePicker _picker = ImagePicker();
  File? _image;

  final GlobalKey<FormState> _addContactFormKey = GlobalKey<FormState>();

  final TextEditingController _firstnamecontroller = TextEditingController();
  final TextEditingController _lastnamecontroller = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();

  String? firstname;
  String? lastname;
  String? phone;
  String? email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,

        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,

          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          "Add",

        ),
        actions: [
          IconButton(
            onPressed: validateandsubmit,
            icon: Icon(
              Icons.check,

            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: BouncingScrollPhysics(),
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(height: 30),
              Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    child: (_image == null)
                        ? const Text(
                      "Add",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    )
                        : Container(),
                    backgroundColor: Colors.grey.shade400,
                    backgroundImage: (_image != null) ? FileImage(_image!) : null,
                  ),
                  (_image == null)
                      ? Align(
                    alignment: Alignment(0.2,0.1),
                    child: InkWell(
                      onTap: () async {
                        XFile? xfile = await _picker.pickImage(
                            source: ImageSource.gallery);
                        String path = xfile!.path;
                        File file = File(path);
                        setState(() {
                          _image = file;
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                      : Container(),
                ],
              ),
              SizedBox(height: 50),
              Form(
                key: _addContactFormKey,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 250),
                      child: const Text(
                        "First Name",
                        style: TextStyle(

                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: 20, right: 20, bottom: 20, top: 8),
                      child: TextFormField(
                        controller: _firstnamecontroller,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Please Enter your First Name';
                          }
                          return null;
                        },
                        onSaved: (val) {
                          setState(() {
                            firstname = val;
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 250),
                      child: const Text(
                        "Last Name",
                        style: TextStyle(

                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: 20, right: 20, bottom: 20, top: 8),
                      child: TextFormField(
                        controller: _lastnamecontroller,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Please Enter your Last Name';
                          }
                          return null;
                        },
                        onSaved: (val) {
                          setState(() {
                            lastname = val;
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 215),
                      child: const Text(
                        "Phone Number",
                        style: TextStyle(

                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: 20, right: 20, bottom: 20, top: 8),
                      child: TextFormField(
                        controller: _phonecontroller,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Please Enter your phone number';
                          } else if (val.length != 10) {
                            return 'Enter valid length';
                          }
                          return null;
                        },
                        onSaved: (val) {
                          setState(() {
                            phone = val;
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 300),
                      child: const Text(
                        "Email",
                        style: TextStyle(

                            fontSize: 20,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: 20, right: 20, bottom: 20, top: 8),
                      child: TextFormField(
                        controller: _emailcontroller,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Please Enter your Email';
                          }
                          return null;
                        },
                        onSaved: (val) {
                          setState(() {
                            email = val;
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  validateandsubmit() {
    if (_addContactFormKey.currentState!.validate()) {
      _addContactFormKey.currentState!.save();

      Contact myContact = Contact(
        firstname: firstname,
        lastname: lastname,
        phone: phone,
        email: email,
        image: _image,
      );

      contacts.add(myContact);

      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
    }
  }
}