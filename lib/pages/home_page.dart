import 'package:crypto_price_tracker/pages/favourites.dart';
import 'package:crypto_price_tracker/pages/markets.dart';
import 'package:crypto_price_tracker/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{
  
  // late TabController viewController;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   viewController = TabController(length: 2, vsync: this);
  // }
  
  @override
  Widget build(BuildContext context) {

    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context,listen: false);

    return Scaffold(
      body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(left: 20.0,right: 20.0,top: 20.0,bottom: 0.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Welcome Back!!",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Crypto Today",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40.0,
                    ),
                    ),
                    IconButton(onPressed: (){
                      themeProvider.toggleTheme();
                    },
                      padding: EdgeInsets.all(0),
                        icon: themeProvider.themeMode == ThemeMode.light? Icon(Icons.dark_mode) :
                      Icon(Icons.light_mode),
                    ),
                  ],
                ),

                Markets(),

                // TabBar(
                //   controller: viewController,
                //
                //   tabs: [
                //     Tab(
                //     child: Text("Markets", style: Theme.of(context).textTheme.bodyMedium,),
                //   ),
                //
                //   Tab(
                //     child: Text("Favourites"),
                //   ),
                // ],
                // ),

                // Expanded(
                //     child: TabBarView(
                //         controller: viewController,
                //         children: [
                //       Markets(),
                //       Favourites(),
                //     ]
                //     ),
                // ),

              ],
            ),
          ),
      ),
    );
  }
}
