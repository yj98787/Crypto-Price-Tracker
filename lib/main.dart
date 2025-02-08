import 'package:crypto_price_tracker/constants/themes.dart';
import 'package:crypto_price_tracker/models/local_storage.dart';
import 'package:crypto_price_tracker/pages/home_page.dart';
import 'package:crypto_price_tracker/providers/market_provider.dart';
import 'package:crypto_price_tracker/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<MarketProvider>(
          create: (context)=>MarketProvider()),

      ChangeNotifierProvider<ThemeProvider>(
          create: (context)=>ThemeProvider()),
    ],
      child: Consumer<ThemeProvider>(builder: (context,themeProvider,child){
        return MaterialApp(
          themeMode: themeProvider.themeMode,
          theme: lightTheme,
          darkTheme: darkTheme,
          home: HomePage(),
        );
      })

    );
  }
}
