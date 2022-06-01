import 'dart:async';
import 'model_class.dart';
import 'package:flutter/material.dart';
import 'add_contact_page.dart';
import 'detail_page.dart';
import 'edit_page.dart';
import 'package:url_launcher/url_launcher.dart';

bool isDark = false;

class myapp extends StatefulWidget {
  const myapp({Key? key}) : super(key: key);

  @override
  _myappState createState() => _myappState();
}

class _myappState extends State<myapp> {
  @override
  void initState(){
    super.initState();
    Timer.periodic(const Duration(milliseconds: 100), (val){
      setState(() {});
    });
  }

  final ThemeData _lightTheme = ThemeData(
    primaryColor: Colors.white,
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: Colors.black),
    ),
  );

  final ThemeData _darkTheme = ThemeData(
    primaryColor: Colors.black,
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: Colors.white),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _lightTheme,
      darkTheme: _darkTheme,
      themeMode: (isDark == false) ? ThemeMode.light : ThemeMode.dark,
      routes: {
        '/': (context) => homepage(),
        "add_contect_page": (context) => addcontect(),
        "detail_page": (context) => detail(),
        "edit_page": (context) => edit(),
      },
    );
  }
}



class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Contect",

        ),
        elevation: 0,
        actions: [
          GestureDetector(
            child: CircleAvatar(
              radius: 12,
              backgroundColor: Theme.of(context).appBarTheme.titleTextStyle!.color,
            ),
            onTap: (){
              setState(() {
                isDark = !isDark;
              });
            },
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,

            ),
          ),
        ],
      ),
      body: (contacts.isEmpty)
          ? Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Image(
              image: AssetImage('assets/images/box.png'),
              height: 150,
            ),
            SizedBox(height: 20),
            Text(
              "You have no contacts yet",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      )
          : ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, i) {
          return ListTile(
            onTap: () {
              Navigator.of(context).pushNamed(
                'detail_page',
                 arguments: contacts[i],
              );
            },
            leading: (contacts[i].image == null)
                ? CircleAvatar(
              radius: 25,
              backgroundColor: Colors.grey.shade400,
              child: Image.asset(
                'assets/images/user.png',
                height: 25,
                color: Colors.white,
              ),
            )
                : CircleAvatar(
              radius: 25,
              backgroundImage: (contacts[i].image != null)
                  ? FileImage(contacts[i].image!)
                  : null,
            ),
            title: Text(
              "${contacts[i].firstname} ${contacts[i].lastname}",
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
            ),
            subtitle: Text("+91 ${contacts[i].phone}"),
            trailing: IconButton(
              icon: const Icon(
                Icons.call,
                color: Colors.green,
                size: 30,
              ),
              onPressed: () async {
                String url = "tel:+918980723993";
                if (await canLaunch(url)) {
                  await launch(url);
                }
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed('add_contect_page');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}