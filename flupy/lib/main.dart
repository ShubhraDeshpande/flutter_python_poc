import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert'; // convert json into data
import 'package:http/http.dart' as http;
import 'package:flupy/hex_grid.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: HexGridWidgetExample()
//      ApiDemo(),
    );
  }
}

class ApiDemo extends StatefulWidget {
  ApiDemoState createState() => ApiDemoState();
}

class ApiDemoState extends State<ApiDemo>{
  final String url = "https://swapi.co/api/starships"; //starships is a node
  List data;

  Future<String> getSWData() async{
    var res = await http.get(Uri.encodeFull(url), headers: {"Accept": "application/json"}); //accepts only json

    setState(() {
      var resBody = json.decode(res.body);
      data= resBody["results"];
    });
    return "Success";

  }
  @override
  void initState(){
    super.initState();
    this.getSWData();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Calls from API demo"),
        backgroundColor: Colors.deepOrangeAccent,
      ),
      body: ListView.builder(itemBuilder: (BuildContext context, int index){
        return Container(
          child: Center(
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card( color: Colors.amberAccent,
                    child: Container(
                        height: 30,child: Text(data[index]["name"], style: TextStyle(fontSize: 18),)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Container(
                      height: 30,

                      child: Text(data[index]["model"]),
                    ),
                  ),
                )
              ],
            ),
          ),

        );

      },
      itemCount: data==null ? 0:data.length,

      ),
    );
  }
}
