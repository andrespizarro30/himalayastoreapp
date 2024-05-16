
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

Future<File> converURLImageToFile(String strURL) async{

  Uri uri = Uri.parse(strURL);

  final http.Response responseData = await http.get(uri);

  Uint8List uint8list = responseData.bodyBytes;

  var buffer = uint8list.buffer;

  ByteData byteData = ByteData.view(buffer);

  var tempDir = await getTemporaryDirectory();

  File file = await File('${tempDir.path}/My_Profile_Image.jpg').writeAsBytes(buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  return file;

}