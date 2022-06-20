import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import "package:async/async.dart";

import 'package:path/path.dart';

import 'dart:io';

import 'package:http/http.dart' as http;

class Add_Product extends StatefulWidget {
  Add_Product({Key? key}) : super(key: key);

  @override
  State<Add_Product> createState() => _Add_ProductState();
}

class _Add_ProductState extends State<Add_Product> {

 int min = 1;
  int max = 10;
  TextEditingController qty_value = TextEditingController();



  Future addProduct(File _imageFileList1) async {
// ignore: deprecated_member_use
    print('send_data');
    var stream =
        new http.ByteStream(DelegatingStream.typed(_imageFileList1.openRead()));
    var length = await _imageFileList1.length();
    var uri = Uri.parse("http://192.168.43.222/dharani/product.php");

    var request = new http.MultipartRequest("POST", uri);

    var multipartFile = new http.MultipartFile("image", stream, length,
        filename: basename(_imageFileList1.path));

    request.files.add(multipartFile);
    request.fields['productname'] = userName;
    request.fields['productprice'] = price;
    request.fields['product_desc'] = desc;
    request.fields['qty_per_order'] = qty;

    var respond = await request.send();
    if (respond.statusCode == 200) {
      print("Image Uploaded");
    } else {
      print("Upload Failed");
    }
  }

  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  String userName = '';
  String qty = '';
  String instock = '';
  String price = '';
  String desc = '';
  var updated_image1 = "";
  List<XFile>? _imageFileList;
  List<XFile>? _imageFileList1;
  PickedFile? imageFile = null;
  String updated_image = "";

  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Choose option",
              style: TextStyle(color: Colors.blue),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () async {
                      final pickedFile = await ImagePicker().getImage(
                        source: ImageSource.gallery,
                      );
                      //
                      setState(() {
                        imageFile = pickedFile!;
                        print("hiiiiiiiiiiiiiiiii $_imageFileList1");
                        updated_image1 = "got";
                      });
                      Navigator.pop(context);
                    },
                    title: Text("Gallery"),
                    leading: Icon(
                      Icons.account_box,
                      color: Colors.blue,
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      camera_data();
                    },
                    title: Text("Camera"),
                    leading: Icon(
                      Icons.camera,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

    bool isChecked = false; 
    var isactive  = '1';
    var notactive  = '0';
    String activevalue = '0';

  Future<void> camera_data() async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    setState(() {
      imageFile = pickedFile!;
      print("hiiiiiiiiiiiiiiiii $_imageFileList1");
      updated_image1 = "got";
    });
    // Navigator.pop(context);
  }

