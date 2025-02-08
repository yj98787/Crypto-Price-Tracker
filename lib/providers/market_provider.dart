import 'dart:async';

import 'package:crypto_price_tracker/models/crypto_currency.dart';
import 'package:flutter/cupertino.dart';
import 'package:crypto_price_tracker/models/api.dart';

class MarketProvider with ChangeNotifier{

  bool isloading = true;
  List<CryptoCurrency> market = [];

  MarketProvider(){
    fetchData();
  }

  Future<void> fetchData ()async{
    List<dynamic> _markets = await API.getMarkets();

    List<CryptoCurrency> temp = [];

    for(var market in _markets){
      CryptoCurrency newCrypto = CryptoCurrency.fromJSON(market);
      temp.add(newCrypto);
    }
    market = temp;
    isloading = false;
    notifyListeners();

    // Timer(Duration(seconds: 3),(){
    //   fetchData();
    //   print("data updated!");
    // });
  }

  CryptoCurrency fetchCryptoById(String id){
    CryptoCurrency crypto = market.where((element)=> element.id == id).toList()[0];
    return crypto;
  }

}