import 'package:flutter/material.dart';
import 'package:flutter_app/data/locations.dart';
import 'package:flutter_app/main.dart';
import 'package:flutter_app/models/Location.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
//import 'flutter_app/flutter/lib/MyList.dart';
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {

  final _formKey = GlobalKey<FormState>();
  String locationName;
  String theme;
  String fullDescription;
  String imageURL;
  String locationURL;
  final _locationNameController = TextEditingController();
  final _themeController = TextEditingController();
  final _fullDescriptionController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _locationUrlController = TextEditingController();
  Location x;
  int id;
  void addItemToList(Location x){
    setState(() {
      locationsAll.listobj.insert(0,x);
      //msg.insert(0, 0);
    });
  }
  Widget _buildLocationName(){
    return TextFormField(
        controller: _locationNameController,
        decoration: InputDecoration(labelText: 'location name'),
        validator: (String value){
          if(value.isEmpty){
            return 'location name is required';
          }
        }
    );
  }
  Widget _buildTheme(){
    return TextFormField(
      controller: _themeController,
    decoration: InputDecoration(labelText: 'theme'),
    validator: (String value){
      if(value.isEmpty){
        return 'theme is required';
      }
    },
     );
  }
  Widget _buildFullDescription(){
    return TextFormField(
      controller: _fullDescriptionController,
    decoration: InputDecoration(labelText: 'full description'),
        validator:(String value){
      if(value.isEmpty){
        return 'description is required';
      }
    },
     );
  }
  Widget _buildImageURL(){
    return TextFormField(
      controller: _imageUrlController,
    decoration: InputDecoration(labelText: 'image url'),
    validator: (String value){
      if(value.isEmpty){
        return 'image url is required';
      }
    },
    );
  }
  Widget _buildLocationURL(){
    return TextFormField(
      controller: _locationUrlController,
    decoration: InputDecoration(labelText: 'location url'),
    validator: (String value){
      if(value.isEmpty){
        return 'location url is required';
      }
    },
    );
  }
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
    body: Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildLocationName(),
          _buildTheme(),
          _buildFullDescription(),
          _buildImageURL(),
          _buildLocationURL(),
          ElevatedButton(
            onPressed: () => {
              if (!_formKey.currentState.validate()) {

                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text('Processing Data')),
                ),



              }
              else
                {
                  locationName = _locationNameController.text,
                  theme = _themeController.text,
                  fullDescription = _fullDescriptionController.text,
                  imageURL = _imageUrlController.text,
                  locationURL = _locationUrlController.text,
                  id = (locationsAll.listobj.length)+1,
                  x = new Location(
                    id:id,
                    name:locationName,
                    theme: theme,
                    description: fullDescription,
                    imageUrl: imageURL,
                    locationUrl: locationURL,
                  ),
                 // locationsAll.listobj.add(x),
                  addItemToList(x),
                  Navigator.of(context).pop(),
                  MaterialPageRoute(builder: (context) => MyList()),
                },

            },
            child: Text('add', style: TextStyle(color: Colors.white, fontSize: 16,),),


          ),


        ],
      ),
    ),
    );

  }
}