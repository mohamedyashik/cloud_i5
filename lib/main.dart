import 'dart:io';

import 'package:cloud_i5/add_product.dart';
import 'package:cloud_i5/model_class.dart';
import 'package:cloud_i5/product_details.dart';
import 'package:flutter/material.dart';

// import this to be able to call json.decode()
import 'dart:convert';

// import this to easily send HTTP request
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:path/path.dart';





class MyHttpOverrides extends HttpOverrides {
@override
HttpClient createHttpClient(SecurityContext? context) {
return super.createHttpClient(context)
  ..badCertificateCallback =
      (X509Certificate cert, String host, int port) => true; }}

void main() async {
WidgetsFlutterBinding.ensureInitialized();
HttpOverrides.global = MyHttpOverrides();
runApp(MyApp());}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      theme: ThemeData(accentColor: Colors.amber),
      title: 'Dashboard',
      home: FirstScreen(),
    );
  }
}






class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final String apiUrl = "https://task.cloudi5.com/api/products";

  @override
  Widget build(BuildContext context) {
    return Scaffold(


               floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurpleAccent,
        child: Icon(Icons.add,color: Colors.black87,),
        splashColor: Colors.red,
        onPressed: (){
          Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Add_Product()));
        },
        ),
        appBar: AppBar(
          title: const Text('Dashboard'),
          backgroundColor:Color.fromARGB(255, 64, 196, 255),
        ),
        body: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(8),
          child: FutureBuilder<List<User>>(
            future: fetchUsers(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<User> users = snapshot.data as List<User>;
                return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: EdgeInsets.all(8),
                        padding: EdgeInsets.all(8),
                        color: Colors.white,
                        // child: Column(
                        //   children: [
                        //     Text(users[index].name),
                        //      Text(users[index].image),
                        //     Text(users[index].price.toString()),

                            

                        //   ],
                        // ),
                         child: ListTile(
                    
                              onTap: (){
                       Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      product_details(
                                                        // id: list[i]['ID'],
                                                        id:users[index].id.toString(),
                                                      )));
                    },
                        
                          title: Text(users[index].name,style: TextStyle(fontWeight: FontWeight.bold),),
                          trailing: Text('Rs '+users[index].price.toString(),style: TextStyle(fontWeight: FontWeight.w500)),


                          leading: users[index].image != null ? Card(
                        child: Container(
                                    width: 50,
                                    height: 50,
                                    // color: show_image == true ? Colors
                                    //     .white : Colors.white,
                                    child:Image.network(users[index].image),
                                  ),
                    ):Card(
                        child: Container(
                                    width: 50,
                                    height: 50,
                                    // color: show_image == true ? Colors
                                    //     .white : Colors.white,
                                    child:Image.network('https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.facebook.com%2Fsanthiladatabot%2F&psig=AOvVaw0SMaeIvSyhhHF45066KT_b&ust=1653786144673000&source=images&cd=vfe&ved=0CAwQjRxqFwoTCPDVkdL_gPgCFQAAAAAdAAAAABAJ'),
                                  ),
                    ),
                         ),
                       
                      );
                    });
              }
              if (snapshot.hasError) {
                print(snapshot.error.toString());
                return Text('error');
              }
              return CircularProgressIndicator();
            },
          ),
        ));
  }

  Future<List<User>> fetchUsers() async {
    var response = await http.get(Uri.parse(apiUrl));
    return (json.decode(response.body)['data'] as List)
        .map((e) => User.fromJson(e))
        .toList();
  }
}