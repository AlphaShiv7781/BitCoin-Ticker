import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';
class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {

      List<String> crypto = [
        'BTC',
        'ETH',
        'LTC',
      ];
      List<double> data = [
        0.0,
        0.0,
        0.0,
      ];
    String selectedCurrency = 'USD' ;

    List<DropdownMenuItem<String>> getDroppedDownButton(){
      String currency;
      List<DropdownMenuItem<String>> currencyList = [];
      for(int i=0;i<currenciesList.length;i++)
        {
          currency = currenciesList[i];
            var dropdownlist = DropdownMenuItem(
                child: Text(currency),
               value: currency,
            );
            currencyList.add(dropdownlist);
        }
      return currencyList;
    }
    
    Future<dynamic> dataFetch(String coin)async{

       http.Response response = await http.get(Uri.parse('https://rest.coinapi.io/v1/exchangerate/$coin/$selectedCurrency?apikey=D77E1C31-704A-4563-AD0B-3DA0E0B9548A'));
       if(response.statusCode == 200)
         {

             var coinData = await jsonDecode(response.body);
             return  await coinData['rate'];
         }
       else
         {
            return response.statusCode;
         }
    }


    Future<void> caller()async{

      for(int i=0;i<crypto.length;i++)
        {
          var ex = await dataFetch(crypto[i]);
          setState(() {
            data[i] = ex;
            print(data[i]);
          });

        }
    }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child:  Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ${data.elementAt(0)} $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child:  Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 ETH = ${data.elementAt(1)} $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child:  Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 LTC = ${data.elementAt(2)} $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: DropdownButton<String>(
                value: selectedCurrency,
                items:  getDroppedDownButton(),
                onChanged: (value){
              setState(() {
                selectedCurrency = value!;
                caller();
              });
            }),
          ),
        ],
      ),
    );
  }
}
