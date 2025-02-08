import 'package:crypto_price_tracker/models/local_storage.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier{

  ThemeMode themeMode = ThemeMode.light;

  // ThemeProvider(String theme){
  //   if(theme == "light"){
  //     themeMode = ThemeMode.light;
  //   }else{
  //     themeMode = ThemeMode.dark;
  //   }
  // }

  void toggleTheme() {
    if(themeMode == ThemeMode.light){
      themeMode = ThemeMode.dark;
      // await LocalStorage.saveTheme("dark");
    }else{
      themeMode = ThemeMode.light;
      // await LocalStorage.saveTheme("light");
    }

    notifyListeners();
  }
}