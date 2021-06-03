import 'package:flutter/material.dart';
import 'package:flutter_app/data/locations.dart';
import 'package:flutter_app/models/Location.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'MyCustomForm.dart';

void main() {
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
      home:MyForm(),
    );
  }
}
class MyForm extends StatefulWidget{
  @override
  MyFormState createState() =>MyFormState();
}
class MyFormState extends State{
  @override
  Widget build(BuildContext Context){
    return Scaffold(
        appBar: AppBar(
          title: Text('MyApp'),
        ),
        body:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            TextField(
              decoration:InputDecoration(hintText:'name'),
            ),
            TextField(
              decoration:InputDecoration(hintText:'password'),
            ),
            ElevatedButton (
              //color:Theme.of(context).primaryColor,
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyList()),
                  );
                },
                child:Center(child: Text('press me'))
            )
          ],
        )

    );
  }
}

//class MyList extends StatelessWidget{
 // @override
 // Widget build(BuildContext context) {
  //  MyListState createState() =>MyListState();
 // }
//}
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
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyCustomForm())
            );
          },
        ),
        body:// Expanded(
      /* child:*/ ListView.builder(itemCount: locationsAll.listobj.length, itemBuilder: (context, index) {
    //SingleChildScrollView(child: YourBody()),

          return Card(

           // Flexible(
            child: InkWell(
              onTap: () {
                //onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Details(index))
                );
              },
    //child: SingleChildScrollView(
             // Expanded(
              child: Column(
                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                //title: new Center(
                  children: [
                    new Image.network(locationsAll.listobj[index].imageUrl),
                    Text(locationsAll.listobj[index].name),
                    Text(locationsAll.listobj[index].theme),



                  ]

              ),

    )
             // ),
        // )
         );
        }
        )
    );

    //);
  }


}
class Details extends StatelessWidget{
  int id;
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
  Details(int id){
    this.id=id;

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
              _launchInBrowser(locationsAll.listobj[id].locationUrl);

            },
        ),


        body:SingleChildScrollView(

    child: InkWell(
    child: Column(
    children:[

     new Image.network(locationsAll.listobj[id].imageUrl),
    Text(locationsAll.listobj[id].name),
    Text(locationsAll.listobj[id].description),
    ]

    )
    )

    ),
    );




  }}
