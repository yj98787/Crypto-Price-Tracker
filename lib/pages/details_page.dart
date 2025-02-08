import 'package:crypto_price_tracker/models/crypto_currency.dart';
import 'package:crypto_price_tracker/providers/market_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DetailsPage extends StatefulWidget {

  final String id;

  const DetailsPage({super.key, required this.id});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

Widget titleAndDetail(String title, String detail, CrossAxisAlignment crossAxisAlignment){
  return Column(
    crossAxisAlignment: crossAxisAlignment,
    children: [
      
      Text(title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 17.0,
      ),
      ),
      
      Text(detail,
      style: TextStyle(
        fontSize: 17.0,
      ),
      ),
    ],
  );
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(
              left: 20.0,
              right: 20.0,
            ),
            child: Consumer<MarketProvider>(
                builder: (context,marketProvider,child){
                  
                  CryptoCurrency currentCrypto = marketProvider.fetchCryptoById(widget.id);
                  
              return RefreshIndicator(
                onRefresh: ()async{
                  await marketProvider.fetchData();
                },
                child: ListView(
                children: [

                  ListTile(
                    contentPadding: EdgeInsets.all(0.0),
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(currentCrypto.image!),
                    ),
                    title: Text(currentCrypto.name! + "(${currentCrypto.symbol!.toUpperCase()})",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                    ),
                    subtitle: Text("₹ " + currentCrypto.currentPrice.toString(),
                    style: TextStyle(
                      color: Color(0xff0395eb),
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                    ),
                    ),
                  ),

                  SizedBox(
                    height: 20.0,
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Price Change (24h)",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                      ),
                    ],
                  ),

                  Builder(builder: (context){
                    double priceChange = currentCrypto.priceChange24!;
                    double priceChangePercentage = currentCrypto.priceChangePercentage24!;

                    if(priceChange<0){
                      return Text("${priceChangePercentage.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(4)})",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 23.0,
                        ),
                      );
                    }else{
                      return Text("+${priceChangePercentage.toStringAsFixed(2)}% (+${priceChange.toStringAsFixed(4)})",
                        style: TextStyle(
                            color: Colors.green,
                          fontSize: 23.0,
                        ),
                      );
                    }
                  }),

                  SizedBox(
                    height: 30.0,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetail("Market Cap", "₹ " + currentCrypto.marketCap!.toStringAsFixed(4),
                          CrossAxisAlignment.start),

                      titleAndDetail("Market Cap Rank", "#" + currentCrypto.marketCapRank.toString(),
                          CrossAxisAlignment.end),
                    ],
                  ),

                  SizedBox(
                    height: 20.0,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetail("Low 24h", "₹ " + currentCrypto.low24!.toStringAsFixed(4),
                          CrossAxisAlignment.start),

                      titleAndDetail("High 24h", "₹ " + currentCrypto.high24.toString(),
                          CrossAxisAlignment.end),
                    ],
                  ),

                  SizedBox(
                    height: 20.0,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetail("Circulating Supply", currentCrypto.circulatingSupply!.toInt().toStringAsFixed(4),
                          CrossAxisAlignment.start),
                    ],
                  ),

                  SizedBox(
                    height: 20.0,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      titleAndDetail("All Time Low", currentCrypto.atl!.toStringAsFixed(4),
                          CrossAxisAlignment.start),

                      titleAndDetail("All Time High", currentCrypto.ath!.toStringAsFixed(4),
                          CrossAxisAlignment.start),
                    ],
                  ),
                  Container(
                      child: SfCartesianChart(
                        // Initialize category axis
                          primaryXAxis: CategoryAxis(),

                          series: <LineSeries<SalesData, String>>[
                            LineSeries<SalesData, String>(
                              // Bind data source
                                dataSource:  <SalesData>[
                                  SalesData('Jan', 35),
                                  SalesData('Feb', 28),
                                  SalesData('Mar', 34),
                                  SalesData('Apr', 32),
                                  SalesData('May', 40)
                                ],
                                xValueMapper: (SalesData sales, _) => sales.year,
                                yValueMapper: (SalesData sales, _) => sales.sales
                            )
                          ]
                      )
                  )
                ],
                ),
              );
          },
          ),
      ),
      ),
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}
