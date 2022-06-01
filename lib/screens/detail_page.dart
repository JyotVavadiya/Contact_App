import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'model_class.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share_plus/share_plus.dart';

class detail extends StatefulWidget {
  const detail({Key? key}) : super(key: key);

  @override
  _detailState createState() => _detailState();
}

class _detailState extends State<detail> {
  @override
  Widget build(BuildContext context) {
    dynamic args = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      appBar: AppBar(

        title: const Text(
          "Contect",

        ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,

          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          const CircleAvatar(
            radius: 12,
            backgroundColor: Colors.black,
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,

            ),
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            const SizedBox(height: 70),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(width: 150),
                (args.image == null)
                    ? CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey.shade400,
                  child: Image.asset(
                    'assets/images/user.png',
                    height: 50,
                    color: Colors.white,
                  ),
                )
                    : CircleAvatar(
                  radius: 50,
                  backgroundImage: FileImage(args.image),
                ),
                const SizedBox(width: 50),
                InkWell(
                  onTap: () {
                    setState(() {
                      contacts.remove(args);
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Center(
                                child:
                                Text("Are You Sure to delete this number?"),
                              ),
                              content: Container(
                                child: Row(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                            '/', (route) => false);
                                      },
                                      child: Text("Yes"),
                                    ),
                                    SizedBox(width: 20),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("No"),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    });
                    // Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                  },
                  child: const Icon(
                      Icons.delete

                  ),
                ),
                const SizedBox(width: 20),
                InkWell(
                  onTap: () {
                    setState(() {
                      Navigator.of(context)
                          .pushNamed('edit_page', arguments: args);
                    });
                  },
                  child: const Icon(
                    Icons.edit,

                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            Text(
              "${args.firstname} ${args.lastname}",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "+91 ${args.phone}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
            ),
            const SizedBox(height: 20),
            const Divider(

              indent: 20,
              endIndent: 20,
              thickness: 0.5,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FloatingActionButton(
                  onPressed: () async {
                    if (await canLaunch("tel: +91" + args.phone)) {
                      await launch("tel: +91" + args.phone);
                    }
                  },
                  child: Icon(Icons.call, color: Colors.white),
                  backgroundColor: Colors.green,
                  elevation: 0,
                ),
                FloatingActionButton(
                  onPressed: () async {
                    if (await canLaunch("sms: +91" + args.phone)) {
                      await launch("sms: +91" + args.phone);
                    }
                  },
                  child: Icon(Icons.message, color: Colors.white,),
                  backgroundColor: Colors.amber,
                  elevation: 0,
                ),
                FloatingActionButton(
                  onPressed: () async {
                    if (await canLaunch("mailto:" + args.email)) {
                      await launch("mailto:" + args.email);
                    }
                  },
                  child: Icon(Icons.email, color: Colors.white),
                  backgroundColor: Colors.blue,
                  elevation: 0,
                ),
                FloatingActionButton(
                  onPressed: () async {
                    await Share.share(args.phone);
                  },
                  child: Icon(Icons.share, color: Colors.white,),
                  backgroundColor: Colors.orange,
                  elevation: 0,
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Divider(

              indent: 20,
              endIndent: 20,
              thickness: 0.5,
            ),
          ],
        ),
      ),
    );
  }
}