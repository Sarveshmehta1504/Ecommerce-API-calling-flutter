import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var message = "";
  var productData = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apiCall();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ecommerce"),
        backgroundColor: Colors.amberAccent,
      ),
      body: ListView.builder(itemBuilder: (context,index){
          return ListTile(
            leading: Text(productData[index]["images"][0]),
            title: Text(productData[index]["title"].toString()),
            subtitle: Text(productData[index]["price"].toString()),
            trailing: Icon(Icons.arrow_right),
          );
      },itemCount: productData.length,
      ),
    );
  }

  void apiCall() async{
    var url = Uri.https('api.escuelajs.co','api/v1/products');
    var response = await http.get(
      url
    );
    var data = jsonDecode(response.body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    setState(() {
      productData = data;
    });

  }
}
