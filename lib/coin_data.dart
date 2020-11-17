import 'dart:convert';
import 'package:http/http.dart' as http;
import 'constants.dart';

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      String requestURL =
          '$coinAPIURL/price?fsym=$crypto&tsyms=$selectedCurrency';

      http.Response response = await http.get(requestURL);
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double lastPrice = decodedData['$selectedCurrency'];
        cryptoPrices[crypto] = lastPrice.toString();
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}
