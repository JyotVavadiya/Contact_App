import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'model_class.dart';
import 'dart:io';

class edit extends StatefulWidget {
  const edit({Key? key}) : super(key: key);

  @override
  _editState createState() => _editState();
}

class _editState extends State<edit> {
  final ImagePicker _picker = ImagePicker();
  File? _image;

  final GlobalKey<FormState> _editContactFormKey = GlobalKey<FormState>();

  final TextEditingController _editfirstnamecontroller = TextEditingController();
  final TextEditingController _editlastnamecontroller = TextEditingController();
  final TextEditingController _editphonecontroller = TextEditingController();
  final TextEditingController _editemailcontroller = TextEditingController();

  String? ufirstname;
  String? ulastname;
  String? uphone;
  String? uemail;

  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context)!.settings.arguments;

    // _editfirstnamecontroller.text = args.firstname;
    // _editlastnamecontroller.text = args.lastname;
    // _editphonecontroller.text = args.phone;
    // _editemailcontroller.text = args.email;

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
          "Edit",
        ),
        actions: [
          IconButton(
            onPressed: () {
              return validateandsubmit(args);
            },
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
                    backgroundImage:
                        (_image != null) ? FileImage(_image!) : null,
                  ),
                  (_image == null)
                      ? Align(
                          alignment: Alignment(0.2, 0.1),
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
                key: _editContactFormKey,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 250),
                      child: const Text(
                        "First Name",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: 20, right: 20, bottom: 20, top: 8),
                      child: TextFormField(
                        controller: _editfirstnamecontroller,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Please Enter your First Name';
                          }
                          return null;
                        },
                        onSaved: (val) {
                          setState(() {
                            ufirstname = val;
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "${args.firstname}"
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 250),
                      child: const Text(
                        "Last Name",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: 20, right: 20, bottom: 20, top: 8),
                      child: TextFormField(
                        controller: _editlastnamecontroller,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Please Enter your Last Name';
                          }
                          return null;
                        },
                        onSaved: (val) {
                          setState(() {
                            ulastname = val;
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "${args.lastname}",
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 215),
                      child: const Text(
                        "Phone Number",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: 20, right: 20, bottom: 20, top: 8),
                      child: TextFormField(
                        controller: _editphonecontroller,
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
                            uphone = val;
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "${args.phone}",
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 300),
                      child: const Text(
                        "Email",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w400),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          left: 20, right: 20, bottom: 20, top: 8),
                      child: TextFormField(
                        controller: _editemailcontroller,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'Please Enter your Email';
                          }
                          return null;
                        },
                        onSaved: (val) {
                          setState(() {
                            uemail = val;
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "${args.email}"
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

  validateandsubmit(args) {
    if (_editContactFormKey.currentState!.validate()) {
      _editContactFormKey.currentState!.save();

      Contact myContact = Contact(
        firstname: ufirstname,
        lastname: ulastname,
        phone: uphone,
        email: uemail,
        image: _image,
      );

      int i = contacts.indexOf(args);

      contacts[i] = myContact;

      Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
    }
  }
}
