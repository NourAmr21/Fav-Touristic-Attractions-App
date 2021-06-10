import 'package:flutter/material.dart';
import 'package:flutter_app/data/locations.dart';
import 'package:flutter_app/models/Location.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'MyCustomForm.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyForm(),
    );
  }
}

class MyForm extends StatefulWidget {
  @override
  MyFormState createState() => MyFormState();
}

class MyFormState extends State {
  @override
  Widget build(BuildContext Context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('MyApp'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(hintText: 'name'),
            ),
            TextField(
              decoration: InputDecoration(hintText: 'password'),
            ),
            ElevatedButton(
                //color:Theme.of(context).primaryColor,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyList()),
                  );
                },
                child: Center(child: Text('press me')))
          ],
        ));
  }
}

//class MyList extends StatelessWidget{
// @override
// Widget build(BuildContext context) {
//  MyListState createState() =>MyListState();
// }
//}
Widget NewList(BuildContext context, DocumentSnapshot snapshot) {
  Location location = new Location(
      name: snapshot['name'],
      theme: snapshot['theme'],
      description: snapshot['description'],
      imageUrl: snapshot['imageUrl'],
      locationUrl: snapshot['locationUrl']);

  return Card(

      // Flexible(
      child: InkWell(
    onTap: () {
      //onPressed: () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Details(location)));
    },
    //child: SingleChildScrollView(
    // Expanded(
    child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        //title: new Center(
        children: [
          new Image.network(location.imageUrl),
          Text(location.name),
          Text(location.theme),
        ]),
  ));
}

class MyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        // resizeToAvoidBottomInset: false;
        appBar: AppBar(
          title: Text("MyApp"),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => MyCustomForm()));
          },
        ),
        body: // Expanded(
            /* child:*/

            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('Locations')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return ListView.builder(
                    // ignore: deprecated_member_use
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context, int index) =>
                        NewList(context, snapshot.data.documents[index]),
                  );
                }));
  }
}

class Details extends StatelessWidget {
  int id;

  Location location;
  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        // enableJavaScript: true,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Details(Location location) {
    // this.id = id;
    this.location = location;
  }
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Details'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.map),
        onPressed: () {
          _launchInBrowser(location.locationUrl);
        },
      ),

      body: SingleChildScrollView(
          child: InkWell(
              child: Column(children: [
        new Image.network(location.imageUrl),
        Text(location.name),
        Text(location.description),
      ]))),
    );
  }
}
