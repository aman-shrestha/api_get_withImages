import 'dart:convert';

import 'package:api_images/models/photos.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Photos> photosList = [];

  Future<List<Photos>> getPhotos () async{
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());
    // The jsonDecode function is part of Dart's dart:convert library. It takes a JSON string as input and parses it into a Dart object or map, depending on the structure of the JSON data. The resulting Dart object can be used to access and manipulate the data in your Flutter application.

    // The toString() method is called on the response.body. While it might seem redundant, this step ensures that response.body is treated as a string, as it converts the content into a string representation explicitly.
    if(response.statusCode == 200){
      for(Map i in data){
        Photos photos = Photos(title: i['title'], url: i['url'], id: i['id']);
        photosList.add(photos);
      }
      return photosList;
    } else {
      return photosList;
    }
  }
// For each map i in data, it extracts the values for keys 'title,' 'url,' and 'id' from the map and uses them to create a Photos object.

// The created Photos object is then added to the photosList.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API WITH IMAGES'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(future: getPhotos(), 
            builder: (context,AsyncSnapshot<List<Photos>> snapshot){
              return ListView.builder(
                itemCount: photosList.length,
                itemBuilder: (context, index){
                 return ListTile(
                  leading:CircleAvatar(
                    backgroundImage:  NetworkImage(snapshot.data![index].url.toString()),
                  ),
                  subtitle: Text(snapshot.data![index].title.toString()),
                  title: Text('Notes id:'+snapshot.data![index].id.toString()),
                 );
                },);
            }

            ),),
        ],
      ),
    );
  }
}