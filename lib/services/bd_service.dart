import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class BdService {
  Future<String> sendInfo(File imageFile) async {
    // print("llego");
    // var request = http.Request(
    //     'GET', Uri.parse('http://10.0.2.2:5000/api?query=$imageFile'));

    // http.StreamedResponse response = await request.send();

    // if (response.statusCode == 200) {
    //   print(await response.stream.bytesToString());
    // } else {
    //   print(response.reasonPhrase);
    // }

    // var request =
    //     http.MultipartRequest('POST', Uri.parse('http://10.0.2.2:5000/api'));

    // request.files
    //     .add(await http.MultipartFile.fromPath("image", imageFile.path));

    // http.StreamedResponse response = await request.send();
    // if (response.statusCode == 200) {
    //   print(await response.stream.bytesToString());
    // } else {
    //   print(response.reasonPhrase);
    // }

    print("INICIO");
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://4ca9-2800-484-667d-7b6b-dd8f-7e32-4d4e-69b4.ngrok.io/api'));

    print("CONECTO");

    request.files
        .add(await http.MultipartFile.fromPath('image', imageFile.path));

    print("ENVIO");

    try {
      http.StreamedResponse response = await request.send();
      print("SIGO");

      if (response.statusCode == 200) {
        final data = jsonDecode(await response.stream.bytesToString());
        return data['msg'];
      } else {
        return "Error de conexión";
      }
    } catch (e) {
      return "Error en el servidor";
    }
  }
}
