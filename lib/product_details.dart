import 'dart:convert';
// import this to easily send HTTP request
import 'package:http/http.dart' as http;

import 'package:cloud_i5/model_class.dart';
import 'package:flutter/material.dart';


class product_details extends StatefulWidget {
   final String id;

  const product_details({Key? key, required this.id}) : super(key: key);

  @override
  State<product_details> createState() => _product_detailsState();
}

class _product_detailsState extends State<product_details> {

   var id;
final String apiUrl = 'https://task.cloudi5.com/api/products/';


//static const String ROOT = "https://task.cloudi5.com/api/products/";

//drop down value get



  Future<List<User>> fetchUsers() async {
    var response = await http.get(Uri.parse(apiUrl));
    return (json.decode(response.body)['data'] as List)
        .map((e) => User.fromJson(e))
        .toList();
  }


  @override
  void initState() {
    id = widget.id;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(child: Text(widget.id)),
      ),
    );
  }
}