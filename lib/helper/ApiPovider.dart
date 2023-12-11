import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'customException.dart';


class ApiProvider{

  Future<dynamic> get(String url) async{
    var responseJson;
    try{
      final response = await http.get(Uri.parse(url));
      responseJson = _response(response);
    } on SocketException{
      throw FetchDataException('No Internet Connection');
    }
    return responseJson;
  }

  dynamic _response(http.Response response){
    switch(response.statusCode){
      case 200:
        var responseJson = jsonDecode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:

      case 403:
        throw UnauthorisedException(response.body.toString());
      case 500:

      default:
        throw FetchDataException(
          "Error occurred while communication with server with status code : ${response.statusCode}"
        );

    }
  }
}