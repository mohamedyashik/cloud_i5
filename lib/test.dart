// import "package:async/async.dart";

// import 'package:path/path.dart';

// import 'dart:io';

// import 'package:http/http.dart' as http;

// Future addProduct(File imageFile) async{
// // ignore: deprecated_member_use
// var stream= new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
// var length= await imageFile.length();
// var uri = Uri.parse("http://10.0.2.2/foodsystem/uploadg.php");

// var request = new http.MultipartRequest("POST", uri);

// var multipartFile = new http.MultipartFile("image", stream, length, filename: basename(imageFile.path));

// request.files.add(multipartFile);
// request.fields['productname'] = controllerName.text;
// request.fields['productprice'] = controllerPrice.text;
// request.fields['producttype'] = controllerType.text;
// request.fields['product_owner'] = globals.restaurantId;

// var respond = await request.send();
// if(respond.statusCode==200){
//   print("Image Uploaded");
// }else{
//   print("Upload Failed");
// }
// }