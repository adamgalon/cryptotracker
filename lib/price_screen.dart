import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'components/crypto_card.dart';
import 'constants.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'AUD';

  DropdownButton<String> androidDropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          getData();
        });
      },
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.grey[600],
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          getData();
        });
      },
      children: pickerItems,
    );
  }

  Map<String, String> coinValues = {};
  bool isWaiting = false;

  void getData() async {
    isWaiting = true;
    try {
      var data = await CoinData().getCoinData(selectedCurrency);
      isWaiting = false;
      setState(() {
        coinValues = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  Column makeCards() {
    List<CryptoCard> cryptoCards = [];
    for (String crypto in cryptoList) {
      cryptoCards.add(
        CryptoCard(
          cryptoCurrency: crypto,
          selectedCurrency: selectedCurrency,
          value: isWaiting ? '?' : coinValues[crypto],
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: cryptoCards,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Cryptocurrencies'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          //in the future will be added delate button and add button (no hardcoded currencies).
          Expanded(flex: 5,
            child: ListView(
              children: [
                CryptoCard(
                  cryptoCurrency: 'BTC',
                  value: isWaiting ? '?' : coinValues['BTC'],
                  selectedCurrency: selectedCurrency,
                ),
                CryptoCard(
                  cryptoCurrency: 'ETH',
                  value: isWaiting ? '?' : coinValues['ETH'],
                  selectedCurrency: selectedCurrency,
                ),
                CryptoCard(
                  cryptoCurrency: 'LTC',
                  value: isWaiting ? '?' : coinValues['LTC'],
                  selectedCurrency: selectedCurrency,
                ),
                CryptoCard(
                  cryptoCurrency: 'XRP',
                  value: isWaiting ? '?' : coinValues['XRP'],
                  selectedCurrency: selectedCurrency,
                ),
                CryptoCard(
                  cryptoCurrency: 'BCH',
                  value: isWaiting ? '?' : coinValues['BCH'],
                  selectedCurrency: selectedCurrency,
                ),
                CryptoCard(
                  cryptoCurrency: 'ALGO',
                  value: isWaiting ? '?' : coinValues['ALGO'],
                  selectedCurrency: selectedCurrency,
                ),
                CryptoCard(
                  cryptoCurrency: 'YFI',
                  value: isWaiting ? '?' : coinValues['YFI'],
                  selectedCurrency: selectedCurrency,
                ),
                CryptoCard(
                  cryptoCurrency: 'EOS',
                  value: isWaiting ? '?' : coinValues['EOS'],
                  selectedCurrency: selectedCurrency,
                ),
                CryptoCard(
                  cryptoCurrency: 'LTC',
                  value: isWaiting ? '?' : coinValues['LTC'],
                  selectedCurrency: selectedCurrency,
                ),
                CryptoCard(
                  cryptoCurrency: 'SUSHI',
                  value: isWaiting ? '?' : coinValues['SUSHI'],
                  selectedCurrency: selectedCurrency,
                ),
                CryptoCard(
                  cryptoCurrency: 'DOT',
                  value: isWaiting ? '?' : coinValues['DOT'],
                  selectedCurrency: selectedCurrency,
                ),
                CryptoCard(
                  cryptoCurrency: 'XSP',
                  value: isWaiting ? '?' : coinValues['XSP'],
                  selectedCurrency: selectedCurrency,
                ),
              ],
            ),
          ),
          Expanded(flex:1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                  onPressed: () {
                    print('add');
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
                    child: Icon(
                      Icons.add,
                      size: 70.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                Platform.isIOS ? iOSPicker() : androidDropdown(),
                FlatButton(
                  onPressed: () {
                    print('Clear');
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
                    child: Icon(
                      Icons.clear,
                      size: 70.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Container(
          //     height: 150.0,
          //     alignment: Alignment.center,
          //     padding: EdgeInsets.only(bottom: 30.0),
          //     color: Colors.black,
          //     child:
          // ),
        ],
      ),
    );
  }
}