  void _trySubmitForm() async {
    final bool? isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      if (kDebugMode) {
        print(price);
        print(instock);
        print(userName);
        print(qty);

        // addProduct(File? _imageFileList1);

        //  Navigator.of(context).pop();
      }

      Future addProduct(File _imageFileList1) async {
// ignore: deprecated_member_use
        var stream =
            http.ByteStream(DelegatingStream.typed(_imageFileList1.openRead()));
        var length = await _imageFileList1.length();
        var uri = Uri.parse("http://192.168.43.222/dharani/product.php");

        var request = http.MultipartRequest("POST", uri);

        var multipartFile = http.MultipartFile("image", stream, length,
            filename: basename(_imageFileList1.path));

        request.files.add(multipartFile);
        request.fields['productname'] = userName;
        request.fields['productprice'] = price;
        request.fields['product_desc'] = desc;
        request.fields['qty_per_order'] = qty;

        var respond = await request.send();
        if (respond.statusCode == 200) {
          print("Image Uploaded");
        } else {
          print("Upload Failed");
        }
      }
    } else {
      print('send all data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products Creation'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextFormField(
                    onChanged: (value) => userName = value,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'This field is required';
                      }
                      if (value.trim().length < 4) {
                        return 'Name must be at least 4 characters in length';
                      }
                      // Return null if the entered username is valid
                      return null;
                    },
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                  TextFormField(
                    onChanged: (value) => desc = value,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'This field is required';
                      }
                      if (value.trim().length < 4) {
                        return 'Description must be at least 4 characters in length';
                      }
                      // Return null if the entered username is valid
                      return null;
                    },
                    decoration: const InputDecoration(labelText: 'Description'),
                  ),
                  TextFormField(
                    onChanged: (value) => price = value,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'This field is required';
                      }
                      // Return null if the entered username is valid
                      return null;
                    },
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'Price',
                    ),
                  ),

                  
                  TextFormField(
                    onChanged: (value) => instock = value,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'This field is required';
                      }

                      // Return null if the entered username is valid
                      return null;
                    },
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(
                      labelText: 'In stock',
                    ),
                  ),
                  // TextFormField(
                  //   onChanged: (value) => qty = value,
                  //   validator: (value) {
                  //     if (value == null || value.trim().isEmpty) {
                  //       return 'This field is required';
                  //     }
                  //     // Return null if the entered username is valid
                  //     return null;
                  //   },
                  //   keyboardType:
                  //       const TextInputType.numberWithOptions(decimal: true),
                  //   decoration: const InputDecoration(
                  //     labelText: 'Qty Per Order',
                  //   ),
                  // ),
                  // const SizedBox(
                  //   height: 20,
                  // ),

 TextFormField(
  controller:qty_value,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter the Overall Stock';
              } else if (int.parse(value) < 1 || int.parse(value) > 10) {
                return 'The Stock must be between 1 and 10';
              }
              return null;
            },
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp("^(1[0-0]|[1-9])\$")),
            ],
            // inputFormatters: <TextInputFormatter>[
            //   FilteringTextInputFormatter.digitsOnly
            // ], // Only numbers can be entered
            maxLength: 2,
            //maxLengthEnforced: true,

            decoration: const InputDecoration(
              hintText: "Stock  Out of 1 to 10",
            ),
          ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          final List<XFile>? pickedFileList1 =
                              await _picker.pickMultiImage();

                          setState(() {
                            _imageFileList1 = pickedFileList1;
                            print("hiiiiiiiiiiiiiiiii $_imageFileList1");
                            updated_image1 = "got";
                          });
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          color: Colors.blue,
                          child: Container(
                            // color: Colors.blue,
                            height: 30,
                            width: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Choose Image",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          updated_image1 != ""
                              ? Card(
                                  child: Container(
                                    width: 50,
                                    height: 50,
                                    // color: show_image == true ? Colors
                                    //     .white : Colors.white,
                                    child: Image.file(
                                      File(_imageFileList1![0].path),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                )
                              : SizedBox.shrink(),
                        ],
                      ),
                    ],
                  ),





             Row(
               children: [
                Text('Stock List Shown'),
                 Checkbox(
                  value: isChecked,
                  onChanged: (value) async{
                    setState(() {
                      isChecked = value!;
                      activevalue='1';
                     
                 
                    });
                  },
                           ),
               ],
             ),
                  Center(
                    child: ElevatedButton(
                        child: const Text('Submit'),
                        onPressed: () async {
                          final bool? isValid =
                              _formKey.currentState?.validate();
                          if (isValid == true) {
                            
                            if (updated_image1 != "") {

                              print('Activatecheckbox'+' '+activevalue);


                              // setState(() {
                              //   if(isChecked=='true'){                
                              //     activevalue='0';

                              //   }else{
                              //       activevalue='1';
                              //   }
                              // });
                                print('activate'+''+activevalue);

                              var stream = new http.ByteStream(
                                  DelegatingStream.typed(
                                      _imageFileList1![0].openRead()));
                              var length =
                                  await await _imageFileList1![0].length();
                              var uri = Uri.parse(
                                  "https://task.cloudi5.com/api/products/store");

                              var request = http.MultipartRequest("POST", uri);

                              var multipartFile = http.MultipartFile(
                                  "image", stream, length,
                                  filename: _imageFileList1![0].path);

                              request.files.add(multipartFile);
                              request.fields['name'] = userName;
                              request.fields['price'] = price;
                              request.fields['description'] = desc;
                              request.fields['qty_per_order'] = qty_value.text;
                              request.fields['is_active'] = activevalue;
                              request.fields['in_stock'] = instock ;

                              var respond = await request.send();
                              if (respond.statusCode == 200) {
                                print("Image Uploaded");

                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text("Inserted Successfully....")));

                                Navigator.pop(context);
                              } else {
                                print("Upload Failed");

                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "Inserted  NOt Successfully")));
                              }
                         
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text("Please Select Image....")));
                            }

                                      } else {
                            print('Enter all Fiels!...');
                          }
                        }),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}


    // floatingActionButton: FloatingActionButton(
    //     backgroundColor: Colors.deepPurpleAccent,
    //     child: Icon(Icons.add,color: Colors.black87,),
    //     splashColor: Colors.red,
    //     onPressed: (){
    //       Navigator.push(context,
    //                   MaterialPageRoute(builder: (context) => Add_Product()));
    //     },
    //     ),