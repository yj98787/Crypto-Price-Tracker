import 'package:flutter/material.dart';
import 'package:crypto_price_tracker/constants/themes.dart';
import 'package:crypto_price_tracker/models/crypto_currency.dart';
import 'package:crypto_price_tracker/pages/details_page.dart';
import 'package:crypto_price_tracker/providers/market_provider.dart';
import 'package:provider/provider.dart';

class Markets extends StatefulWidget {
  const Markets({super.key});

  @override
  State<Markets> createState() => _MarketsState();
}

class _MarketsState extends State<Markets> {
  @override
  Widget build(BuildContext context) {
    return Expanded(child: Consumer<MarketProvider>(
        builder: (context,marketProvider,child){
          if(marketProvider.isloading){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else{
            if(marketProvider.market.length>0){
              return RefreshIndicator(
                onRefresh: () async{
                  await marketProvider.fetchData();
                },
                child: ListView.builder(
                  itemCount: marketProvider.market.length,
                  itemBuilder: (context,index){
                    CryptoCurrency currentCrypto = marketProvider.market[index];
                    return ListTile(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailsPage(
                          id: currentCrypto.id!,
                        )));
                      },
                      contentPadding: EdgeInsets.all(0),
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: NetworkImage(currentCrypto.image!),
                      ),
                      title: Text(currentCrypto.name!+" #${currentCrypto.marketCapRank}"),
                      subtitle: Text(currentCrypto.symbol!.toUpperCase()),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("₹ " + currentCrypto.currentPrice!.toStringAsFixed(4),
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Color(0XFF0395EB),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Builder(builder: (context){
                            double priceChange = currentCrypto.priceChange24!;
                            double priceChangePercentage = currentCrypto.priceChangePercentage24!;

                            if(priceChange<0){
                              return Text("${priceChangePercentage.toStringAsFixed(2)}% (${priceChange.toStringAsFixed(4)})",
                                style: TextStyle(
                                  color: Colors.red,
                                ),
                              );
                            }else{
                              return Text("+${priceChangePercentage.toStringAsFixed(2)}% (+${priceChange.toStringAsFixed(4)})",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold
                                ),
                              );
                            }
                          }),
                        ],
                      ),
                    );
                  },
                ),
              );
            }else{
              return Text("Data not found");
            };
          }
        }
    ),
    );
  }
}
