import 'dart:convert';

import 'package:http/http.dart' as http;

class API{

  static Future<List<dynamic>> getMarkets() async{
    try{
      Uri requestPath = Uri.parse("https://api.coingecko.com/api/v3/coins/markets?vs_currency=inr&per_page=100&page=1");
      var response = await http.get(requestPath);
      var decodeResponse = jsonDecode(response.body);

      final List<dynamic> markets = decodeResponse as List<dynamic>;
      return markets;
    }catch(ex){
      return [];
    }
  }
}